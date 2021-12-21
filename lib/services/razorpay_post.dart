import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testings/models/razorpay.dart';

class RazorPayCreateOrder {
  final url = Uri.parse(
      'https://api.razorpay.com/v1/subscription_registration/auth_links');

  Future<RPpost> createOrder({
    required String name,
    required String email,
    required String phone,
    required String receipt,
  }) async {
    var postBody = jsonEncode(<String, dynamic>{
      "customer": {"name": name, "email": email, "contact": phone},
      "type": "link",
      "amount": "100",
      "currency": "INR",
      "description": "Surge will debit upto Rs.500 in a month.",
      "subscription_registration": {
        "method": "upi",
        "max_amount": "500000",
        "expire_at": 4102444799,
        "frequency": "as_presented"
      },
      "receipt": "Receipt No. $receipt",
      "email_notify": 1,
      "sms_notify": 1,
      "expire_by": 4102444799,
      "notes": {
        "note_key 1": "Beam me up Scotty",
        "note_key 2": "Tea. Earl Gray. Hot."
      }
    });
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader:
            'Basic cnpwX3Rlc3RfZVlhOHJDMlpIMUt6dVE6OGgzT3FIcXZTcHM3RGk3T2dUOXpiQ0Ni'
      },
      body: postBody,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return RPpost.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to load user');
    }
  }
}
