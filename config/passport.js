var LocalStrategy = require("passport-local").Strategy;
const logger = require("../middleware/logger");
const bcrypt = require("bcrypt");
var User = require("../models/User");
var configAuth = require("./auth");
const FacebookStrategy = require("passport-facebook").Strategy;
const GoogleStrategy = require("passport-google-oauth").OAuth2Strategy;
const LinkedinStrategy = require("passport-linkedin-oauth2").Strategy;

module.exports = function (passport) {
    //serializing
    passport.serializeUser(function (user, done) {
        done(null, user.id);
    });

    //fetching user from id
    passport.deserializeUser(function (id, done) {
        User.findById(id, function (err, user) {
            done(err, user);
        });
    });
    //login-local user strategy
    passport.use(
        "local-login",
        new LocalStrategy(
            {
                usernameField: "email",
                passwordField: "password",
                passReqToCallback: true,
            },
            function (req, email, password, done) {
                process.nextTick(function () {
                    User.findOne({ "local.email": email }, function (
                        err,
                        user
                    ) {
                        if (err) return done(err);
                        if (!user)
                            return done(
                                null,
                                false,
                                req.flash("loginMessage", "No User found")
                            );
                        bcrypt.compare(password, user.local.password, function (
                            err,
                            result
                        ) {
                            if (result == true) {
                                return done(null, user);
                            } else {
                                return done(
                                    null,
                                    false,
                                    req.flash(
                                        "loginMessage",
                                        "inavalid password"
                                    )
                                );
                            }
                        });
                    });
                });
            }
        )
    );

    //Facebook strategy//

    passport.use(
        new FacebookStrategy(
            {
                clientID: configAuth.facebookAuth.clientID,
                clientSecret: configAuth.facebookAuth.clientSecret,
                callbackURL: configAuth.facebookAuth.callbackURL,
                profileFields: ["id", "name", "email", "displayName"],
            },
            function (accessToken, refreshToken, profile, done) {
                process.nextTick(function () {
                    User.findOne({ "facebook.id": profile.id })
                        .then((user) => {
                            if (user) {
                                return done(null, user);
                            } else {
                                try {
                                    console.log(profile);
                                    var newUser = new User();
                                    newUser.facebook.id = profile.id;
                                    newUser.facebook.token = accessToken;
                                    newUser.facebook.name = profile.displayName;
                                    if (profile.emails !== undefined) {
                                        newUser.facebook.email =
                                            profile.emails[0].value;
                                    }

                                    newUser.save(function (err) {
                                        if (err) {
                                            throw err;
                                        }
                                        return done(null, newUser);
                                    });
                                } catch (err) {
                                    console.log(err);
                                    logger.error(
                                        `An error occured in saving facebook data for use with profile ${profile}`
                                    );
                                }
                            }
                        })
                        .catch((err) => {
                            logger.error(
                                `Error ocurred for facebook login : ${err}`
                            );
                            done(err);
                        });
                });
            }
        )
    );

    //Google strategy//
    passport.use(
        new GoogleStrategy(
            {
                clientID: configAuth.googleAuth.clientID,
                clientSecret: configAuth.googleAuth.clientSecret,
                callbackURL: configAuth.googleAuth.callbackURL,
                profileFields: ["id", "name", "email", "displayName"],
            },
            function (accessToken, refreshToken, profile, done) {
                process.nextTick(function () {
                    User.findOne({ "google.id": profile.id })
                        .then((user) => {
                            if (user) {
                                return done(null, user);
                            } else {
                                try {
                                    console.log(profile);
                                    var newUser = new User();
                                    newUser.google.id = profile.id;
                                    newUser.google.token = accessToken;
                                    newUser.google.name = profile.displayName;
                                    if (profile.emails !== undefined) {
                                        newUser.google.email =
                                            profile.emails[0].value;
                                    }

                                    newUser.save(function (err) {
                                        if (err) {
                                            throw err;
                                        }
                                        return done(null, newUser);
                                    });
                                } catch (err) {
                                    console.log(err);
                                    logger.error(
                                        `An error occured in saving facebook data for use with profile ${profile}`
                                    );
                                }
                            }
                        })
                        .catch((err) => {
                            logger.error(
                                `Error ocurred for facebook login : ${err}`
                            );
                            done(err);
                        });
                });
            }
        )
    );

    //Linkedin Strategy
    passport.use(
        new LinkedinStrategy(
            {
                clientID: configAuth.linkedinAuth.clientID,
                clientSecret: configAuth.linkedinAuth.clientSecret,
                callbackURL: configAuth.linkedinAuth.callbackURL,
                profileFields: [
                    "id",
                    "first-name",
                    "last-name",
                    "email-address",
                ],
                scope:['r_emailaddress', 'r_liteprofile']
            },
            function (accessToken, refreshToken, profile, done) {
                process.nextTick(function () {
                    User.findOne({ "linkedin.id": profile.id })
                        .then((user) => {
                            if (user) {
                                return done(null, user);
                            } else {
                                try {
                                    //console.log(profile);
                                    var newUser = new User();
                                    newUser.linkedin.id = profile.id;
                                    newUser.linkedin.token = accessToken;
                                    newUser.linkedin.name = profile.displayName;
                                    if (profile.emails !== undefined) {
                                        newUser.linkedin.email =
                                            profile.emails[0].value;
                                    }
                                    console.log(newUser);

                                    newUser.save(function (err) {
                                        if (err) {
                                            throw err;
                                        }
                                        return done(null, newUser);
                                    });
                                } catch (err) {
                                    console.log(err);
                                    logger.error(
                                        `An error occured in saving facebook data for use with profile ${profile}`
                                    );
                                }
                            }
                        })
                        .catch((err) => {
                            logger.error(
                                `Error ocurred for facebook login : ${err}`
                            );
                            done(err);
                        });
                });
            }
        )
    );
};
