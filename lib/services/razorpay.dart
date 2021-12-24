import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:testings/models/change.dart';
import 'package:testings/models/constants.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/razorpay_post.dart';

class RP {
  final BuildContext context;
  final razorpay = Razorpay();

  RP(this.context);

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    String paymentId = response.paymentId!;
    var token = await RazorPayAPIpost().fetchToken(paymentId);
    Db().addToken(token.token!);
    Provider.of<BoolChange>(context, listen: false).ready();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Authrorization successful.'),
        );
      },
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  checkout(String name, String phone, String email, String orderId,
      String customerId) {
    Map<String, dynamic> options = {
      'key': apiKeyId,
      'amount': 100, //in the smallest currency sub-unit.
      // 'name': name,
      'order_id': orderId, // Generate order_id using Orders API
      'customer_id': customerId,
      //'description': 'Fine T-Shirt',
      //'timeout': 60, // in seconds
      'prefill': {'contact': phone, 'email': email},
      "external": {
        "wallets": [
          "paytm",
        ]
      },
      "recurring": "1",
    };
    razorpay.open(options);
  }
}
