
import { Router } from "express";
import RouterPromise from 'express-promise-router';
import { Logger } from "tslog";

const router :Router = RouterPromise();
const logger: Logger<Router> = new Logger();


router.get('/', (req, res, next) => {
    logger.silly("I am a silly log.");
    logger.trace("I am a trace log.");
    logger.debug("I am a debug log.");
    logger.info("I am an info log.");
    logger.warn("I am a warn log with a json object:", { foo: "bar" });
    logger.error("I am an error log.");
    // logger.fatal(new Error("I am a pretty Error with a stacktrace."));
    return res.status(200).send("Hello");
});



export default router;



