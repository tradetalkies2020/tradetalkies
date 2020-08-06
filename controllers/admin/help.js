const User = require("../../models/User");
const Constant = require("../../models/constants");
const adminHelpService = require("../../services/helpdesk/adminServices");
const { loggers } = require("winston");

exports.updateHelpCategories = (req, res, next) => {
    const newCategory = req.body.category;
    Constant.findOne({ name: "help_category" })
        .select("value")
        .then(async (helpCat) => {
            let value = helpCat.value;
            let newValue = [...value, ...newCategory];
            let addCat = adminHelpService.updateHelpCategories(
                "help_category",
                newValue
            );
            addCat
                .then((result) => {
                    res.json({
                        result: result,
                        message: `Catgory added to help.`,
                    });
                })
                .catch((err) => {
                    logger.error(`Error in admin help service : ${err}`);
                    return res.json({ error: err });
                });
        })
        .catch((err) => {
            logger.error(`Error in updating constant value: ${err}`);
            return res.json({ error: err });
        });
};

