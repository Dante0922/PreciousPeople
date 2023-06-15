import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/features/friend/view_models/friend_view_model.dart';
import 'package:precious_people/features/memory/views/save_memory_screen.dart';
import 'package:precious_people/features/relation/models/relation_model.dart';
import 'package:precious_people/features/relation/view_models/relation_view_model.dart';

import '../../../../constants/sizes.dart';
import '../set_relation_timer_screen.dart';

class RelationCard extends ConsumerStatefulWidget {
  final int index;
  final String name;
  final RelationModel relation;

  const RelationCard(
      {super.key,
      required this.index,
      required this.name,
      required this.relation});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RelationCardState();
}

class _RelationCardState extends ConsumerState<RelationCard> {
  late String name = widget.name;
  bool _hasAvatar = false;
  String _remainingDays = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      findInformation();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void findInformation() async{
    final friend = await ref.read(friendViewModel.notifier).findFriend(widget.relation.friendId);
    setState(() {
      _hasAvatar = friend.hasAvatar;
    });

    String nowDate = DateTime.now().toString();
    String endDate = widget.relation.endDate.toString();

    setState(() {
      _remainingDays = (DateTime.parse(endDate).difference(DateTime.parse(nowDate)).inDays).toString();
    });
  }

  void _saveMemory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SaveMemorySelectScreen(),
      ),
    );
  }

  void _setSnooze(BuildContext context) {



    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: const Text(
          "Snooze!",
        ),
      ),
    );
    ref.read(relationViewModel.notifier).snoozeRelation(context, widget.relation.friendId, widget.relation);
  }

  void _setRerationTimer(String friendId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetRelationTimer(friendId: friendId),
      ),
    );
  }



  void _setDone(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        showCloseIcon: false,
        duration: const Duration(seconds: 3),
        content: Stack(
          children: [
            const Row(
              children: [
                Gaps.h16,
                Text("타이머 완료"),
              ],
            ),
            Positioned(
              right: Sizes.size16,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  _saveMemory();
                }, // 스터디 때 질문할 것..
                child: Container(
                  width: 80,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "추억 등록",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    setState(() {
      name = "done";
    });
  }

  @override
  Widget build(BuildContext context) {
    final friend =
        ref.read(friendViewModel.notifier).findFriend(widget.relation.friendId);
    return GestureDetector(
      onTap: () => _setRerationTimer(widget.relation.friendId),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          key: UniqueKey(),
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              _setSnooze(context);
            },
          ),
          children: [
            SlidableAction(
              key: UniqueKey(),
              spacing: 5,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: _setSnooze,
              icon: Icons.snooze,
              label: '스누즈',
            ),
          ],
        ),
        endActionPane: ActionPane(
          key: UniqueKey(),
          extentRatio: 0.25,
          dismissible: DismissiblePane(
            onDismissed: () => _setDone(context),
          ),
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              key: UniqueKey(),
              spacing: 5,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: (_) {
                _setDone(context);
              },
              // 스터디 때 질문할 것.
              icon: Icons.done,
              label: '완료!',
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              //자식의 면 비율을 결정해주는 위젯 부모는 9/20이고 이것은 9/16이라 남는 9/4에 텍스트를 채운다는 개념.
              aspectRatio: 10 / 2.5,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(
                    // 이것만 한다면 사진이 콘테이너를 초과하기 때문에 효과가 안 먹는다. clipBehavior도 해줘야 함.
                    Sizes.size20,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(3, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      top: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          _hasAvatar ?
                          CachedNetworkImage(
                            imageUrl:
                                "https://firebasestorage.googleapis.com/v0/b/preciouspeople-56f0c.appspot.com/o/avatars%2F${widget.relation!.friendId}?alt=media&token=5f3c2e29-5ac8-43ac-bc5f-b1a196362a85",
                            imageBuilder: (context, imageProvider) => Container(
                              width: 56.0,
                              height: 56.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const FaIcon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: Sizes.size28,
                            ),
                          ) : CircleAvatar(
                            radius: Sizes.size28,
                            backgroundColor:
                            Theme.of(context).colorScheme.primary,
                            child: const FaIcon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: Sizes.size28,
                            ),
                          ),
                          Gaps.h20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                  fontSize: Sizes.size20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 50,
                      top: 24,
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "기다림: ${_remainingDays}일",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size18,
                            ),
                          ),
                          Gaps.v1,
                          Text(
                            "마지막 기록: 하루 전",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Sizes.size12,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
