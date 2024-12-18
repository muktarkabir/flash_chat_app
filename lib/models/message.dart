import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message(
      {required this.receiverId,
      required this.senderId,
      required this.senderEmail,
      required this.message,
      required this.timestamp});
  final String receiverId;
  final String senderId;
  final String senderEmail;
  final String message;
  final FieldValue timestamp;

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'message': message,
      'timestamp': timestamp
    };
  }
}
