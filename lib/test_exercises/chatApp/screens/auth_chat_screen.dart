import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/provider/auth_provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/screens/chat_screen.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/screens/login_screen.dart';

class AuthChatScreen extends StatelessWidget {
  const AuthChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return authProvider.isLoggedIn
            ? const ChatScreen()
            : const LoginScreen();
      },
    );
  }
}
