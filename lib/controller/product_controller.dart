import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product.dart'; // Import model Product

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var products = <Product>[].obs; // Danh sách sản phẩm

// Hàm lấy danh sách sản phẩm
  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      print('Số lượng sản phẩm lấy được: ${snapshot.docs.length}');

      // Kiểm tra từng sản phẩm
      for (var doc in snapshot.docs) {
        print('Sản phẩm: ${doc.id} => ${doc.data()}');
      }

      products.value = snapshot.docs.map((doc) {
        return Product.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Lỗi khi lấy sản phẩm: $e');
    }
  }


  // Hàm thêm sản phẩm
  Future<void> addProduct(Product product) async {
    // Thêm sản phẩm mà không cần ID
    DocumentReference ref = await _firestore.collection('products').add(product.toMap());
    product.id = ref.id; // Gán ID cho sản phẩm vừa thêm
    fetchProducts(); // Cập nhật danh sách sản phẩm
  }

  // Hàm xóa sản phẩm
  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
    fetchProducts(); // Cập nhật danh sách sản phẩm
  }
  // Hàm sửa sản phẩm
  Future<void> updateProduct(Product product) async {
    // Cập nhật sản phẩm dựa trên ID
    await _firestore.collection('products').doc(product.id).update(product.toMap());
    fetchProducts(); // Cập nhật danh sách sản phẩm
  }
}
