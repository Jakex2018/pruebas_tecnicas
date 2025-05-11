import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/provider/auth_provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/screens/auth_chat_screen.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/screens/login_screen.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/services/auth_services.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/widget/text_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: _buildFormRegister(),
        ));
  }

  Widget _buildFormRegister() {
    return Form(
        child: Column(
      children: [
        TextForm(
          controller: nameController,
          title: 'Nombre',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'El nombre es obligatorio';
            }
            return null;
          },
        ),
        TextForm(
          controller: emailController,
          title: 'Email',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'El email es obligatorio';
            }
            return null;
          },
        ),
        TextForm(
          controller: passwordController,
          title: 'Contraseña',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'La contraseña es obligatoria';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: _register, child: const Text('Register')),
        const SizedBox(
          height: 40,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text('Change a Login Screen'),
        )
      ],
    ));
  }

  void _register() {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      authServices.registerUser(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      authProvider.login();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AuthChatScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
