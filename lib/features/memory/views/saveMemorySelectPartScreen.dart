import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/constants/sizes.dart';
import 'package:precious_people/features/memory/views/widgets/emotionButton.dart';

import '../../authentication/views/widgets/form_button.dart';

const emotions = [
  "즐거움",
  "행복함",
  "사랑스러움",
  "지침",
  "다정함",
  "속상함",
  "불편함",
  "흥미로움",
  "우울함",
  "외로움",
  "괴로움",
  "유쾌함",
];

class SaveMemorySelectScreen extends ConsumerStatefulWidget {
  const SaveMemorySelectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SaveMemorySelectScreenState();
}

class _SaveMemorySelectScreenState
    extends ConsumerState<SaveMemorySelectScreen> {
  final TextEditingController _memoryTextEditingController =
      TextEditingController();
  final TextEditingController _emotionEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _memoryText = "";
  final _emotionList = [];
  DateTime initialDate = DateTime.now();
  @override
  void initState() {
    _memoryTextEditingController.addListener(() {
      setState(() {
        _memoryText = _memoryTextEditingController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _memoryTextEditingController.dispose();
    _emotionEditingController.dispose();
    super.dispose();
  }

  void _onTapEmotion(String emotion) {
    if (_emotionList.contains(emotion)) {
      _emotionList.remove(emotion);
    } else {
      _emotionList.add(emotion);
    }
    _emotionEditingController.text = _emotionList.toString();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _submit() {
    context.pushReplacement('/home');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("추억 등록"),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "유진님과의 추억을 기록해보세요.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Gaps.v20,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
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
                        const Text(
                          "기록한 날짜를 선택해주세요.",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Gaps.v8,
                        SizedBox(
                          height: 100,
                          child: CupertinoDatePicker(
                            //애플디자인의 날짜 선택 위젯.
                            onDateTimeChanged: (_) {},
                            mode: CupertinoDatePickerMode
                                .date, //이 옵션을 통해 구성을 바꿀 수 있다.
                            maximumDate: initialDate, //가능한 한계 일자
                            initialDateTime: initialDate, //최초 시작 일자
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gaps.v20,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
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
                        const Text(
                          "느꼈던 감정을 간단히 남겨보세요.",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Gaps.v8,
                        Center(
                          child: Wrap(
                            // interest들의 크기를 감싸주는 위젯
                            alignment: WrapAlignment.spaceBetween,
                            runAlignment: WrapAlignment.spaceBetween,
                            runSpacing: 10,
                            spacing: 12,
                            children: [
                              for (var emotion in emotions)
                                EmotionButton(
                                  emotion: emotion,
                                  func: () => _onTapEmotion(emotion),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: _submit,
          child: const Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.size32,
              right: Sizes.size32,
              left: Sizes.size32,
            ),
            child: FormButton(
              disabled: false,
              text: "다음",
            ),
          ),
        ),
      ),
    );
  }
}
