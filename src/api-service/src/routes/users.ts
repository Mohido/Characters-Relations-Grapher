
import { Router } from "express";
import RouterPromise from 'express-promise-router';
import { Logger } from "tslog";


const logger: Logger<Router> = new Logger();
const router :Router = RouterPromise();




router.post('/:username/login', async (req, res, next) => {
    
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



