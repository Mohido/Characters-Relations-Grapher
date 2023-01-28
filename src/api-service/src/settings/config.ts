/** 
 * What is this file?
 * 
 *  - This file contains the configurations of the whole api. Expect the configuration to be used within any of the API modules.
 *  - All the configuration can be set to the service environment variables and the API will read it from there.
 * 
 * 
 */
import {MemoryStore} from 'express-session';


export interface APIConfiguration {
    port: number,
    host_dns: string,
    auth_service: string,
    postgre_service: string,
    tls_path?: string,
    memory_store?: any,
    session_secret? : string
};

export default {
    port: process.env.PORT || 5001,
    host_dns: process.env.HOSTNAME || "api-service",
    auth_service:  process.env.AUTH_URL || "keycloak-service",
    postgre_service: process.env.POSTGRE_URL || "postgre-service",
    memory_store : new MemoryStore(),
    session_secret : "this is a secret"
} as APIConfiguration;