const { createLogger, transports, format } = require("winston");
const path = require("path");
var logDir = "logs";
const logger = createLogger({
    transports: [
        new transports.File({
            filename: path.join(logDir, "error.log"),
            level: "error",
            format: format.combine(format.timestamp(), format.json()),
        }),
        new transports.File({
            filename: path.join(logDir, "info.log"),
            level: "info",
            format: format.combine(format.timestamp(), format.json()),
        }),
    ],
});

module.exports = logger;
