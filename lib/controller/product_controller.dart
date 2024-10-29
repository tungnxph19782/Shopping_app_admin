import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var products = <Product>[].obs;


  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      print('Số lượng sản phẩm lấy được: ${snapshot.docs.length}');


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



  Future<void> addProduct(Product product) async {
    DocumentReference ref = await _firestore.collection('products').add(product.toMap());
    product.id = ref.id;
    fetchProducts();
  }

  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
    fetchProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _firestore.collection('products').doc(product.id).update(product.toMap());
    fetchProducts();
  }
}
