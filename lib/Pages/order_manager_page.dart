import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_controller.dart';

class OrderManagementPage extends StatefulWidget {
  const OrderManagementPage({super.key});

  @override
  State<OrderManagementPage> createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  final OrderController _orderController = Get.find();

  @override
  void initState() {
    super.initState();
    _orderController.fetchOrders(); // Lấy danh sách đơn hàng khi màn hình khởi tạo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
      ),
      body: Obx(() {
        if (_orderController.orders.isEmpty) {
          return const Center(child: CircularProgressIndicator()); // Loading nếu chưa có dữ liệu
        }

        return ListView.builder(
          itemCount: _orderController.orders.length,
          itemBuilder: (context, index) {
            final order = _orderController.orders[index];
            return ListTile(
              title: Text('Đơn hàng #${order.id} - ${order.status}'),
              subtitle: Text(
                'Tổng tiền: ${order.totalPrice} VND\nNgày: ${order.createdAt}',
              ),
              onTap: () {
                // Mở chi tiết đơn hàng hoặc cập nhật trạng thái
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _confirmDelete(order.id); // Xác nhận xóa đơn hàng
                },
              ),
            );
          },
        );
      }),
    );
  }

  void _confirmDelete(String orderId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Xóa đơn hàng'),
        content: const Text('Bạn có chắc chắn muốn xóa đơn hàng này không?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Đóng dialog
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              await _orderController.deleteOrder(orderId); // Xóa đơn hàng
              Get.back(); // Đóng dialog
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
