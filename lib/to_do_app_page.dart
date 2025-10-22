import 'package:flutter/material.dart';
import 'package:smart_todoapp/data/database_helper.dart';
import '/models/task.dart';
import '/widgets/task_card.dart';

class ToDoAppPage extends StatefulWidget {
  const ToDoAppPage({super.key});

  @override
  State<ToDoAppPage> createState() => _ToDoAppPageState();
}

class _ToDoAppPageState extends State<ToDoAppPage> {
  bool showTimeline = false;

  final dbHelper = DatabaseHelper();

void _addSampleTask() async {
  final task = Task(
    name: "Learn SQLite",
    createdAt: DateTime.now(),
    description: "Integrate SQLite with Flutter",
    status: "pending",
    priority: 1,
  );
  await dbHelper.insertTask(task);
}

void _loadTasks() async {
  List<Task> tasks = await dbHelper.getAllTasks();
  print("Loaded tasks: $tasks");
}

  // ✅ Example data using the Task model
  final List<Task> todayTasks = [
    Task(
      id: 1,
      name: "Buy groceries",
      description: "Milk, eggs, and bread",
      status: "pending",
      priority: 2,
      categoryId: 1,
      time: "09:00 AM",
      createdAt: DateTime(2025, 10, 15, 9, 0),
    ),
    Task(
      id: 2,
      name: "Workout",
      description: "30 mins running",
      status: "completed",
      priority: 1,
      categoryId: 2,
      time: "07:30 AM",
      createdAt: DateTime(2025, 10, 15, 7, 30),
    ),
    Task(
      id: 3,
      name: "Meeting with team",
      description: "Discuss ToDoApp progress",
      status: "pending",
      priority: 3,
      categoryId: 1,
      time: "02:00 PM",
      createdAt: DateTime(2025, 10, 15, 14, 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // 🔄 Clone list to avoid modifying original
    List<Task> sortedTasks = [...todayTasks];

    if (showTimeline) {
      sortedTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // soft warm yellow
      appBar: AppBar(
        title: const Text(
          "Today's Tasks",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 3,
        backgroundColor: const Color(0xFFFFA726), // orange
        actions: [
          IconButton(
            icon: Icon(
              showTimeline ? Icons.timeline : Icons.list_alt,
              color: Colors.white,
            ),
            tooltip: showTimeline ? 'Hide Timeline' : 'Show Timeline',
            onPressed: () {
              setState(() => showTimeline = !showTimeline);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: showTimeline
            ? _buildTimelineView(sortedTasks)
            : _buildListView(sortedTasks),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFB300),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _addSampleTask();
          _loadTasks();
        },
      ),
    );
  }

  // 🕒 Timeline View
  Widget _buildTimelineView(List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFA726),
                    shape: BoxShape.circle,
                  ),
                ),
                if (index != tasks.length - 1)
                  Container(
                    width: 3,
                    height: 55,
                    color: const Color(0xFFFFCC80),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.time ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6D4C41),
                    ),
                  ),
                  TaskCard(
                    title: task.name,
                    description: task.description ?? '',
                    isCompleted: task.status == "completed",
                    onToggle: () {
                      setState(() {
                        task.status =
                            (task.status == "completed") ? "pending" : "completed";
                      });
                    },
                    onDelete: () {
                      setState(() => todayTasks.remove(task));
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // 📋 List View
  Widget _buildListView(List<Task> tasks) {
    return ListView(
      children: [
        const SizedBox(height: 10),
        ...tasks.map((task) {
          return TaskCard(
            title: task.name,
            description: task.description ?? '',
            isCompleted: task.status == "completed",
            onToggle: () {
              setState(() {
                task.status =
                    (task.status == "completed") ? "pending" : "completed";
              });
            },
            onDelete: () {
              setState(() => todayTasks.remove(task));
            },
          );
        }),
      ],
    );
  }
}
