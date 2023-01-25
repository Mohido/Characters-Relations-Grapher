import express from "express";
import helmet from "helmet";
import config from "./settings/config";
import { Logger } from "tslog";
import routes from "./routes/routes";

const app = express();
const logger = new Logger();

const PORT = config.port;
const HOST = config.host;

// Parse any POST request to the server.
app.use(express.json());

// Check server headers (check npm helmet for more details).
app.use(helmet());

app.listen(PORT, () => {
    logger.info(`Server running at http://${HOST}:${PORT}`);
    routes(app);
});