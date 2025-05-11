import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/screens/auth_chat_screen.dart';
import 'package:prueba_tecnica_01/test_exercises/movieApp/presentation/screens/movie_screen.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/app/app_provider.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/screens/todo_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.allProviders,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SelectTestScreen(),
      ),
    );
  }
}

class SelectTestScreen extends StatelessWidget {
  const SelectTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Selección de Pruebas Técnicas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Prueba Técnica 01'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Prueba Técnica 02'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AuthChatScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Prueba Técnica 03'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MovieScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}



/*
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
 */