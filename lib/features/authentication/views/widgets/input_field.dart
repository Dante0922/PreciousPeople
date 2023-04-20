import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/sizes.dart';

class InputField extends ConsumerWidget {
  final IconData icon;
  final void Function() onTapFunction;
  final TextEditingController textEditingController;
  const InputField({
    super.key,
    required this.textEditingController,
    required this.onTapFunction,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: textEditingController,
      cursorColor: Theme.of(context).indicatorColor,
      autocorrect: false,
      maxLines: 1,
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => onTapFunction(),
              child: FaIcon(
                icon,
                color: Colors.grey.shade500,
                size: Sizes.size20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
