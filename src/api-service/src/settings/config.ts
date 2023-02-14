/** 
 * What is this file?
 * 
 *  - This file contains the configurations of the whole api. Expect the configuration to be used within any of the API modules.
 *  - All the configuration can be set to the service environment variables and the API will read it from there.
 * 
 * 
 */
import {MemoryStore} from 'express-session';
import { KeycloakClient } from '../utils/keycloak-client';
import { PostgreTransactioner } from '../utils/postgres-trans';

namespace API{
   
    export interface ServiceConfiguration{
        api_port: number,
        api_dns: string,            // Current API domain name. e.g: www.hello.com
        auth_dns: string,           // Authentication Service domain name. e.g: www.hello.com
        postgre_dns: string,        // PostgreSQL Database service domain name. e.g: www.hello.com
        tls_path?: string,
        memory_store?: any,
        session_secret? : string,
        kc_client?: KeycloakClient,
        pg_client? : PostgreTransactioner
    }
}




/**
 * 
 * This export contains all the data required to run the api. Most of the data come from environment variables.
 */
let memory_store : MemoryStore = new MemoryStore();
export default {
    api_port: process.env.API_PORT || 5001,
    api_dns: process.env.API_DNS || "localhost",
    auth_dns:  process.env.AUTH_DNS || "localhost",
    memory_store : memory_store,
    session_secret : process.env.SESSION_SECRET || "this is a secret",
    kc_client : new KeycloakClient({
        client_id: process.env.KC_CLIENT_ID as string,
        client_secret: process.env.KC_CLIENT_SECRET,
        client_realm: process.env.KC_REALM,
        keycloak_url: `http://${process.env.AUTH_DNS}:${process.env.AUTH_PORT || 8081}/auth/`
    }, memory_store),
    pg_client : new PostgreTransactioner({
        user: process.env.DB_USER,                  // e.g: 'dbuser',
        host: process.env.POSTGRE_DNS,              // e.g: 'database.server.com',
        database: process.env.DB_NAME,              // e.g: 'mydb',
        password: process.env.DB_PASSWORD,          // e.g: 'secretpassword',
        port: parseInt(process.env.DB_PORT)         // e.g: 3211,
    })
} as API.ServiceConfiguration;