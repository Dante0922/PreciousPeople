import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/constants/sizes.dart';

import '../../../constants/gaps.dart';
import '../../relationship/views/set_relation_timer_screen.dart';

class FriendListScreen extends ConsumerStatefulWidget {
  const FriendListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FriendListScreenState();
}

class _FriendListScreenState extends ConsumerState<FriendListScreen> {
  void _onTapStar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetRelationTimer(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "친구목록",
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(
          Sizes.size16,
        ),
        itemBuilder: (context, index) {
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
                              "홍길동",
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
                        onTap: _onTapStar,
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
        },
        itemCount: 10,
        separatorBuilder: (context, index) => Gaps.v12,
      ),
    );
  }
}
