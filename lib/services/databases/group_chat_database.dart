import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_app/services/auth/auth_service.dart';
import 'package:flash_chat_app/services/databases/database.dart';

class GroupchatDatabase {
  static final Query<Map<String, dynamic>> messagesOrderedByTimeStamp =
      Database.messagesCollection.orderBy('timestamp', descending: true);

  static final Stream<QuerySnapshot<Map<String, dynamic>>> messagesStream =
      messagesOrderedByTimeStamp.snapshots();

  static Future<void> sendMessage(String message) async {
    await Database.messagesCollection.add({
      'sender': AuthService.getCurrentUserEmail(),
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

