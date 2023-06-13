import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/constants/sizes.dart';
import 'package:precious_people/features/friend/view_models/friend_view_model.dart';
import 'package:precious_people/features/relation/models/relation_history_model.dart';
import 'package:precious_people/features/relation/view_models/relation_view_model.dart';

class SetRelationTimer extends ConsumerStatefulWidget {
  final String friendId;
  const SetRelationTimer({super.key, required this.friendId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetRelationTimerState();
}

class _SetRelationTimerState extends ConsumerState<SetRelationTimer> {
  int _currentValue = 1;
  String _interval = "일";
  String _name = "";
  String _period = "";
  List<RelationHistory> _history = [];

  void _numValueChanged(value) {
    setState(() {
      _currentValue = value;
    });
  }

  void _setInterval(String interval) {
    setState(() {
      _interval = interval;
    });
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      findInformation();
    });
  }

  void findInformation() async{
    final friend = await ref.read(friendViewModel.notifier).findFriend(widget.friendId);
    setState(() {
      _name = friend.name;
    });

    final relation = await ref.read(relationViewModel.notifier).findRelation(widget.friendId);
    if(relation == null) {
      return;
    }
    final interval = calculatePeriod(relation!.period);
    final remainingDays = calculateRemainingDays(relation!.period);
    setState(() {
      _interval = interval;
      _currentValue = remainingDays;
    });
  }

  String calculatePeriod(String period) {
    int periodValue = int.tryParse(period) ?? 0; // 입력된 문자열을 정수로 변환
    if (periodValue >= 91) {
      return "월";
    } else if (periodValue >= 15) {
      return "주";
    } else if (periodValue >= 1) {
      return "일";
    } else {
      return "일";
    }
  }

  int calculateRemainingDays(String period) {
    int periodValue = int.tryParse(period) ?? 0; // 입력된 문자열을 정수로 변환
    if (periodValue >= 31) {
      return periodValue ~/ 31;
    } else if (periodValue >= 7) {
      return periodValue ~/ 7;
    } else if (periodValue >= 1) {
      return periodValue;
    } else {
      return periodValue;
    }
  }

  int calculatePeriodValue(String interval, int value) {
    if (interval == "월") {
      return value * 31;
    } else if (interval == "주") {
      return value * 7;
    } else if (interval == "일") {
      return value;
    } else {
      return value;
    }
  }


  void _submit() {
    String period = calculatePeriodValue(_interval, _currentValue).toString();
    ref.read(relationViewModel.notifier).createRelation(context, widget.friendId, period);
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "관계 타이머",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            Gaps.v20,
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(3, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  Sizes.size14,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Text(
                      _name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size44,
                      ),
                    ),
                    Text(
                      _interval == "월"
                          ? "$_currentValue 개$_interval"
                          : "$_currentValue $_interval",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: Sizes.size44,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.v20,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(3, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    Sizes.size14,
                  ),
                ),
                child: Column(
                  children: [
                    Gaps.v20,
                    Center(
                      child: Text(
                        "타이머 설정",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NumberPicker(
                          minValue: 1,
                          maxValue: 30,
                          value: _currentValue,
                          onChanged: _numValueChanged,
                          textStyle: const TextStyle(color: Colors.white),
                          selectedTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size32,
                          ),
                        ),
                        Row(
                          children: [
                            FloatingActionButton(
                              heroTag: 1,
                              backgroundColor: _interval == "일"
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).primaryColor,
                              onPressed: () => _setInterval("일"),
                              child: const Text(
                                "일",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Gaps.h10,
                            FloatingActionButton(
                              heroTag: 2,
                              backgroundColor: _interval == "주"
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).primaryColor,
                              onPressed: () => _setInterval("주"),
                              child: const Text(
                                "주",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizes.size20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Gaps.h10,
                            FloatingActionButton(
                              heroTag: 3,
                              backgroundColor: _interval == "월"
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).primaryColor,
                              onPressed: () => _setInterval("월"),
                              child: const Text(
                                "월",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizes.size20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gaps.v24,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: Offset(3, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    Sizes.size14,
                  ),
                ),
                child: Column(
                  children: [
                    Gaps.v20,
                    Center(
                      child: Text(
                        "최근 기록",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom +
              MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: CupertinoButton(
          color: Theme.of(context).colorScheme.secondary,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          onPressed: _submit,
          child: Text(
            "등록",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
