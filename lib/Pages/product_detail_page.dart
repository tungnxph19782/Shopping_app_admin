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
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editProduct,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showConfirmDeleteDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

  void _editProduct() {
    Get.to(() => EditProductPage(product: product))?.then((result) {
      if (result == true) {
        setState(() {
          productController.fetchProducts().then((_) {
            product = productController.products.firstWhere((p) => p.id == product.id);
          });
        });
      }
    });
  }


  void _showConfirmDeleteDialog() {
    Get.dialog(
      ConfirmActionDialog(
        title: 'Xóa sản phẩm',
        content: 'Bạn có chắc chắn muốn xóa sản phẩm này không?',
        confirmText: 'Xóa',
        cancelText: 'Hủy',
        onConfirm: () async {
          await productController.deleteProduct(product.id);
          Get.back(result: true);
          Get.snackbar("Thành công", "Đã xóa sản phẩm!");
        },
      ),
    );
  }
}
