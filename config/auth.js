module.exports={
    "facebookAuth":{
        'clientID':process.env.FACEBOOK_CLIENT_ID,
        'clientSecret':process.env.FACEBOOK_CLIENT_SECRET,
        'callbackURL':`${process.env.APP_URL}/auth/facebook/callback`
    },
    "googleAuth":{
        'clientID':process.env.GOOGLE_CLIENT_ID,
        'clientSecret': process.env.GOOGLE_CLIENT_SECRET,
        'callbackURL':`${process.env.APP_URL}/auth/google/callback`
    },
    "linkedinAuth":{
        'clientID':process.env.LINKEDIN_CLIENT_ID,
        'clientSecret': process.env.LINKEDIN_CLIENT_SECRET,
        'callbackURL':`${process.env.APP_URL}/auth/linkedin/callback`
    },
    "twitterAuth":{
        'clientID':process.env.TWITTER_CLIENT_ID,
        'clientSecret': process.env.TWITTER_CLIENT_SECRET,
        'callbackURL':`${process.env.APP_URL}/auth/twitter/callback`
    }

}