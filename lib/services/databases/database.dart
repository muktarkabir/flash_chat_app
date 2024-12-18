import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static final CollectionReference<Map<String, dynamic>> messagesCollection =
      _fireStore.collection('messages');

  static final CollectionReference<Map<String, dynamic>> usersCollection =
      _fireStore.collection('users');

  static final CollectionReference<Map<String, dynamic>> chatRoomsCollection =
      _fireStore.collection('chat_rooms');
}
