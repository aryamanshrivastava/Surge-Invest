import 'package:testings/models/razorpay.dart';
import 'package:testings/services/razorpay_post.dart';

class RPpostRepository {
  RPpost? rPpost;

  Future<RPpost?> order(
    String name,
    String email,
    String phone,
    String receipt,
  ) =>
      RazorPayCreateOrder().createOrder(
        name: name,
        email: email,
        phone: phone,
        receipt: receipt,
      );
}
