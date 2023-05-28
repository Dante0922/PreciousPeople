import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/features/authentication/view_models/change_auth_view_model.dart';
import 'package:precious_people/features/authentication/views/widgets/form_button.dart';
import 'package:precious_people/features/authentication/views/widgets/input_field.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/constants/sizes.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  static String routeUrl = "/changePassword";
  static String routeName = "changePassword";
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController =
      TextEditingController();

  String _currentPassword = "";
  String _newPassword = "";
  String _newPasswordConfirm = "";
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(() {
      setState(() {
        _currentPassword = _currentPasswordController.text;
      });
    });
    _newPasswordController.addListener(() {
      setState(() {
        _newPassword = _newPasswordController.text;
      });
    });
    _newPasswordConfirmController.addListener(() {
      setState(() {
        _newPasswordConfirm = _newPasswordConfirmController.text;
      });
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmController.dispose();
    super.dispose();
  }

  void _onClearEmailTap() {
    _currentPasswordController.clear();
  }

  void _onClearPasswordTap() {
    _newPasswordController.clear();
  }

  void _onClearPasswordConfirmTap() {
    _newPasswordConfirmController.clear();
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
    return _currentPassword.length > 7 &&
        _newPassword.length > 7 &&
        _newPasswordConfirm.length > 7;
  }

  Future<bool?> _isCurrentPasswordValid(
      BuildContext context, String password) async {
    if (_currentPassword.isEmpty) return false;
    final result = await ref
        .read(changeAuthProvider.notifier)
        .verifyPassword(context, password);
    return result;
  }

  bool? _isNewPasswordValid() {
    if (_newPassword != _newPasswordConfirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: false,
          content: Text("새로운 비밀번호가 일치하지 않습니다."),
        ),
      );
      return false;
    }
    final regExp =
        RegExp(r"^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$");
    if (!regExp.hasMatch(_newPassword)) {
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

  void _onSubmit() async {
    final validCheck = await _isCurrentPasswordValid(context, _currentPassword);
    if (_isNewPasswordValid() == false) return;
    if (validCheck == false) return;

    if (_currentPassword == _newPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: false,
          content: Text("현재 비밀번호와 새로운 비밀번호가 일치합니다."),
        ),
      );
      return;
    }

    await ref
        .read(changeAuthProvider.notifier)
        .changePassword(context, _newPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "비밀번호 변경",
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
                "현재 비밀번호",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v12,
              InputField(
                textEditingController: _currentPasswordController,
                onTapFunction: _onClearEmailTap,
                icon: FontAwesomeIcons.solidCircleXmark,
              ),
              Gaps.v24,
              const Text(
                "새로운 비밀번호",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v12,
              TextField(
                controller: _newPasswordController,
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
                controller: _newPasswordConfirmController,
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
