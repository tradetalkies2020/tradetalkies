const mongoose = require("mongoose");

const Schema = mongoose.Schema;
const commentSchema = new Schema({
    postId: { type: Schema.Types.ObjectId, ref: "Post" },
    comments: [
        {
            comment: { type: String, required: true },
            tickers: [{ type: String }],
            postedBy: {
                type: Schema.Types.ObjectId,
                ref: "User",
                required: true,
            },
            createdAt: { type: Date, default: Date.now() },
            markDel: { type: Boolean, default: false },
        },
    ],
});

module.exports = mongoose.model("Comment", commentSchema);
