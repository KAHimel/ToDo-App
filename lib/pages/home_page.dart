
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _todoList = [];
  final TextEditingController _textController = TextEditingController();

  void _addOrEditTask({int? index}) {
    if (index != null) {
      _textController.text = _todoList[index]['task'];
    } else {
      _textController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Add Task" : "Edit Task"),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(hintText: "Enter your task"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (_textController.text.trim().isEmpty) return;
              setState(() {
                if (index == null) {
                  _todoList.add({
                    'task': _textController.text.trim(),
                    'done': false,
                  });
                } else {
                  _todoList[index]['task'] = _textController.text.trim();
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Are you sure?"),
        content: const Text("Do you really want to delete this task?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _todoList.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                _todoList[index]['task'],
                style: TextStyle(
                  fontSize: 18,
                  decoration: _todoList[index]['done']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              leading: Checkbox(
                value: _todoList[index]['done'],
                onChanged: (val) {
                  setState(() {
                    _todoList[index]['done'] = val ?? false;
                  });
                },
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueGrey),
                    onPressed: () => _addOrEditTask(index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteTask(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditTask(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
