import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:precious_people/constants/gaps.dart';

import '../../../../constants/sizes.dart';

class RelationCard extends ConsumerStatefulWidget {
  const RelationCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RelationCardState();
}

class _RelationCardState extends ConsumerState<RelationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              // 이것만 한다면 사진이 콘테이너를 초과하기 때문에 효과가 안 먹는다. clipBehavior도 해줘야 함.
              Sizes.size20,
            ),
          ),
          child: AspectRatio(
            //자식의 면 비율을 결정해주는 위젯 부모는 9/20이고 이것은 9/16이라 남는 9/4에 텍스트를 채운다는 개념.
            aspectRatio: 10 / 2.5,
            child: Container(
              color: Colors.amber,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
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
                          children: [
                            Gaps.v8,
                            const Text(
                              "홍길동",
                              style: TextStyle(
                                fontSize: Sizes.size24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Gaps.v4,
                            Text(
                              "친구",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Timer: 오늘",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Gaps.v12,
                        Text(
                          "마지막 기록: 하루 전",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
