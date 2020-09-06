
exports.mailIt = function (myMail, myToken) {

var jwt = require('jsonwebtoken')
var http = require("https");
var options = {
  "method": "POST",
  "hostname": "api.pepipost.com",
  "port": null,
  "path": "/v2/sendEmail",
  "headers": {
    "content-type": "application/json",
    "api_key": "6161a7f4d052b4e0300cdb0bde87736b"
  }
};
const newLine = require('os').EOL;

var req = http.request(options, function (res) {
  var chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    var body = Buffer.concat(chunks);
    //console.log(body.toString());
  });
});

req.write(JSON.stringify({ personalizations: 
  [ { recipient: myMail } ],
  from: { fromEmail: 'justforschool1415@pepisandbox.com', 
  fromName: 'justforschool1415' },
  subject: 'Confirmation Token',
  content: 'Hi, you successfully registered for Run the World.' 
    + ' Here is your confirmation token: ' + newLine + myToken 
    + newLine 
    + ' You have two minutes to verify your account before the' 
    + ' token expires.' }));
req.end();
};
