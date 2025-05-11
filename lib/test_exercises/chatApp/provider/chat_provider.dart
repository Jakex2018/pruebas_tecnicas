import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/models/message.dart';

class ChatProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void fetchMessages() {
    FirebaseFirestore.instance
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      _messages = snapshot.docs.map((doc) {
        return Message.fromFirestore(doc);
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addMessage(String text) async {
    if (text.isEmpty) return;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final photoUrl = userDoc.data()?['photoImg'] ?? '';

      final newMessage = Message(
        userId: user.uid,
        message: text,
        date: DateTime.now(),
        photoUrl: photoUrl,
      );

      await FirebaseFirestore.instance.collection('messages').add({
        'userId': user.uid,
        'message': text,
        'createdAt': newMessage.date,
        'photoUrl': newMessage.photoUrl,
      });

      notifyListeners();
    } catch (e) {
      throw Exception('Error adding message: $e');
    }
  }
}
