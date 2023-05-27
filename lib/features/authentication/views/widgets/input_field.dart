import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/sizes.dart';

class InputField extends ConsumerWidget {
  final IconData? icon;
  final void Function() onTapFunction;
  final TextEditingController textEditingController;
  final String? hintText;
  final bool? enabled;

  const InputField(
      {super.key,
      required this.textEditingController,
      required this.onTapFunction,
      this.icon,
      this.hintText,
      this.enabled = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      enabled: enabled,
      controller: textEditingController,
      cursorColor: Theme.of(context).indicatorColor,
      autocorrect: false,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
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
