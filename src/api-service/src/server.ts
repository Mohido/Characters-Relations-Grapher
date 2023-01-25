import express from "express";
import bodyParser from "body-parser";
import helmet from "helmet";
import morgan from "morgan";

const app = express();
const PORT = "8000";
const logger = morgan('combined');

// Parse any POST request to the server.
app.use(bodyParser.json());

// Check server headers (check npm helmet for more details).
app.use(helmet());

app.listen(PORT, () => {
    console.log("running wow!")
});