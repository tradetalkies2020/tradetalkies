const mongoose = require("mongoose");

const Schema = mongoose.Schema;
var groupSchema = new Schema(
    {
        createdAt: {
            type: Date,
            default: Date.now(),
        },
        admin:{type:Schema.Types.ObjectId,ref:"User"},
        users: [
            new Schema(
                {
                    userid: {
                        type: Schema.Types.ObjectId,
                        required: true,
                        index: true,
                        ref: "User",
                    },
                    unread: {
                        type: Number,
                        default: 0,
                    },
                },
                { _id: false }
            ),
        ],
        lastMessage: String,
        lastTimestamp: Date,
        unmatched: {
            type: Boolean,
            default: false,
        },
        deActivated: {
            type: Boolean,
            default: false,
        },
        unmatchedBy: {
            type: String,
        },
        unmatchedOn: Date,
    },
    {
        collection: "group",
        toJSON: { virtuals: true },
        usePushEach: true,
    }
);

module.exports = mongoose.model("Group", groupSchema);
