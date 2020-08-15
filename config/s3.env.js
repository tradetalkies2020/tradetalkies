const env = {
    Bucket: "tradetalkies",
    AWS_ACCESS_KEY: process.env.AWS_ACCESS_KEY,
    AWS_SECRET_ACCESS_KEY: process.env.AWS_SECRET_KEY,
    ARN: "arn:aws:iam::180732700915:user/prateekganguly1998",
    ARN_ROLE: "arn:aws:iam::180732700915:role/SNSSuccessFeedback",
    REGION: "ap-south-1",
};

module.exports = env;
