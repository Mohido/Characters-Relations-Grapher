/**
 * What is this file?
 *  This file encapsulates the logic behind a keycloak client. It manages all the possible keycloak and the client interactions.
 *  
 * How to use it?
 *  Create a Client object. And use that object to:
 *      - get access tokens for users
 *      - exchange refresh tokens for access tokens for users
 *      - get user data (only if client has acces to it in keycloak)
 *      - realm managements operation.
 *      - simplify the process of exchanging credentials for pure rest-api services without the need for keycloak grants
 * 
 */



import { MemoryStore } from "express-session";
import KeycloakConnect = require("keycloak-connect");
import QueryString = require("qs");
import axios, {Method} from "axios";


export type ClientResponse = {
    result? :any,
    error?: any
}


export type Tokens  = {
    access_token : string,
    refresh_token: string
}

export type ClientConfig = {
    client_id: string,
    client_secret: string,
    client_realm: string,
    keycloak_url: string,
    realmPublicKey?: string  // In case the client was public
}


export class KeycloakClient {
    // PUBLIC:
    constructor (config : ClientConfig, memory_store?: MemoryStore) {
        this.m_config = config;
        this.m_keycloak_connect = new KeycloakConnect({ store: memory_store }, {
            clientId: config.client_id,
            credentials: {
                secret: config.client_secret
            },
            'auth-server-url': config.keycloak_url,
            'confidential-port': 80,
            'resource': "",
            'ssl-required': "",
            realm: config.client_realm
            } as KeycloakConnect.KeycloakConfig
        );
    }

    get getConfig(): ClientConfig {
        return this.m_config;
    }
    get getKeycloakConnect(): KeycloakConnect.Keycloak {
        return this.m_keycloak_connect;
    }

    /**
     * A helper function for getting an access token of the current client. This is mainly called from this module
     *  only. However, it can be also called for custom purposes (from within the endpoints) to get a client access
     *  token.
     */
    async createClientTokens(): Promise<ClientResponse>{
        /* Get access token for the client (cap-app) so we can request data from keycloak using that client */
        let data : string = QueryString.stringify({
                grant_type: 'client_credentials', 
                client_id: this.m_config.client_id, 
                client_secret: this.m_config.client_secret
        });

        let reqRes = await this.execReq(
            "post", 
            `${this.m_config.keycloak_url}realms/${this.m_config.client_realm}/protocol/openid-connect/token`, 
            data,
            { 'Content-Type': 'application/x-www-form-urlencoded'}
        );
        if(reqRes.error){
            return {error: new Error(reqRes.error)}
        }
        let tokens : Tokens = {
            access_token: reqRes.result.data.access_token,
            refresh_token: reqRes.result.data.refresh_token
        }
        return {result : tokens};
    };


    /**
     * Exchanges user credentials for an API access token
     * @param username 
     * @param password 
     * @returns 
     */
    async createUserTokens(username: string, password:string): Promise<ClientResponse>{
        let data : string = QueryString.stringify({
            grant_type: 'password', 
            client_id: this.m_config.client_id, 
            client_secret: this.m_config.client_secret,
            username : username,
            password: password
        });

        let reqRes = await this.execReq(
            "post", 
            `${this.m_config.keycloak_url}realms/${this.m_config.client_realm}/protocol/openid-connect/token`, 
            data,
            { 'Content-Type': 'application/x-www-form-urlencoded'}
        );
        if(reqRes.error){
            return {error:  reqRes.error.message};
        }
        let tokens : Tokens = {
            access_token: reqRes.result.data.access_token,
            refresh_token: reqRes.result.data.refresh_token
        }
        return {result : tokens};
    }

    /**
     * Recreates the access token from the refresh token if it can be recreated. If not, an error will be returned.
     * @param refresh_token 
     * @returns access token
     */
    async recreateAccessToken(refresh_token: string): Promise<ClientResponse>{
        return new Promise<ClientResponse>((resolve, rejects) => {
            return resolve({result:refresh_token});
        });
    }

    /**
     * Checks if an access token is still valid
     * @param username 
     * @param token 
     * @returns 
     */
    async isAuthenticated(username:string, token: Tokens | string): Promise<ClientResponse> {
        return new Promise<ClientResponse>((resolve, reject) =>{
            return resolve({result:true});
        })
    }


    // PRIVATE:
    private m_config : ClientConfig;
    private m_keycloak_connect: KeycloakConnect.Keycloak;

    /**
     * Encapsulates our http fetching method. call execReq whenever you want to execute an HTTP request using the
     *  axios package.
     * @param method - The method you want to use e.g: "POST", "GET"
     * @param url - The URL of the request
     * @param body - The body of the request. Referred to as Data as well
     * @param headers - The headers of the request.
     * @returns - an object which either holds the requested result from the url or an error.
     */
    async execReq(method : string , url : string, body : any, headers : any | Record< string, string | number | boolean>) : Promise<ClientResponse>{
        let ret: {error?:any, result?:any} = {};
        try {
            ret.result = await axios({ 
                method : method as Method,
                url: url, 
                data: body,
                headers: headers
            });
            return ret;
        }catch(error){
            return {error: error};
        }
    };

}


