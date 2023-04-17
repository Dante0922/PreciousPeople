import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  String _email = "";
  String _password = "";

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              Gaps.v24,
              TextField(
                controller: _emailController,
                cursorColor: Theme.of(context).primaryColor,
                autocorrect: false,
                decoration: InputDecoration(
                    suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleXmark,
                        color: Colors.grey.shade500,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                )),
              ),
              Gaps.v24,
              const Text(
                "비밀번호",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v24,
              const TextField(),
              Gaps.v24,
              const Text(
                "비밀번호 확인",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.v24,
              const TextField(),
            ],
          ),
        ),
      ),
    );
  }
}
