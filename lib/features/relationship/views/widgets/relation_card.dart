import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:precious_people/constants/gaps.dart';

import '../../../../constants/sizes.dart';
import '../../../memory/views/save_memory_screen.dart';
import '../set_relation_timer_screen.dart';

class RelationCard extends ConsumerStatefulWidget {
  final int index;
  final String name;
  const RelationCard({super.key, required this.index, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RelationCardState();
}

class _RelationCardState extends ConsumerState<RelationCard> {
  late String name = widget.name;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void doNothing(BuildContext context) {
    return;
  }

  void _setRerationCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SaveMemoryScreen(),
      ),
    );
  }

  void _setSnooze() {
    setState(() {
      name = "hello";
    });
  }

  void _setRerationTimer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetRelationTimer(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _setRerationTimer,
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              spacing: 5,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: _setRerationCard,
              icon: Icons.cloud,
              label: '추억 등록',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          dismissible: DismissiblePane(onDismissed: _setSnooze),
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              spacing: 5,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: doNothing,
              icon: Icons.snooze,
              label: '스누즈!',
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
                ), //Color(0xffACEDD9),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      top: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: Sizes.size32,
                            foregroundImage:
                                AssetImage("assets/images/Cream.jpeg"),
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
                            "Timer: 오늘",
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
