import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';
import '../../../memory/views/save_memory_screen.dart';
import '../../../relationship/views/set_relation_timer_screen.dart';
import '../register_friend_screen.dart';

class FriendCard extends ConsumerStatefulWidget {
  const FriendCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendCardState();
}

class _FriendCardState extends ConsumerState<FriendCard> {
  bool isFavorite = false;

  void _saveMemory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SaveMemoryScreen(),
      ),
    );
  }

  void _setRerationTimer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetRelationTimer(),
      ),
    );
  }

  void _modifyFriend(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterFriendScreen(),
      ),
    );
  }

  void _onTapFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _modifyFriend(context),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                bottom: Sizes.size10,
                top: Sizes.size10,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade100,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Gaps.h10,
                      CircleAvatar(
                        radius: Sizes.size28,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const FaIcon(
                          FontAwesomeIcons.user,
                          color: Colors.white,
                          size: Sizes.size28,
                        ),
                      ),
                      Gaps.h16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "유진",
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            "알고 지낸 지 3년",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Sizes.size12,
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
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => _saveMemory(context),
                          child: FaIcon(
                            true // 추후 타이머가 등록여부에 따라 아이콘 바꿔줄 것
                                ? FontAwesomeIcons.cloud
                                : FontAwesomeIcons.solidStar,
                            size: Sizes.size24,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Gaps.h20,
                        GestureDetector(
                          onTap: () => _setRerationTimer(context),
                          child: FaIcon(
                            true // 추후 타이머가 등록여부에 따라 아이콘 바꿔줄 것
                                ? FontAwesomeIcons.clock
                                : FontAwesomeIcons.solidStar,
                            size: Sizes.size24,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Gaps.h20,
                        GestureDetector(
                          onTap: _onTapFavorite,
                          child: FaIcon(
                            isFavorite // 추후 타이머가 등록여부에 따라 아이콘 바꿔줄 것
                                ? FontAwesomeIcons.solidStar
                                : FontAwesomeIcons.star,
                            size: Sizes.size24,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
