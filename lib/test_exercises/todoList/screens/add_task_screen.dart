import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/models/task.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/provider/todo_list_provider.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/widget/text_form.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title:
            const Text('Añadir tarea', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: _buildFormTaks(),
      ),
    );
  }

  Widget _buildFormTaks() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextForm(
            title: 'Título',
            controller: titleController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'El título es obligatorio';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextForm(
            title: 'Descripción',
            controller: descriptionController,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: addTask,
            child: const Text('Crear Tarea'),
          ),
        ],
      ),
    );
  }

  void addTask() {
    if (formKey.currentState!.validate()) {
      final todoProvider =
          Provider.of<TodoListProvider>(context, listen: false);
      todoProvider.addTask(
        Task(
            title: titleController.text,
            description: descriptionController.text),
      );
      titleController.clear();
      descriptionController.clear();
      Navigator.pop(context);
    }
  }
}
