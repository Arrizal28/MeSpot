import 'package:flutter/material.dart';

class MespotTextField extends StatelessWidget {
  final String label;
  const MespotTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          label: Text(label), prefixIcon: const Icon(Icons.search)),
    );
  }
}
