import { Router } from "express";
import RouterPromise from 'express-promise-router';
import UsersRouter from './users';
import config from "../settings/config";
import { ClientResponse } from "../utils/keycloak-client";
import { Logger } from "tslog";


const logger: Logger<Router> = new Logger();
const router : Router = RouterPromise();

/* Importing Routers */
router.use('/users', UsersRouter);

/**
 * A simple endpoint for connection testing purposes.
 */
router.get('/test-postgres', async (req, res, next)=>{
    try{
        let result = await config.pg_client.query("SELECT * FROM public.users ORDER BY id ASC;");
        logger.debug(result);
        res.status(200).send({result});
    }catch(error){
        logger.error(error);
        res.status(500).send({error});
    }
})

/**
 * Just a simple endpoint for testing purposes
 */
router.get('/test-keycloak', async (req, res, next) => {
    let clientResponse : ClientResponse = await config.kc_client.createUserTokens(req.body.username, req.body.password);
    if(clientResponse.result){
        res.status(200).send({tokens: clientResponse.result});
    }
    else{
        logger.error(clientResponse.error);
        res.status(500).send({error: clientResponse.error});
    }
})


export default router;