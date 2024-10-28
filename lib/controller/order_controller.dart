import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/order.dart';

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Order_admin> orders = <Order_admin>[].obs;

  // Lấy danh sách đơn hàng từ Firestore
  Future<void> fetchOrders() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('orders').get();
      orders.value = snapshot.docs.map((doc) {
        return Order_admin.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Lỗi khi lấy đơn hàng: $e');
    }
  }

  // Thêm mới đơn hàng
  Future<void> addOrder(Order_admin order) async {
    try {
      await _firestore.collection('orders').add(order.toMap());
      fetchOrders(); // Tải lại danh sách sau khi thêm
    } catch (e) {
      print('Lỗi khi thêm đơn hàng: $e');
    }
  }

  // Xóa đơn hàng
  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
      fetchOrders(); // Tải lại danh sách sau khi xóa
    } catch (e) {
      print('Lỗi khi xóa đơn hàng: $e');
    }
  }

  // Cập nhật trạng thái đơn hàng
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': newStatus,
      });
      fetchOrders(); // Tải lại danh sách sau khi cập nhật
    } catch (e) {
      print('Lỗi khi cập nhật trạng thái đơn hàng: $e');
    }
  }
}
