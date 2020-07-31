var User = require("../models/User");
const authController = require("../controllers/auth");
const { validator } = require("../middleware/validator");
const { validationResult } = require("express-validator");
const logger = require("../middleware/logger");
const isAuth = require("../middleware/isAuth");
module.exports = function (app, passport) {
    app.post("/login", validator, (req, res, next) => {
        //Using passport for authentication of local user
        passport.authenticate("local-login", function (err, user, info) {
            const errorMessages = req.flash("loginMesage");
            if (errorMessages.length > 0) {
                return res.status(402).json({ message: errorMessages[0] });
            } else if (user != false) {
                const firebaseToken = req.body.firebaseToken;

                User.findOneAndUpdate(
                    { _id: user._id },
                    { $set: { firebaseToken: firebaseToken } },
                    { new: true }
                ).then((user) => {
                    req.session.isLoggedIn = true;
                    req.session.user = user;
                    req.session.save();
                    console.log(
                        `from authroutes.js, logging user in : ${user}`
                    );
                    logger.info(
                        `from authroutes.js, logging user in : ${user}`
                    );
                    return res.json({ message: "User logged in", user: user });
                });
            } else {
                return res.json({ errorMessage: "Invalid format" });
            }
        })(req, res, next);
    });

    app.post("/signup", validator, authController.postSignup);

    //Facebook redirection to its server
    app.get(
        "/auth/facebook",
        passport.authenticate("facebook", { scope: ["email"] })
    );

    // Facebook will redirect the user to this URL after approval.  Finish the
    // authentication process by attempting to obtain an access token.  If
    // access was granted, the user will be logged in.  Otherwise,
    // authentication has failed.
    app.get("/auth/facebook/callback", (req, res, next) => {
        passport.authenticate("facebook", (err, user, info) => {
            try {
                if (err) throw err;
                req.session.isLoggedIn = true;
                req.session.user = user;
                req.session.save();
                return res.json({ message: "Facebook login done", user: user });
            } catch (exc) {
                console.log(
                    `Error in saving user from facebook login for user ${exc}`
                );
            }
        })(req, res, next);
    });

    //Google authentication//
    //Google  redirection to its server
    app.get(
        "/auth/google",
        passport.authenticate("google", { scope: ["profile", "email"] })
    );

    //Google sending us back data
    app.get("/auth/google/callback", (req, res, next) => {
        passport.authenticate("google", (err, user, info) => {
            try {
                if (err) throw err;
                req.session.isLoggedIn = true;
                req.session.user = user;
                req.session.save();
                return res.json({ message: "Google login done", user: user });
            } catch (exc) {
                console.log(
                    `Error in saving user from google login for user ${exc}`
                );
            }
        })(req, res, next);
    });

    app.get(
        "/auth/linkedin",
        passport.authenticate("linkedin", {
            scope: ["r_emailaddress", "r_liteprofile"],
        })
    );
    app.get("/auth/linkedin/callback", (req, res, next) => {
        passport.authenticate("linkedin", (err, user, info) => {
            try {
                if (err) throw err;
                req.session.isLoggedIn = true;
                req.session.user = user;
                req.session.save();
                return res.json({ message: "Linkedin login done", user: user });
            } catch (exc) {
                console.log(
                    `Error in saving user from linkedin login for user ${exc}`
                );
            }
        })(req, res, next);
    });

    //merging local login and signup in single endpoint

    app.post("/local-signin", validator, authController.mergedLogin);

    //Google anroid signin logic

    app.post("/android-google-login", authController.androidGoogleAuth);
    app.post("/android-facebook-login", authController.androidFacebookAuth);

    //android logic ends here//
    app.post("/passwordreset", authController.postReset);
    app.get("/reset/:token", authController.getNewPassword);
    app.post("/new-password", authController.postNewPassword);
};
