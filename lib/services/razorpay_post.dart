import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testings/models/constants.dart';
import 'package:testings/models/razorpay.dart';

class RazorPayAPIpost {
  final url = Uri.parse('https://api.razorpay.com/v1/customers');
  final authOrderUrl = Uri.parse('https://api.razorpay.com/v1/orders');

  Future<RPCreateCust> createCustomer(
      String name, String phone, String email) async {
    var postBody = jsonEncode(<String, dynamic>{
      "name": name,
      "email": email,
      "contact": phone,
      "fail_existing": "0",
      "notes": {"note_key_1": "September", "note_key_2": "Make it so."}
    });
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader:
            'Basic cnpwX3Rlc3RfWXByY3pnUDVjVEtEaU46OFFiOFN0enNHVkN4cGdSWjRleXVvOXZv',
      },
      body: postBody,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return RPCreateCust.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to create customer');
    }
  }

  Future<RPCreateAuthOrder> createAuthOrder(
      String customerId, String receipt) async {
    var postBody = jsonEncode(<String, dynamic>{
      "amount": 100,
      "currency": "INR",
      "customer_id": customerId,
      "method": "upi",
      "token": {
        "max_amount": 200000,
        "expire_at": 2709971120,
        "frequency": "monthly"
      },
      "receipt": receipt,
      "notes": {
        "notes_key_1": "Tea, Earl Grey, Hot",
        "notes_key_2": "Tea, Earl Grey… decaf."
      }
    });
    final response = await http.post(
      authOrderUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader:
            'Basic cnpwX3Rlc3RfWXByY3pnUDVjVEtEaU46OFFiOFN0enNHVkN4cGdSWjRleXVvOXZv',
      },
      body: postBody,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return RPCreateAuthOrder.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to create order');
    }
  }

  Future<RPFetchToken> fetchToken(String paymentId) async {
    final response = await http.get(
      Uri.parse('https://api.razorpay.com/v1/payments/$paymentId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader:
            'Basic cnpwX3Rlc3RfWXByY3pnUDVjVEtEaU46OFFiOFN0enNHVkN4cGdSWjRleXVvOXZv',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return RPFetchToken.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to fetch token');
    }
  }
}
