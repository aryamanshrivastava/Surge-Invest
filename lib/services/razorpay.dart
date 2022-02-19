import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:testings/models/change.dart';
import 'package:testings/models/constants.dart';
import 'package:testings/models/razorpay.dart';
import 'package:testings/screens/about_walkthrough.dart';
import 'package:testings/services/db.dart';
import 'package:testings/services/razorpay_post.dart';

class RP {
  final BuildContext context;
  final razorpay = Razorpay();
  final db = Db();

  RP(this.context);

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    String paymentId = response.paymentId!;
    var token = await RazorPayAPIpost().fetchToken(paymentId);
    Db().addToken(token.token!);
    Provider.of<BoolChange>(context, listen: false).ready();
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Auto-Invest Complete!'),
        );
      },
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Auto-Invest failed!'),
        );
      },
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  checkout(String name, String phone, String email, String orderId,
      String customerId) {
    Map<String, dynamic> options = {
      'key': apiKeyId,
      'amount': 100,
      'name': 'Surge',
      'order_id': orderId,
      'customer_id': customerId,
      'description': 'Setup Auto-Invest',
      'timeout': 600,
      'prefill': {'contact': phone, 'email': email},
      "recurring": "1",
    };
    razorpay.open(options);
  }
}

class SubsequentPayment {
  final db = Db();
  subsequentPayment(int amt) async {
    RPCreateOrder order =
        await RazorPayAPIpost().createOrder(await db.custId, amt);
    RazorPayAPIpost().pay(await db.email, db.phoneCurrUser!, await db.custId,
        await db.token, order.orderId!, amt);
  }
}
