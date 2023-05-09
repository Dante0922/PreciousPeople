import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/constants/sizes.dart';
import 'package:precious_people/features/friend/views/register_friend_screen.dart';
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

  void _registerFriend() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterFriendScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "친구목록",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: Sizes.size20,
            ),
            child: IconButton(
              onPressed: _registerFriend,
              icon: FaIcon(
                FontAwesomeIcons.plus,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(
          Sizes.size20,
        ),
        itemBuilder: (context, index) {
          return const FriendCard();
        },
        itemCount: 20,
        separatorBuilder: (context, index) => Gaps.v12,
      ),
    );
  }
}
