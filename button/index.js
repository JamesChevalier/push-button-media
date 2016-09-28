'use strict';

console.log('Loading function');

const http = require('http');
var endpointUrl = 'http://SOMETHING.ngrok.io/button';

exports.handler = (event, context, callback) => {
  http.get(endpointUrl, function (result) {
    console.log('Success, with: ' + result.statusCode);
  }).on('error', function (err) {
    console.log('Error, with: ' + err.message);
    callback(err, 'GET failed!');
  });
};
