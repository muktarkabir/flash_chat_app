import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_app/models/message.dart';
import 'package:flash_chat_app/services/auth/auth_service.dart';
import 'package:flash_chat_app/services/databases/database.dart';

class UsersDatabase {
  static final Query<Map<String, dynamic>> usersOrderedByEmail =
      Database.usersCollection.orderBy('email');

  static final Stream<QuerySnapshot<Map<String, dynamic>>> usersStream =
      usersOrderedByEmail.snapshots();

  static Stream<List<Map<String, dynamic>>> getUsersStreamAsList() {
    return usersStream.map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  static Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = AuthService.currentUserId!;
    final String currentUserEmail = AuthService.getCurrentUserEmail()!;
    final timestamp = FieldValue.serverTimestamp();

    final newMessage = Message(
      receiverId: receiverId,
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [receiverId, currentUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await Database.chatRoomsCollection
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesStream(
      String currentUserId, String otherUserId) {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return Database.chatRoomsCollection
        .doc(chatRoomId)
        .collection('messages').orderBy('timestamp')
        .snapshots();
  }
}
