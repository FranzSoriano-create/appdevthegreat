import 'package:flutter/material.dart';

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
