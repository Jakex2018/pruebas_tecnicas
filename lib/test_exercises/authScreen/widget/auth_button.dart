import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({super.key, required this.isHovered});
  final bool isHovered;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1.0, end: widget.isHovered ? 0.9 : 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {},
          onTapDown: (_) => setState(() {}),
          child: Transform.scale(
            scale: value,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
