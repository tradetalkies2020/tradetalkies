const User = require("../models/User");
const Constants = require("../models/constants");
const Help = require("../models/Help");
const async = require("async");
const { v4: uuidv4 } = require("uuid");

exports.getProfile = (req, res, next) => {
    const currentUser = req.session.user;
    if (currentUser) {
        var id = req.params.userid;
        var query = { _id: id };

        if (id.toString() === currentUser._id.toString()) {
            User.findOne({ _id: currentUser._id }, function (err, user_) {
                res.json({
                    currentuser: user_,
                });
            });
        } else {
            User.findOne(query, { password: 0 }, function (err, user) {
                if (err || !user) {
                    // if user profile not found, redirect to homepage
                    res.json({ message: `No user find for id: ${id}` });
                } else {
                    console.log(currentUser);
                    User.findOne(
                        {
                            _id: currentUser._id,
                        },
                        function (err, user_) {
                            res.json({
                                user: user,
                                currentUser: user_,
                            });
                        }
                    );
                }
            });
        }
    } else {
        res.status(401).json({
            message:
                "User not authorized. You sure you are in the right place pal?",
        });
    }
};

//This controller is for posting help queries in the help section
exports.postHelpQuery = (req, res, next) => {
    const category = req.body.category;
    const currentUser = req.session.user;
    const description = req.body.description;
    const today = new Date();
    const unique = uuidv4();
    //Can also include image files, for evidence
    Constants.findOne({ name: "help_category" })
        .select("value")
        .then((value) => {
            let helpCat = value.value;
            if (helpCat.includes(category)) {
                //If correct catgory found
                let helpData = {
                    userId: currentUser._id,
                    token: unique,
                    createdAt: today,
                    description: description,
                    helpType: category,
                };
                new Help(helpData).save();
                return res.json({
                    message: `Query added for user ID:${currentUser._id}.`,
                    token: unique,
                    helpData: helpData,
                });
            } else {
                //If category does not exist logic
            }
        });
};
