class RPCreateAuthOrder {
  String? orderId;

  RPCreateAuthOrder(this.orderId);

  set setOrderId(String? id) {
    this.orderId = id;
  }

  factory RPCreateAuthOrder.fromJson(Map<String, dynamic> json) {
    return RPCreateAuthOrder(json['id']);
  }
}

class RPCreateCust {
  String? custId;

  RPCreateCust(this.custId);

  factory RPCreateCust.fromJson(Map<String, dynamic> json) {
    return RPCreateCust(json['id']);
  }
}

class RPFetchToken {
  String? token;

  RPFetchToken(this.token);

  factory RPFetchToken.fromJson(Map<String, dynamic> json) {
    return RPFetchToken(json['token_id']);
  }
}

class RPCreateOrder {
  String? orderId;

  RPCreateOrder(this.orderId);

  factory RPCreateOrder.fromJson(Map<String, dynamic> json) {
    return RPCreateOrder(json['id']);
  }
}

// class RPPayment {
//   String? orderId;

//   RPCreateOrder(this.orderId);

//   factory RPCreateOrder.fromJson(Map<String, dynamic> json) {
//     return RPCreateOrder(json['id']);
//   }
// }
