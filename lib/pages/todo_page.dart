import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];
  String _currentText = "";

  void _onTextChanged(String value) {
    setState(() {
      _currentText = value;
    });
  }

  void _addTask() {
    if (_currentText.trim().isEmpty) return;
    setState(() {
      _tasks.insert(0, {'text': _currentText.trim(), 'done': false});
      _controller.clear();
      _currentText = "";
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _clearAllTasks() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Semua Tugas"),
        content: const Text("Yakin ingin menghapus semua tugas?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _tasks.clear();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Hapus Semua", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (_tasks.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
              tooltip: "Hapus semua tugas",
              onPressed: _clearAllTasks,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Tulis tugas baru...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      onChanged: _onTextChanged,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_rounded, color: Colors.teal, size: 32),
                    onPressed: _addTask,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox_rounded, size: 80, color: Colors.grey.shade400),
                        const SizedBox(height: 8),
                        Text(
                          "Belum ada tugas",
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                        ),
                      ],
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return GestureDetector(
                          onTap: () => _toggleDone(index),
                          onLongPress: () => _deleteTask(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: task['done']
                                  ? Colors.teal.shade100
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  task['done']
                                      ? Icons.check_circle
                                      : Icons.circle_outlined,
                                  color: task['done'] ? Colors.teal : Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    task['text'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: task['done']
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: task['done']
                                          ? Colors.grey.shade600
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                  onPressed: () => _deleteTask(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
