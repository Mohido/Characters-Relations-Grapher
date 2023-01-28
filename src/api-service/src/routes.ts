import { Router } from "express";
import RouterPromise from 'express-promise-router';
import UsersRouter from './routes/users';


const router : Router = RouterPromise();

/* Importing Routers */
router.use('/users', UsersRouter);



export default router;