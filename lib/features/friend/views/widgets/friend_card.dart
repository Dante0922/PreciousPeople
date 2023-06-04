import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/features/friend/models/friend_profile_model.dart';

import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';
import '../../../memory/views/save_memory_screen.dart';
import '../../../relationship/views/set_relation_timer_screen.dart';
import '../register_friend_screen.dart';

class FriendCard extends ConsumerStatefulWidget {
  final FriendProfileModel friend;

  const FriendCard({super.key, required this.friend});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendCardState();
}

class _FriendCardState extends ConsumerState<FriendCard> {
  bool isFavorite = false;
  String _year = "";
  String _month = "";

  @override
  void initState() {
    _calculateDate();
    super.initState();
  }

  void _saveMemory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SaveMemorySelectScreen(),
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
        builder: (context) =>  RegisterFriendScreen(friend: widget.friend),
      ),
    );
  }

  void _onTapFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _calculateDate() {
    final DateTime now = DateTime.now();
    final test = DateTime.parse(widget.friend.friendaversery).difference(now);
    final year = test.inDays ~/ 365 * -1;
    final month = (test.inDays % 365) ~/ 30;
    _year = year.toString();
    _month = month.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _modifyFriend(context),
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
                            widget.friend.name,
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            "소중한 관계 $_year년",
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
                        Gaps.h10,
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
