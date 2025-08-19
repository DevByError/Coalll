import 'package:flutter/material.dart';

enum PasswordStrength { weak, medium, strong }

class PasswordStrengthIndicator extends StatelessWidget {
  final PasswordStrength strength;

  const PasswordStrengthIndicator({super.key, required this.strength});

  Color _getColor() {
    switch (strength) {
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.medium:
        return Colors.orange;
      case PasswordStrength.strong:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getText() {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
      default:
        return '';
    }
  }

  double _getWidth(BoxConstraints constraints) {
    switch (strength) {
      case PasswordStrength.weak:
        return constraints.maxWidth * 0.3;
      case PasswordStrength.medium:
        return constraints.maxWidth * 0.6;
      case PasswordStrength.strong:
        return constraints.maxWidth;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_getText(), style: TextStyle(color: _getColor())),
            const SizedBox(height: 4),
            Container(
              height: 6,
              width: _getWidth(constraints),
              decoration: BoxDecoration(
                color: _getColor(),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        );
      },
    );
  }
}
