const mongoose = require("mongoose");

const Schema = mongoose.Schema;

var repostSchema = new Schema({
    userId: { type: Schema.Types.ObjectId, ref: "User" },
    tickers: [{ type: String }],
    desc: { type: String, required: true },
    createdAt: { type: Date, default: Date.now() },
    updatedAt: { type: Date },
    images: [{ type: String }],
    likes: [{ like:{type: Schema.Types.ObjectId, ref: "User"},time:Date ,_id:false}],
    repostFrom:{type:Schema.Types.ObjectId,ref:'Post'}
});


module.exports = mongoose.model("Repost", repostSchema);
