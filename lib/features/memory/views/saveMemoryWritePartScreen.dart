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

class SaveMemoryWriteScreen extends ConsumerStatefulWidget {
  const SaveMemoryWriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SaveMemoryWriteScreenState();
}

class _SaveMemoryWriteScreenState extends ConsumerState<SaveMemoryWriteScreen> {
  final TextEditingController _memoryTextEditingController =
      TextEditingController();
  final TextEditingController _emotionEditingController =
      TextEditingController();

  String _memoryText = "";
  final _emotionList = [];

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
        body: Column(
          children: [
            Gaps.v8,
            Column(
              children: [
                TextField(
                  controller: _memoryTextEditingController,
                  cursorColor: Theme.of(context).focusColor,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "오늘 당신의 추억을 기록하세요.",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                Gaps.v10,
                TextField(
                  controller: _emotionEditingController,
                  cursorColor: Theme.of(context).focusColor,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "오늘 당신의 추억을 선택하세요.",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v20,
            Wrap(
              // interest들의 크기를 감싸주는 위젯
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
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: _submit,
          child: const Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.size64,
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
