import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/constants/sizes.dart';

class SetRelationTimer extends ConsumerStatefulWidget {
  const SetRelationTimer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetRelationTimerState();
}

class _SetRelationTimerState extends ConsumerState<SetRelationTimer> {
  int _currentValue = 1;
  String _interval = "";

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

  void _submit() {
    context.pushReplacement('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("관계 타이머"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Gaps.v20,
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  Sizes.size14,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "홍길동",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size44,
                      ),
                    ),
                    Text(
                      _interval == "월"
                          ? "$_currentValue 개$_interval"
                          : "$_currentValue $_interval",
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: Sizes.size44,
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
                  borderRadius: BorderRadius.circular(
                    Sizes.size14,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NumberPicker(
                      minValue: 1,
                      maxValue: 30,
                      value: _currentValue,
                      onChanged: _numValueChanged,
                      textStyle: const TextStyle(color: Colors.white),
                      selectedTextStyle: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size32,
                      ),
                    ),
                    Row(
                      children: [
                        FloatingActionButton(
                          heroTag: 1,
                          backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () => _setInterval("일"),
                          child: Text(
                            "일",
                            style: TextStyle(
                                color: _interval == "일"
                                    ? Colors.amber
                                    : Colors.white,
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Gaps.h10,
                        FloatingActionButton(
                          heroTag: 2,
                          backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () => _setInterval("주"),
                          child: Text(
                            "주",
                            style: TextStyle(
                                color: _interval == "주"
                                    ? Colors.amber
                                    : Colors.white,
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Gaps.h10,
                        FloatingActionButton(
                          heroTag: 3,
                          backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () => _setInterval("월"),
                          child: Text(
                            "월",
                            style: TextStyle(
                                color: _interval == "월"
                                    ? Colors.amber
                                    : Colors.white,
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Gaps.v72,
            CupertinoButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.43,
                vertical: Sizes.size20,
              ),
              onPressed: _submit,
              child: const Text("등록"),
            ),
          ],
        ),
      ),
    );
  }
}
