import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart'; // Import model User

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var users = <User>[].obs; // Danh sách người dùng

  // Hàm lấy danh sách người dùng
  Future<void> fetchUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('User Profiles').get();
    users.value = snapshot.docs.map((doc) {
      return User.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // Hàm thêm người dùng
  Future<void> addUser(User user) async {
    DocumentReference ref = await _firestore.collection('users').add(user.toMap());
    user.id = ref.id; // Gán ID cho người dùng vừa thêm
    fetchUsers(); // Cập nhật danh sách người dùng
  }

  // Hàm xóa người dùng
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
    fetchUsers(); // Cập nhật danh sách người dùng
  }

  // Hàm sửa thông tin người dùng
  Future<void> updateUser(User user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
    fetchUsers(); // Cập nhật danh sách người dùng
  }
}
