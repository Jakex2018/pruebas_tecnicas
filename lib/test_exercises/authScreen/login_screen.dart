import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class LoginAnimate extends StatefulWidget {
  const LoginAnimate({super.key});

  @override
  State<LoginAnimate> createState() => _LoginAnimateState();
}

class _LoginAnimateState extends State<LoginAnimate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showLogin = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 655),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _flipCard() {
    if (_showLogin) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _showLogin = !_showLogin;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1503264116251-35a269479413?auto=format&fit=crop&w=1950&q=80',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final isUnder = _animation.value > 0.5;
                final angle = _animation.value * pi;
                final displayChild = isUnder
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: _buildRegister())
                    : _buildLogin();

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(angle),
                  child: displayChild,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return _buildCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Login to your account',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const FormText(label: 'Email', isPassword: false),
          const SizedBox(height: 20),
          const FormText(label: 'Password', isPassword: true),
          const SizedBox(height: 20),
          _buildButton('Login', _flipCard),
        ],
      ),
    );
  }

  Widget _buildRegister() {
    return _buildCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Create a new account',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const FormText(label: 'Username', isPassword: false),
          const SizedBox(height: 20),
          const FormText(label: 'Email', isPassword: false),
          const SizedBox(height: 20),
          const FormText(label: 'Password', isPassword: true),
          const SizedBox(height: 20),
          _buildButton('Register', _flipCard),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: SingleChildScrollView(child: child),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class FormText extends StatelessWidget {
  final String label;
  final bool isPassword;
  const FormText({super.key, required this.label, required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
