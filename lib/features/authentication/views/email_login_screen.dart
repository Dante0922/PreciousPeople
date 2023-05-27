import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/features/authentication/view_models/login_view_model.dart';
import 'package:precious_people/features/authentication/views/widgets/form_button.dart';
import 'package:precious_people/features/authentication/views/widgets/input_field.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class EmailLoginScreen extends ConsumerStatefulWidget {
  static String routeUrl = "/emailLogin";
  static String routeName = "emailLogin";
  const EmailLoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailLoginScreenState();
}

class _EmailLoginScreenState extends ConsumerState<EmailLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  bool _isValid() {
    return _email.length > 7 && _password.length > 7;
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

  bool? _isPasswordValid() {
    final regExp =
        RegExp(r"^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$");
    if (!regExp.hasMatch(_password)) {
      //정규식.hasMatch를 통해 _email의 양식이 정규식에 부합하는지 체크.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: false,
          content: Text("비밀번호는 문자/숫자/특수문자가 포함되어 있어야 합니다."),
        ),
      );
      return false;
    }
    return true;
  }

  void _onSubmit() {
    if (_isEmailValid() == false) return;
    if (_isPasswordValid() == false) return;

    ref.read(loginProvider.notifier).login(
          _email,
          _password,
          context,
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onClearEmailTap() {
    _emailController.clear();
  }

  void _onClearPasswordTap() {
    _passwordController.clear();
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "회원가입",
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
                "비밀번호",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v12,
              TextField(
                controller: _passwordController,
                cursorColor: Theme.of(context).indicatorColor,
                autocorrect: false,
                obscureText: _obscurePassword,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).cardColor,
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _toggleObscurePassword,
                        child: FaIcon(
                          _obscurePassword
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _onClearPasswordTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
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
        onTap: _onSubmit,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size64,
            right: Sizes.size32,
            left: Sizes.size32,
          ),
          child: FormButton(
            disabled: !_isValid(),
            text: "Next",
          ),
        ),
      ),
    );
  }
}
