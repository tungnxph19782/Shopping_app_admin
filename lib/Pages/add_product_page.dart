import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:footware_admin/controller/product_controller.dart';
import 'package:footware_admin/widgets/drop_down_btn.dart';
import 'package:get/get.dart';
import '../model/product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String selectedCategory = 'Cate';
  String selectedBrand = 'Brand';
  String selectedOffer = 'false';

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Add New Product',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _buildTextField(nameController, 'Product Name', 'Product Name'),
              const SizedBox(height: 10),
              _buildTextField(descriptionController, 'Description', 'Description', maxLines: 5),
              const SizedBox(height: 10),
              _buildTextField(imageUrlController, 'Image URL', 'Image URL'),
              const SizedBox(height: 10),
              _buildTextField(priceController, 'Price', 'Price', isNumeric: true),
              const SizedBox(height: 20),
              _buildDropDowns(),
              const SizedBox(height: 20),
              _buildOfferDropDown(),
              const SizedBox(height: 20),
              _buildAddProductButton(productController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {int maxLines = 1, bool isNumeric = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        hintText: hint,
      ),
      maxLines: maxLines,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    );
  }

  Widget _buildDropDowns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: DropDownBtn(
            items: ['Cate1', 'Cate2', 'Cate3'],
            selectedItemtext: selectedCategory,
            onSelected: (selectedValue) {
              setState(() {
                selectedCategory = selectedValue!;
              });
            },
          ),
        ),
        const SizedBox(width: 30),
        Flexible(
          child: DropDownBtn(
            items: ['Brand1', 'Brand2', 'Brand3'],
            selectedItemtext: selectedBrand,
            onSelected: (selectedValue) {
              setState(() {
                selectedBrand = selectedValue!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOfferDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Offer Product?'),
        DropDownBtn(
          items: ['true', 'false'],
          selectedItemtext: selectedOffer,
          onSelected: (selectedValue) {
            setState(() {
              selectedOffer = selectedValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAddProductButton(ProductController productController) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      onPressed: () => _addProduct(productController),
      child: const Text('Add Product'),
    );
  }

  void _addProduct(ProductController productController) {
    final String name = nameController.text.trim();
    final String description = descriptionController.text.trim();
    final String imageUrl = imageUrlController.text.trim();
    final double? price = double.tryParse(priceController.text.trim());

    if (name.isEmpty || description.isEmpty || imageUrl.isEmpty || price == null) {
      Get.snackbar("Lỗi", "Vui lòng điền đầy đủ thông tin!");
      return;
    }

    final bool isOffer = selectedOffer.toLowerCase() == 'true';
    final product = Product(
      id: '', // ID sẽ được gán sau khi thêm vào Firestore
      brand: selectedBrand,
      category: selectedCategory,
      description: description,
      picture: imageUrl,
      name: name,
      offer: isOffer,
      price: price,
    );

    productController.addProduct(product).then((_) {
      _resetFields();
    });
  }

  void _resetFields() {
    nameController.clear();
    descriptionController.clear();
    imageUrlController.clear();
    priceController.clear();

    setState(() {
      selectedBrand = 'Brand';
      selectedCategory = 'Cate';
      selectedOffer = 'false';
    });
  }
}
