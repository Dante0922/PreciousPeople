import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/authentication/views/user_info_screen.dart';
import 'package:precious_people/authentication/views/widgets/form_button.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/constants/sizes.dart';

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  String _email = "";
  String _password = "";
  String _passwordConfirm = "";
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;
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
    _passwordConfirmController.addListener(() {
      setState(() {
        _passwordConfirm = _passwordConfirmController.text;
      });
    });
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

  void _onClearPasswordConfirmTap() {
    _passwordConfirmController.clear();
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleObscurePasswordConfirm() {
    setState(() {
      _obscurePasswordConfirm = !_obscurePasswordConfirm;
    });
  }

  bool _isValid() {
    return _email.length > 7 &&
        _password.length > 7 &&
        _passwordConfirm.length > 7;
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
    if (_password != _passwordConfirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: false,
          content: Text("비밀번호를 다시 확인해주세요."),
        ),
      );
      return false;
    }
    return true;
  }

  void _onSubmit() {
    if (_isEmailValid() == false) return;
    if (_isPasswordValid() == false) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserInfoScreen(),
      ),
    );
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
              TextField(
                controller: _emailController,
                cursorColor: Theme.of(context).indicatorColor,
                autocorrect: false,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).cardColor,
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearEmailTap,
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
              Gaps.v24,
              const Text(
                "비밀번호 확인",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v12,
              TextField(
                controller: _passwordConfirmController,
                cursorColor: Theme.of(context).indicatorColor,
                autocorrect: false,
                obscureText: _obscurePasswordConfirm,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).cardColor,
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _toggleObscurePasswordConfirm,
                        child: FaIcon(
                          _obscurePasswordConfirm
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _onClearPasswordConfirmTap,
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
              Gaps.v24,
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
