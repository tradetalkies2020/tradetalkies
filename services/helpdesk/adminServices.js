const async = require("async");
const Constants = require("../../models/constants");
exports.updateHelpCategories = (name, value) => {
    return new Promise((resolve,reject)=>
    {
        Constants.findOneAndUpdate(
            { name: name },
            { $set: { value: value } },
            { new: true },
            async (err, result) => {
                if (err) {
                    logger.error("Error in updating constant data", err);
                    return reject({
                        message: "error in updating constant data",
                        err: err,
                    });
                }
                return resolve({
                    message: `Updated constant value`,
                    result: result,
                });
            }
        );
    })
   
};
