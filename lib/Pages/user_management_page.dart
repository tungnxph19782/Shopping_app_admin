import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart'; // Nhập controller User

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final UserController _userController = Get.find(); // Tìm controller

  @override
  void initState() {
    super.initState();
    _userController.fetchUsers(); // Gọi hàm để lấy danh sách người dùng khi khởi tạo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý người dùng'),
      ),
      body: Obx(() {
        if (_userController.users.isEmpty) {
          return const Center(child: CircularProgressIndicator()); // Hiển thị loading nếu danh sách rỗng
        }

        return ListView.builder(
          itemCount: _userController.users.length,
          itemBuilder: (context, index) {
            final user = _userController.users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text('Email: ${user.email}\nSố điện thoại: ${user.phone}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _confirmDelete(user.id); // Xác nhận xóa người dùng
                },
              ),
            );
          },
        );
      }),
    );
  }

  void _confirmDelete(String userId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Xóa người dùng'),
        content: const Text('Bạn có chắc chắn muốn xóa người dùng này không?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Đóng dialog
            },
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              await _userController.deleteUser(userId); // Gọi hàm xóa người dùng
              Get.back(); // Đóng dialog
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
