import 'package:flutter/material.dart';
import 'package:footware_admin/controller/product_controller.dart';
import 'package:get/get.dart';
import '../model/product.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final ProductController productController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name;
    descriptionController.text = widget.product.description;
    imageUrlController.text = widget.product.picture;
    priceController.text = widget.product.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sửa Sản Phẩm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProduct,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(nameController, 'Tên sản phẩm'),
            _buildTextField(descriptionController, 'Mô tả', maxLines: 5),
            _buildTextField(imageUrlController, 'URL ảnh'),
            _buildTextField(priceController, 'Giá', isNumeric: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduct,
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1, bool isNumeric = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      maxLines: maxLines,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    );
  }

  void _saveProduct() {
    final String name = nameController.text.trim();
    final String description = descriptionController.text.trim();
    final String imageUrl = imageUrlController.text.trim();
    final double? price = double.tryParse(priceController.text.trim());

    if (name.isEmpty || description.isEmpty || imageUrl.isEmpty || price == null) {
      Get.snackbar("Lỗi", "Vui lòng điền đầy đủ thông tin!");
      return;
    }

    // Cập nhật sản phẩm
    final updatedProduct = Product(
      id: widget.product.id,
      name: name,
      description: description,
      picture: imageUrl,
      price: price,
      category: widget.product.category,
      brand: widget.product.brand,
      offer: widget.product.offer,
    );

    productController.updateProduct(updatedProduct).then((_) {
      Get.back(result: true); // Quay lại trang trước
      Get.snackbar("Thành công", "Đã cập nhật sản phẩm!");
    }).catchError((error) {
      Get.snackbar("Lỗi", "Không thể cập nhật sản phẩm: $error");
    });
  }
}
