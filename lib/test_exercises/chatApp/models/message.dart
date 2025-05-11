import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String userId;
  final String message;
  final DateTime date;
  final String photoUrl;

  Message({
    required this.userId,
    required this.message,
    required this.date,
    required this.photoUrl,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Message(
      userId: data['userId'] ?? '',
      message: data['message'] ?? '',
      date: (data['createdAt'] as Timestamp).toDate(),
      photoUrl: data['photoUrl'] ?? '',
    );
  }
}
