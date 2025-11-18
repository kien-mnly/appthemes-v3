import 'package:appthemes_v3/widgets/button.dart';
import 'package:flutter/material.dart';

class CustomdashboardNameModal extends StatefulWidget {
  const CustomdashboardNameModal({super.key});

  @override
  State<CustomdashboardNameModal> createState() =>
      _CustomdashboardNameModalState();
}

class _CustomdashboardNameModalState extends State<CustomdashboardNameModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Dashboard Name',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Dashboard Name',
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            Button(
              onPressed: () {
                final name = _controller.text.trim();
                if (name.isNotEmpty) {
                  Navigator.of(context).pop(name);
                }
              },
              title: 'Save',
            ),
          ],
        ),
      ],
    );
  }
}
