import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/features/memory/views/saveMemoryScreen.dart';

import '../../../../constants/sizes.dart';
import '../../../relationship/views/setRelationTimerScreen.dart';
import 'emotionBlock.dart';

class MemoryCard extends ConsumerStatefulWidget {
  final int index;
  final String name;
  const MemoryCard({super.key, required this.index, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryCardState();
}

class _MemoryCardState extends ConsumerState<MemoryCard> {
  late String name = widget.name;

  final mockEmotions = [
    "즐거움",
    "행복함",
    "유쾌함",
  ];

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
    setState(() {
      name = "Snooze";
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
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            //자식의 면 비율을 결정해주는 위젯 부모는 9/20이고 이것은 9/16이라 남는 9/4에 텍스트를 채운다는 개념.
            aspectRatio: 10 / 4.5, // 박스 사이즈 조절 !!
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
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "With 유진",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: Sizes.size18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gaps.v3,
                                Row(
                                  children: [
                                    Center(
                                      child: Wrap(
                                        // interest들의 크기를 감싸주는 위젯
                                        alignment: WrapAlignment.spaceBetween,
                                        runAlignment:
                                            WrapAlignment.spaceBetween,
                                        runSpacing: 10,
                                        spacing: 12,
                                        children: [
                                          for (var emotion in mockEmotions)
                                            EmotionBlock(
                                              emotion: emotion,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v12,
                                Text(
                                  "피크닉을 다녀왔다. 날씨가 좋았다!! 피치피치피치피치",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/images/Cream.jpeg",
                          width: 100,
                          height: 100,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 20,
                    child: Text(
                      "23.05.05",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
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
