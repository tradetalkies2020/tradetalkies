const mongoose = require("mongoose");

const Schema = mongoose.Schema;

var activitySchema = new Schema({
    userId: { type: Schema.Types.ObjectId, ref: "User" },
    activity: [
        {
            endpoint: { type: String, required: true },
            time: { type: Date, required: true },
            _id:false
        },
    ],
});

module.exports = mongoose.model("Activity", activitySchema);
