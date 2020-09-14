const mongoose = require("mongoose");

const Schema = mongoose.Schema;
var followSchema = new Schema({
    userId: { type: Schema.Types.ObjectId, ref: "User" },
    followers: [{ type: Schema.Types.ObjectId, ref: "User", _id: false }],
    following: [{ type: Schema.Types.ObjectId, ref: "User", _id: false }],
});

module.exports = mongoose.model("Follow", followSchema);
