import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/user_model.dart';
import 'package:expense_tracker/utils/session_manager.dart';

String collectionName = 'Users';

class UserController {
  final _db = FirebaseFirestore.instance.collection(collectionName);

  addUser(UserModel userModel, Function getUserId) async {
    userModel.userId = _db.id;
    getUserId(_db.id);
    await _db.add(userModel.toMap());
  }

  Future<List<UserModel>> retrieveUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromMap(docSnapshot))
        .toList();
  }

  Future<UserModel?> retrieveSingleUsers(String id) async {
    final snapshot = await _db.doc(id).get();
    return UserModel.fromMap(snapshot);
  }

  updateUser(UserModel userModel) async =>
      await _db.doc(userModel.name).update(userModel.toMap());

  updateFCMToken(String fcmToken) async {
    String? id = await SessionManager().getUserId();
    await _db.doc(id).update({"fcmToken": fcmToken});
  }
}
