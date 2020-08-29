const upload = require("../config/s3Service");
const singleUpload = upload.single("image");
exports.testUpload = (req, res, next) => {
    singleUpload(req, res, function (err) {
        if (err) {
            let errorData = {
                errors: [
                    {
                        title: "Error in uploading image",
                        detail: err.message,
                    },
                ],
            };
            console.log(errorData);
        }
        return res.json(req.file.location);
    });
};

