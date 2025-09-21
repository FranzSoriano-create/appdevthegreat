// main.dart
import 'package:flutter/material.dart';
import 'widgets/task_card.dart';
import 'widgets/icon_label.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Souls Task Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF18181A),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFBFA76A),
          secondary: const Color(0xFF6C757D),
          surface: const Color(0xFF23232B),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Cinzel',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFFD7C797),
            letterSpacing: 1.2,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Cinzel',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFFD7C797),
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 16,
            color: Color(0xFFBFA76A),
          ),
        ),
      ),
      home: const TaskListPage(),
    );
  }
}

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});
  static final _demoTasks = [
    {
      'title': 'Code review for PR #42',
      'description': 'Review authentication refactor and leave comments.',
      'priority': 'High',
      'dueDate': '2025-09-22',
      'assignee': 'Franz',
      'tags': 'Review, Auth',
      'isImportant': 'true',
    },
    {
      'title': 'Write unit tests for widgets',
      'description': 'Increase coverage for custom UI components.',
      'priority': 'Medium',
      'dueDate': '2025-09-23',
      'assignee': 'Franz',
      'tags': 'Testing, UI',
      'isImportant': 'false',
    },
    {
      'title': 'Update project documentation',
      'description': 'Add setup steps and architecture diagrams.',
      'priority': 'Low',
      'dueDate': '2025-09-25',
      'assignee': 'Franz',
      'tags': 'Docs, Planning',
      'isImportant': 'false',
    },
    {
      'title': 'Sprint planning meeting',
      'description': 'Prepare agenda and review backlog items.',
      'priority': 'High',
      'dueDate': '2025-09-21',
      'assignee': 'Franz',
      'tags': 'Meeting, Planning',
      'isImportant': 'true',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: const Color(0xFF23232B),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _demoTasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final t = _demoTasks[i];
          return TaskCard(
            title: t['title']!,
            description: t['description']!,
            priority: t['priority']!,
            dueDate: t['dueDate']!,
            assignee: t['assignee']!,
            tags: t['tags']!,
            isImportant: t['isImportant']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context), // Pass parent context
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFBFA76A),
      ),
    );
  }

  void _openAddModal(BuildContext parentContext) {
    // Rename parameter
    String selectedPriority = 'High';
    final titleController = TextEditingController(text: 'Weekly sync notes');
    final descController = TextEditingController(
      text: 'Notes from this week\'s team sync...',
    );
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(parentContext).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create New Task',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24, // Heading text matches theme
                      color: const Color(0xFFD7C797),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Color(0xFFBFA76A)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Color(0xFFBFA76A)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      IconLabel(
                        icon: Icons.access_time,
                        label: 'Due Today',
                        color: const Color(0xFFD70000),
                      ),
                      const SizedBox(width: 24),
                      IconLabel(
                        icon: Icons.person,
                        label: 'Assignee',
                        color: const Color(0xFFBFA76A),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        'Priority:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFD7C797),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: selectedPriority,
                        dropdownColor: const Color(0xFF23232B),
                        style: const TextStyle(
                          color: Color(0xFFD7C797),
                          fontFamily: 'Cinzel',
                        ),
                        items: [
                          DropdownMenuItem(value: 'High', child: Text('High')),
                          DropdownMenuItem(
                            value: 'Medium',
                            child: Text('Medium'),
                          ),
                          DropdownMenuItem(value: 'Low', child: Text('Low')),
                          DropdownMenuItem(
                            value: 'Legendary',
                            child: Text('Legendary'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null)
                            setState(() => selectedPriority = value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBFA76A),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontFamily: 'Cinzel',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(parentContext).showSnackBar(
                          const SnackBar(
                            content: Text(
                              '(UI-only) Task created',
                              style: TextStyle(
                                color: Colors.white,
                              ), // Make text white
                            ),
                            backgroundColor: Color(0xFF23232B),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: const Text('Create (UI only)'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
