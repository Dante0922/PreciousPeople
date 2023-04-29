import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/constants/sizes.dart';
import 'package:precious_people/features/friend/views/widgets/friend_card.dart';

import '../../../constants/gaps.dart';
import '../../relationship/views/set_relation_timer_screen.dart';

class FriendListScreen extends ConsumerStatefulWidget {
  const FriendListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FriendListScreenState();
}

class _FriendListScreenState extends ConsumerState<FriendListScreen> {
  void _onTapStar(BuildContext context) {
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
          return FriendCard(onTapFunction: _onTapStar);
        },
        itemCount: 20,
        separatorBuilder: (context, index) => Gaps.v12,
      ),
    );
  }
}
