const mongoose = require("mongoose");

const Schema = mongoose.Schema;

var tickerSchema = new Schema({
    symbol: String,
    value: String,
});

tickerSchema.path("symbol").index({ text: true, unique: false });

module.exports = mongoose.model("Ticker", tickerSchema);
