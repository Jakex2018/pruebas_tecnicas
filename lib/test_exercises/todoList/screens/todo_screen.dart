import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/models/task.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/provider/todo_list_provider.dart';
import 'package:prueba_tecnica_01/test_exercises/todoList/screens/add_task_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue,
        title: const Text('Todo List', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Consumer<TodoListProvider>(
          builder: (context, todoProvider, child) {
            return Column(
              children: [
                const Text('Lista de tareas'),
                const SizedBox(height: 50),
                Expanded(
                  child: todoProvider.tasks.isEmpty
                      ? const Center(child: Text('No hay tareas'))
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: todoProvider.tasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildTodoCard(
                                todoProvider.tasks[index], todoProvider);
                          },
                        ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Añadir tarea'),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const AddTaskScreen();
                        }));
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTodoCard(Task task, TodoListProvider todo) {
    return Dismissible(
      onDismissed: (direction) {
        todo.removeTask(task);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tarea eliminada'),
          ),
        );
      },
      key: Key(task.title),
      background: Container(
        color: Colors.red,
        child: const Center(
          child: Icon(Icons.delete),
        ),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(task.title),
          subtitle: Text(task.description ?? ''),
          trailing: task.isCompleted == false
              ? const Icon(Icons.circle_outlined)
              : const Icon(Icons.check_circle_outline),
          onTap: () {
            todo.completeTask(task);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tarea completada'),
              ),
            );
          },
        ),
      ),
    );
  }
}
