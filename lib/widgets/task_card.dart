import 'package:flutter/material.dart';
import 'icon_label.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String dueDate;
  final String assignee;
  final String tags;
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
            Positioned(
              right: 0,
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
