import 'package:cloud_firestore/cloud_firestore.dart';

class Order_admin {
  String id;
  String userId;
  double totalPrice;
  String status;
  DateTime createdAt;
  List<OrderItem> items; // Các sản phẩm trong đơn hàng

  Order_admin({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  // Tạo đối tượng Order từ Map (khi lấy từ Firebase)
  factory Order_admin.fromMap(String id, Map<String, dynamic> map) {
    return Order_admin(
      id: id,
      userId: map['userId'] ?? '',
      totalPrice: double.tryParse(map['totalAmount'].toString()) ?? 0.0,
      status: map['status'] ?? 'Pending',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      items: (map['items'] as List)
          .map((item) => OrderItem.fromMap(item))
          .toList(),
    );
  }

  // Chuyển Order thành Map (khi lưu lên Firebase)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}

// Model cho từng sản phẩm trong đơn hàng
class OrderItem {
  String productId;
  String name;
  int quantity;
  double price;

  OrderItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
