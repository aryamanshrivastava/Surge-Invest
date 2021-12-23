class RPpost {
  String? orderId;

  RPpost(this.orderId);

  set setOrderId(String? id) {
    this.orderId = id;
  }

  factory RPpost.fromJson(Map<String, dynamic> json) {
    return RPpost(json['order_id']);
  }
}

class RPCreateCust {
  String? custId;

  RPCreateCust(this.custId);

  factory RPCreateCust.fromJson(Map<String, dynamic> json) {
    return RPCreateCust(json['id']);
  }
}
