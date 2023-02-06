
import { Router } from "express";
import RouterPromise from 'express-promise-router';
import { Logger } from "tslog";
import config from "../settings/config";
import { ClientResponse } from "../utils/keycloak-client";

const router :Router = RouterPromise();
const logger: Logger<Router> = new Logger();




router.post('/:username/login', async (req, res, next) => {
    let clientResponse : ClientResponse = await config.kc_client.createUserTokens(req.params.username, req.body.password);
    if(clientResponse.result){
        res.status(200).send({tokens: clientResponse.result});
    }
    else{
        logger.error(clientResponse.error);
        res.status(500).send({error: clientResponse.error});
    }
});



router.post('/:username/signup', async (req, res, next) => {
    //! TODO:
});

router.post('/:username/logout', async (req, res, next) => {
    //! TODO:
});



/**
 * Test.. accessed for logged in user
 */
router.get('/:username/test', async (req,res,next) => {
    // TODO:
});

/**
 * Test.. accessed for all users
 */
router.get('/test', async (req,res,next) => {
    
});



export default router;



