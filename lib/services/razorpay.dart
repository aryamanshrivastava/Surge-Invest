import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:testings/models/constants.dart';

class RP {
  final razorpay = Razorpay();

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.toString());
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  checkout(String name, String phone, String email, String orderId) {
    Map<String, dynamic> options = {
      'key': apiKey,
      'amount': 100, //in the smallest currency sub-unit.
      'name': name,
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60, // in seconds
      'prefill': {'contact': phone, 'email': email}
    };
    razorpay.open(options);
  }
}
