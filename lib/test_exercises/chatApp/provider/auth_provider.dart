import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  User? _user;
  User? get user => _user;

  AuthProvider() {
    checkLoginStatus();
  }

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void checkLoginStatus() {
    final user = FirebaseAuth.instance.currentUser;
    _isLoggedIn = user != null;
    notifyListeners();
  }
}
