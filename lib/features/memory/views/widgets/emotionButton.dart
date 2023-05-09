import 'package:flutter/material.dart';
import '../../../../constants/sizes.dart';

class EmotionButton extends StatefulWidget {
  const EmotionButton({
    super.key,
    required this.emotion,
    required this.func,
  });

  final String emotion;
  final Function func;

  @override
  State<EmotionButton> createState() => _EmotionButtonState();
}

class _EmotionButtonState extends State<EmotionButton> {
  bool _isSelected = false;

  void _onTap() {
    widget.func();
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(
          microseconds: 300,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey.shade200,
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isSelected
                ? Colors.white
                : Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
