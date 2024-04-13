import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  String documentId = 'doc-id';

  Future<void> setUserId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(documentId, id);
  }

  Future<String?> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var docId = pref.getString(documentId);
    return docId;
  }
}
