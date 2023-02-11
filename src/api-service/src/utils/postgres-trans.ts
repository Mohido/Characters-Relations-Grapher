import {Pool, PoolConfig, QueryConfig, QueryResult, PoolClient, QueryResultRow} from "pg";


interface TransactionResult{
    result?: any, error?:any
}

export class PostgreTransactioner{

    //PUBLIC
    constructor (config: PoolConfig) {
        this.m_pg_pool = new Pool(config);  // A pool contains the connection to the database.
        this.m_pg_pool.on('error', (err, client) => {
            client.query('ROLLBACK');
            client.release();
            throw new Error(err);
        });
    }

    /**
     * A function that uses the pool to quickly query some data. Not the best use for data manipulation. 
     * For complex data transation, please use the "start", "execute", "end" methods.
     * 
     * This function might throw an error if the configuration to the postgres is wrong
     * @param query : PostgreSQL query
     * @returns 
     */
    async query(query: string): Promise<QueryResult> {
        return await this.m_pg_pool.query(query);
    };


    /**
     * Starts a transaction and stores the transaction client internally. 
     * After this command, please use the "execute" commands to register transactions. Make sure to call the "end" method
     * after done with data manipulation. Otherwise, the data won't be written to the database.
     * 
     * @returns : Same instance of the class
     */
    async start(): Promise<PostgreTransactioner>{
        this.m_pg_client = await this.m_pg_pool.connect();
        this.m_pg_client.query('BEGIN');
        return this;
    }

    /**
     * Executes a transaction. This method creates a transaction (data write/read request to the database).
     * Make sure to use the "end" method to confirm the transaction.
     * @param query : PostgreSQL query
     * @returns : Result of the Query
     */
    async execute(query: string): Promise<QueryResult>{
        if(!this.m_pg_client){
            throw new Error("Transaction is not started. Please call the start() method before executing transactions. Or use query() for fast querying");
        }
        return await this.m_pg_client.query(query);
    }

    /**
     * End the transaction. Must be used to submit the changes to the database.
     * @returns : Same instance of the class
     */
    async end(): Promise<PostgreTransactioner>{
        if(!this.m_pg_client){
            throw new Error("Transaction is not started. Please call the start() method before executing transactions. Or use query() for fast querying");
        }
        this.m_pg_client.query('COMMIT');
        this.m_pg_client.release();
        this.m_pg_client = undefined;
        return this;
    }

    //PRIVATE
    private m_pg_client: PoolClient;
    private m_pg_pool: Pool;
}