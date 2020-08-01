var express = require("express");
var app = express();
const path=require('path')
var port = process.env.PORT || 3000;
const dotenv = require("dotenv");
dotenv.config();
const MONGO_URI = `mongodb+srv://${process.env.MONGO_USER}:${process.env.MONGO_PASSWORD}@cluster0-dec2c.mongodb.net/${process.env.MONGO_DEFAULT_DATABASE}?retryWrites=true&w=majority`;
var cookieParser = require("cookie-parser");
var session = require("express-session");
const MongoDbSession = require("connect-mongodb-session")(session);
var morgan = require("morgan");
var mongoose = require("mongoose");
var bodyParser = require("body-parser");
var passport = require("passport");
var flash = require("connect-flash");
const dashboardRoutes = require("./routes/dashboard.js");
//var configDB = require("./config/database");
mongoose.connect(MONGO_URI);
require("./config/passport")(passport);
const store = new MongoDbSession({
    uri: MONGO_URI,
    collection: "sessions",
});
app.use(morgan("dev"));
app.use(express.static(path.join(__dirname, "public")));
app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));
app.use(bodyParser.json({ limit: "50mb" }));
app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader(
        "Access-Control-Allow-Methods",
        "OPTIONS, GET, POST, PUT, PATCH, DELETE"
    );
    res.setHeader(
        "Access-Control-Allow-Headers",
        "Content-Type, Authorization, Connection, Cookie"
    );
    next();
});
app.use(
    session({
        secret: "tradetalkies",
        saveUninitialized: true,
        store: store,
        cookie: { maxAge: 365 * 24 * 60 * 60 * 1000 },
        resave: true,
    })
);

app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions
app.use(flash()); // use connect-flash for flash messages stored in session

app.set("view engine", "ejs");

// app.use('/', function(req, res){
// 	res.send('Our First Express program!');
// 	console.log(req.cookies);
// 	console.log('================');
// 	console.log(req.session);
// });
app.use(dashboardRoutes);
require("./routes/authroutes")(app, passport);

app.listen(port);
console.log("Server running on port: " + port);
