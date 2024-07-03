import 'package:flutter/material.dart';
import 'package:spotify_clone_flutter/core/configs/theme/app_colors.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double height;
  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height = 80,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height),
        backgroundColor: AppColors.primary,
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
