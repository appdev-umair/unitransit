import 'package:flutter/material.dart';

class DividerOr extends StatelessWidget {
  const DividerOr({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDividerWithOrText(context);
  }

    Widget _buildDividerWithOrText(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "Or",
            style: Theme.of(context).textTheme.bodyLarge
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}