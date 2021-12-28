import 'dart:convert';

const apiKeyId = 'rzp_live_YUNJVfBQ06iCLw';
const apiClientSec = 'uqQeF2cWQWihAHKnYHURhsQs';
const apiKey = apiKeyId + ':' + apiClientSec;
final String basicAuth = 'Basic ' + base64Encode(utf8.encode(apiKey));
const basicAuthPM =
    'Basic cnpwX2xpdmVfWVVOSlZmQlEwNmlDTHc6dXFRZUYyY1dRV2loQUhLbllIVVJoc1Fz';
