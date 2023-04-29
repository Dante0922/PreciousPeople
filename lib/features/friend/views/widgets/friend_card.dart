import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class FriendCard extends ConsumerWidget {
  final void Function(BuildContext) onTapFunction;
  const FriendCard({super.key, required this.onTapFunction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: Sizes.size32,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.amber,
                      size: Sizes.size28,
                    ),
                  ),
                  Gaps.h20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "유진",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "알고 지낸 지 3년",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: Sizes.size10,
                top: Sizes.size10,
                bottom: Sizes.size10,
                child: GestureDetector(
                  onTap: () => onTapFunction(context),
                  child: const FaIcon(
                    true // 추후 타이머가 등록여부에 따라 아이콘 바꿔줄 것
                        ? FontAwesomeIcons.star
                        : FontAwesomeIcons.solidHeart,
                    size: Sizes.size28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
