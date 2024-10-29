import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var users = <User>[].obs;

  Future<void> fetchUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('User Profiles').get();
    users.value = snapshot.docs.map((doc) {
      return User.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> addUser(User user) async {
    DocumentReference ref = await _firestore.collection('users').add(user.toMap());
    user.id = ref.id;
    fetchUsers();
  }


  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
    fetchUsers();
  }


  Future<void> updateUser(User user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
    fetchUsers();
  }
}
