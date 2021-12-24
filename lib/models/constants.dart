import 'dart:convert';

const apiKeyId = 'rzp_test_YprczgP5cTKDiN';
const apiClientSec = '8Qb8StzsGVCxpgRZ4eyuo9vo';
const apiKey = apiKeyId + ':' + apiClientSec;
final String basicAuth = 'Basic ' + base64Encode(utf8.encode(apiKey));
