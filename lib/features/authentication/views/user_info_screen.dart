import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/authentication/views/widgets/form_button.dart';
import 'package:precious_people/features/authentication/views/widgets/input_field.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  String _name = "";
  String _email = "";
  bool _showPicker = false;
  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    DateTime twelveYearsAgo = DateTime(initialDate.year -
        12); //DateTime() 파라미터로 DateTimeSample.year -12 를 하면 12년 전 DateTimeSample의 날짜를 반환한다.
    _setTextFieldDate(twelveYearsAgo);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _onClearNameTap() {
    _nameController.clear();
  }

  void _onClearEmailTap() {
    _emailController.clear();
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(
        text:
            textDate); //Controller.value를 통해 해당 Controller가 컨트롤하는 영역의 Value를 바꿀 수 있다.
  }

  void _showDatePicker() {
    setState(() {
      _showPicker = !_showPicker;
    });
  }

  bool _isValid() {
    return _email.length > 7 && _name.isNotEmpty;
  }

  void _onSubmit() {
    if (_isEmailValid() == false) return;
    context.go("/home");
  }

  bool? _isEmailValid() {
    if (_email.isEmpty) return false;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"); //정규식? 이메일 양식이 맞는지 판단해준다.
    if (!regExp.hasMatch(_email)) {
      //정규식.hasMatch를 통해 _email의 양식이 정규식에 부합하는지 체크.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: false,
          content: Text("이메일 양식이 옳지 않습니다."),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "기본정보",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              const Text(
                "이름",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v12,
              InputField(
                textEditingController: _nameController,
                onTapFunction: _onClearNameTap,
                icon: FontAwesomeIcons.solidCircleXmark,
              ),
              Gaps.v24,
              const Text(
                "이메일",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v12,
              InputField(
                textEditingController: _emailController,
                onTapFunction: _onClearEmailTap,
                icon: FontAwesomeIcons.solidCircleXmark,
              ),
              Gaps.v24,
              const Text(
                "생년월일",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v12,
              GestureDetector(
                onTap: _showDatePicker,
                child: TextField(
                  controller:
                      _birthdayController, // 이 텍스트필드는 이 컨트롤러를 통해 제어된다. 하단의 데이트픽커를 통해 Controller.value가 바뀌면 텍스트필드의 값이 바뀐다.
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    enabled: false,
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: Sizes.size64,
          right: Sizes.size32,
          left: Sizes.size32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _showPicker
                ? SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      //애플디자인의 날짜 선택 위젯.
                      onDateTimeChanged: _setTextFieldDate,
                      mode:
                          CupertinoDatePickerMode.date, //이 옵션을 통해 구성을 바꿀 수 있다.
                      maximumDate: initialDate, //가능한 한계 일자
                      initialDateTime: initialDate, //최초 시작 일자
                    ),
                  )
                : Container(),
            Gaps.v12,
            GestureDetector(
              onTap: _onSubmit,
              child: FormButton(
                disabled: !_isValid(),
                text: "Next",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
