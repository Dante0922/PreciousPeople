import 'package:flutter/material.dart';
import '../../../../constants/sizes.dart';

class EmotionBlock extends StatefulWidget {
  const EmotionBlock({
    super.key,
    required this.emotion,
  });

  final String emotion;

  @override
  State<EmotionBlock> createState() => _EmotionButtonState();
}

class _EmotionButtonState extends State<EmotionBlock> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        microseconds: 300,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size3,
        horizontal: Sizes.size8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(
          Sizes.size20,
        ),
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Text(
        widget.emotion,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
