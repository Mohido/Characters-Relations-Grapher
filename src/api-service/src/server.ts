import express from "express";
import helmet from "helmet";
import config from "./settings/config";
import { Logger } from "tslog";
import Routes from "./routes";
import fs from 'fs';
import cookieParser from 'cookie-parser';
import bodyParser from 'body-parser';
import session from 'express-session';


const app = express();
const logger = new Logger();

// Allows us to save data on the server. And can be edited to be saved on the DBs
app.use(session({
    secret: config.session_secret,
    resave: false,
    saveUninitialized: true,
    store: config.memory_store,
  }));

// Parse any request to the server.
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cookieParser());

// Initialize the server headers (check npm helmet for more details).
app.use(helmet());

// Setup the routes
app.use(Routes);

// Setup Error handler catchers.
// app.use(ErrorHandler);


// Starting the tls/normal server
if (config.tls_path && fs.existsSync(config.tls_path)) {
    // if the tls folder exist.
    let https = require("https");
    let privateKey = fs.readFileSync(`${config.tls_path}/tls.key`, "utf8");
    let certificate = fs.readFileSync(`${config.tls_path}/tls.crt`, "utf8");
    let credentials = { key: privateKey, cert: certificate };
    let httpsServer = https.createServer(credentials, app);
    httpsServer.listen(config.port, "localhost", (error) => {
        if (error) {
            logger.error(error);
        } else {
            logger.info(`Server running at http://localhost:${config.port} or http://${config.host_dns}:${config.port} (if you are inside the network)`);
        }
    });
    } else {
    app.listen(config.port, () => {
        logger.info(`Server running at http://localhost:${config.port} or http://${config.host_dns}:${config.port} (if you are inside the network)`);
    });
}