import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/memory/views/widgets/emotionBlock.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class MemoryDetailScreen extends ConsumerStatefulWidget {
  const MemoryDetailScreen({super.key});
  static String routeUrl = "/memoryDetailScreen";
  static String routeName = "memoryDetailScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MemoryDetailScreenState();
}

class _MemoryDetailScreenState extends ConsumerState<MemoryDetailScreen> {
  final mockEmotions = [
    "즐거움",
    "행복함",
    "유쾌함",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "소중한 추억들",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).padding.bottom,
          ),
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
                  child: Column(
                    children: [
                      Gaps.v10,
                      Image.asset(
                        "assets/images/Cream.jpeg",
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                      Row(
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
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
                        ],
                      ),
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
        ));
  }
}
