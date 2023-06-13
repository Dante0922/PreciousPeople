import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/features/friend/models/friend_profile_model.dart';
import 'package:precious_people/features/relation/views/set_relation_timer_screen.dart';

import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';
import '../../../memory/views/save_memory_screen.dart';

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

  void _setRerationTimer(BuildContext context, String friendId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetRelationTimer(friendId: friendId),
      ),
    );
  }

  void _modifyFriend(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterFriendScreen(friend: widget.friend),
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
                      widget.friend.hasAvatar
                          ? CircleAvatar(
                              radius: Sizes.size28,
                              // 추후 이미지 로드 기능 변경할 것..
                              foregroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/preciouspeople-56f0c.appspot.com/o/avatars%2F${widget.friend!.friendId}?alt=media&token=5f3c2e29-5ac8-43ac-bc5f-b1a196362a85",
                                //  "https://firebasestorage.googleapis.com/v0/b/preciouspeople-56f0c.appspot.com/o/avatars%2Fi9DeN0sRN5DTLJqJy4xB?alt=media",

                              ),
                            )
                          : CircleAvatar(
                              radius: Sizes.size28,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
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
                          onTap: () => _setRerationTimer(context, widget.friend.friendId),
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
