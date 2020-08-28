const mongoose = require("mongoose");

const Schema = mongoose.Schema;
var userSchema = new Schema({
    local: {
        email: String,
        password: String,
        username: String,
    },
    facebook: {
        id: String,
        token: String,
        email: String,
        name: String,
    },
    google: {
        id: String,
        token: String,
        email: String,
        name: String,
    },
    linkedin: {
        id: String,
        token: String,
        email: String,
        name: String,
    },
    twitter: {
        id: String,
        token: String,
        email: String,
        name: String,
    },
    firebaseToken: String,
    createdAt: { type: Date, default: Date.now() },
    resetToken: String,
    resetTokenExpiration: Date,
    imageUrl: { type: String },
    industry: { type: String },
    age: { type: Schema.Types.Number },
    //referral part/
    refCode: { type: String },
    referred: { type: Schema.Types.Number, default: 0 },
    points: { type: Schema.Types.Number, default: 100 },
});

userSchema.methods.comparePassword = function (candidatePassword, cb) {
    bcrypt.compare(candidatePassword, this.local.password, function (
        err,
        isMatch
    ) {
        if (err) return cb(err);
        cb(null, isMatch);
    }); 
};

module.exports = mongoose.model("User", userSchema);
