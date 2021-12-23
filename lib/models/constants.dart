import 'dart:convert';

const apiKeyId = 'rzp_live_MM2tu937xHxhKb';
const apiClientSec = 'vOcrxf0RC1jUzc5eC6v3L4d8';
const apiKey = apiKeyId + ':' + apiClientSec;
final String basicAuth = 'Basic ' + base64Encode(utf8.encode(apiKey));
