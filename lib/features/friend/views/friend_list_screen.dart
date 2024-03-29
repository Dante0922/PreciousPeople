import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/constants/sizes.dart';
import 'package:precious_people/features/friend/view_models/friend_view_model.dart';
import 'package:precious_people/features/friend/views/register_friend_screen.dart';
import 'package:precious_people/features/friend/views/widgets/friend_card.dart';
import 'package:precious_people/features/relation/views/set_relation_timer_screen.dart';

import '../../../constants/gaps.dart';


class FriendListScreen extends ConsumerStatefulWidget {
  const FriendListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FriendListScreenState();
}

class _FriendListScreenState extends ConsumerState<FriendListScreen> {


  void _registerFriend() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  RegisterFriendScreen(),
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
      body: ref.watch(friendViewModel).when(
          error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
          loading: () => Center(
                child: CircularProgressIndicator(),
              ),
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Text("소중한 사람을 등록하세요."),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(
                Sizes.size20,
              ),
              itemBuilder: (context, index) {
                final friend = data[index];
                return FriendCard(friend: friend);
              },
              itemCount: data.length,
              separatorBuilder: (context, index) => Gaps.v12,
            );
          }),
    );
  }
}
