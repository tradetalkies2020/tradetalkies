const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const messageSchema = new Schema({
    messages: [
        new Schema(
            {
                message: String,
                images: [{ type: String }],
                tickers:[{ype:String}],
                createdAt: { type: Date },
            },
            { _id: false }
        ),
    ],
    userid: { type: Schema.Types.ObjectId, ref: "User" },
    chatId: { type: Schema.Types.ObjectId, ref: "Chat" },
});

module.exports = mongoose.model("Message", messageSchema);
