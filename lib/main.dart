// main.dart
import 'package:flutter/material.dart';

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
      'title': 'Write unit tests',
      'description': 'Cover TaskCard widget and interactive behavior.',
      'priority': 'High',
      'dueDate': '2025-09-22',
      'assignee': 'Solaire',
      'tags': 'Testing, Code',
      'isImportant': 'true',
    },
    {
      'title': 'Refactor auth',
      'description': 'Move logic into a reusable AuthService and clean up UI.',
      'priority': 'Low',
      'dueDate': '2025-09-25',
      'assignee': 'Artorias',
      'tags': 'Refactor, Backend',
      'isImportant': 'false',
    },
    {
      'title': 'Design review',
      'description': 'Prepare slides for Friday review with product.',
      'priority': 'High',
      'dueDate': '2025-09-20',
      'assignee': 'Gwyn',
      'tags': 'Design, Slides',
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
            tags: t['tags']!, // Now a String
            isImportant: t['isImportant']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFBFA76A),
      ),
    );
  }

  void _openAddModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Task', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 8),
                const TextField(
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Create (UI only)'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ---------------------------
/// Widget: TaskCard (Stateless)
/// ---------------------------
class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String dueDate;
  final String assignee;
  final String tags; // Changed from List<String> to String
  final String isImportant;
  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.assignee,
    required this.tags,
    required this.isImportant,
  });

  Color get priorityColor => priority.toLowerCase() == 'high'
      ? const Color(0xFFD70000)
      : const Color(0xFF6C757D);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF23232B),
      elevation: isImportant == "true" ? 8 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Stack(
          children: [
            // Priority badge at top-right
            Positioned(
              right: 0, // Changed from left: 0 to right: 0
              top: 0,
              child: _PriorityBadge(priority: priority),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                                color: const Color(0xFFD7C797),
                              ),
                        ),
                      ),
                      if (isImportant == "true")
                        const Icon(
                          Icons.star,
                          color: Color(0xFFD7C797),
                          size: 28,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Tag row (split tags string)
                  Wrap(
                    spacing: 8,
                    children: tags
                        .split(',')
                        .map(
                          (tag) => Chip(
                            label: Text(tag.trim()),
                            backgroundColor: const Color(0xFF18181A),
                            labelStyle: const TextStyle(
                              color: Color(0xFFBFA76A),
                              fontFamily: 'Merriweather',
                            ),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: priorityColor,
                                width: 1.2,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: const Color(0xFFBFA76A),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      IconLabel(
                        icon: Icons.calendar_today,
                        label: 'Due: $dueDate',
                        color: priorityColor,
                      ),
                      const SizedBox(width: 18),
                      IconLabel(
                        icon: Icons.person,
                        label: assignee,
                        color: priorityColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pill-style PriorityBadge with Dark Souls colors
class _PriorityBadge extends StatelessWidget {
  final String priority;
  const _PriorityBadge({super.key, required this.priority});
  Color get _color => priority.toLowerCase() == 'high'
      ? const Color(0xFFD70000)
      : const Color(0xFF6C757D);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color, width: 1.5),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: _color,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cinzel',
          fontSize: 14,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

/// ---------------------------
/// Reusable IconLabel widget
/// ---------------------------
class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  const IconLabel({
    super.key,
    required this.icon,
    required this.label,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            color: color,
            fontFamily: 'Merriweather',
          ),
        ),
      ],
    );
  }
}
