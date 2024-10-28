import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import '../model/product.dart';
import '../widgets/confirm_action_dialog.dart';
import 'edit_product_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Product product;
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    product = widget.product; // Khởi tạo với sản phẩm ban đầu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editProduct, // Gọi hàm chỉnh sửa sản phẩm
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showConfirmDeleteDialog, // Xóa sản phẩm
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị hình ảnh sản phẩm
            Image.network(
              product.picture,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Không thể tải ảnh'));
              },
            ),
            SizedBox(height: 10),
            Text('Mô tả: ${product.description}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Giá: \$${product.price}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Danh mục: ${product.category}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Thương hiệu: ${product.brand}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Khuyến mãi: ${product.offer ? 'Có' : 'Không'}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // Hàm mở trang chỉnh sửa sản phẩm và cập nhật giao diện nếu thành công
  void _editProduct() {
    Get.to(() => EditProductPage(product: product))?.then((result) {
      if (result == true) {
        // Cập nhật lại sản phẩm sau khi chỉnh sửa
        setState(() {
          // Lấy sản phẩm cập nhật từ controller
          productController.fetchProducts().then((_) {
            product = productController.products.firstWhere((p) => p.id == product.id);
          });
        });
      }
    });
  }

  // Hộp thoại xác nhận xóa sản phẩm
  void _showConfirmDeleteDialog() {
    Get.dialog(
      ConfirmActionDialog(
        title: 'Xóa sản phẩm',
        content: 'Bạn có chắc chắn muốn xóa sản phẩm này không?',
        confirmText: 'Xóa',
        cancelText: 'Hủy',
        onConfirm: () async {
          await productController.deleteProduct(product.id);
          Get.back(result: true); // Quay lại màn hình trước đó
          Get.snackbar("Thành công", "Đã xóa sản phẩm!"); // Hiện thông báo thành công
        },
      ),
    );
  }
}
