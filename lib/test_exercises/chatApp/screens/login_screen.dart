import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/provider/auth_provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/screens/register_screen.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/services/auth_services.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/widget/text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          child: _buildFormLogin(),
        ));
  }

  Widget _buildFormLogin() {
    return Form(
        child: Column(
      children: [
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
        ElevatedButton(onPressed: _login, child: const Text('Login')),
        const SizedBox(
          height: 40,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: const Text('Change a Register Screen'),
        )
      ],
    ));
  }

  void _login() {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      authServices.loginUser(emailController.text, passwordController.text);
      authProvider.login();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
