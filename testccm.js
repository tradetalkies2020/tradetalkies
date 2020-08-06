const coinmarketcapAPIKEY=`e9f643a2-e1b9-4b4b-8efa-f720b4fb4567`
const rp = require('request-promise');
const requestOptions = {
  method: 'GET',
  uri: 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest',
  qs: {
    'start': '1',
    'limit': '5000',
    'convert': 'USD'
  },
  headers: {
    'X-CMC_PRO_API_KEY': coinmarketcapAPIKEY
  },
  json: true,
  gzip: true
};

rp(requestOptions).then(response => {
  console.log('API call response:', response.data[0]);
}).catch((err) => {
  console.log('API call error:', err.message);
});
