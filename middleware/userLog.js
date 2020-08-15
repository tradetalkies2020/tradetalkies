const Activity = require("../models/Activity");
module.exports = function (req, res, next) {
    const currentUser = req.session.user;
    Activity.findOneAndUpdate(
        { userId: currentUser._id },
        { $push: { activity: {endpoint:`${req.method} ${req.route.path}`,time:Date.now()} } },
        { new: true },
        async (err, result) => {
            if (err) {
                logger.error("Error in updating user activity data", err);
                return next();
            }
            next();
        }
    );
};
