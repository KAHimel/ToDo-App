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
        backgroundColor: const Color(0xFFF5F1EC),
        title: Text(
          index == null ? "Add Task" : "Edit Task",
          style: const TextStyle(
            color: Color(0xFF5C4033),
            fontWeight: FontWeight.w600,
          ),
        ),
        content: TextField(
          controller: _textController,
          cursorColor: const Color(0xFF8B6F47),
          style: const TextStyle(color: Color(0xFF5C4033)),
          decoration: InputDecoration(
            hintText: "Enter your task",
            hintStyle: TextStyle(
              color: const Color(0xFF8B6F47).withOpacity(0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD4A574)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF8B6F47), width: 2),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Color(0xFF8B6F47)),
            ),
          ),
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
          ),
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFF5F1EC),
        title: const Text(
          "Are you sure?",
          style: TextStyle(
            color: Color(0xFF5C4033),
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Text(
          "Do you really want to delete this task?",
          style: TextStyle(color: Color(0xFF5C4033)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Color(0xFF8B6F47)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _todoList.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC85C54),
            ),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My TODOs"),
        centerTitle: true,
        elevation: 0,
      ),
      body: _todoList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt_rounded,
                    size: 80,
                    color: const Color(0xFF8B6F47).withOpacity(0.3),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No tasks yet!",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF5C4033).withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tap the + button to add a new task",
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF8B6F47).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFFFBF7),
                          const Color(0xFFF5F1EC),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: const Color(0xFFD4A574).withOpacity(0.2),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        _todoList[index]['task'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF5C4033),
                          decoration: _todoList[index]['done']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: const Color(0xFF8B6F47),
                        ),
                      ),
                      leading: Checkbox(
                        value: _todoList[index]['done'],
                        onChanged: (val) {
                          setState(() {
                            _todoList[index]['done'] = val ?? false;
                          });
                        },
                        activeColor: const Color(0xFF8B6F47),
                        checkColor: const Color(0xFFF5F1EC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_rounded),
                            color: const Color(0xFF8B6F47),
                            onPressed: () => _addOrEditTask(index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_rounded),
                            color: const Color(0xFFC85C54),
                            onPressed: () => _deleteTask(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditTask(),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
    );
  }
}
