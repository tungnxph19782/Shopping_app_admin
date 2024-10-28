import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';
import '../widgets/confirm_action_dialog.dart';
import 'add_product_page.dart';

class ProductManagementPage extends StatefulWidget {
  @override
  _ProductManagementPageState createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  final ProductController _productController = Get.find();

  @override
  void initState() {
    super.initState();
    _productController.fetchProducts(); // Gọi hàm để tải sản phẩm
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sản phẩm'),
      ),
      body: Obx(() {
        if (_productController.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: _productController.products.length,
          itemBuilder: (context, index) {
            final product = _productController.products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('Giá: ${product.price} VND'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _confirmDelete(product.id);
                },
              ),
              onTap: () {
                // Có thể mở màn hình chi tiết sản phẩm nếu cần
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProductPage())?.then((_) {
            _productController.fetchProducts(); // Tải lại danh sách sau khi thêm
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(String productId) {
    Get.dialog(
      ConfirmActionDialog(
        title: 'Xóa sản phẩm',
        content: 'Bạn có chắc chắn muốn xóa sản phẩm này không?',
        confirmText: 'Xóa',
        cancelText: 'Hủy',
        onConfirm: () async {
          await _productController.deleteProduct(productId);
          _productController.fetchProducts(); // Tải lại sản phẩm sau khi xóa
          Get.back(); // Đóng dialog
        },
      ),
    );
  }
}
