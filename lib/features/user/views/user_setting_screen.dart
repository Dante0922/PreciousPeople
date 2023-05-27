import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/authentication/view_models/change_auth_view_model.dart';
import 'package:precious_people/features/authentication/view_models/login_view_model.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class UserSettingScreen extends ConsumerStatefulWidget {
  static String routeUrl = "/userSetting";
  static String routeName = "userSetting";
  const UserSettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      UserSettingScreenState();
}

class UserSettingScreenState extends ConsumerState<UserSettingScreen> {
  void _onPressedLogOut(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("로그아웃 하시겠습니까?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("취소"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text("확인"),
            onPressed: () {
              ref.read(loginProvider.notifier).logOut(context);
              context.go("/splash");
            },
          ),
        ],
      ),
    );
  }

  void _onPressedUserInfo(BuildContext context) {
    context.pushNamed("userInfo");
  }

  void _onPressedDropOut(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("정말 탈퇴하시겠습니까? \n탈퇴하면 모든 정보가 삭제됩니다."),
        actions: [
          CupertinoDialogAction(
            child: const Text("취소"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text("확인"),
            onPressed: () {
              ref.read(changeAuthProvider.notifier).dropOut(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "마이페이지",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  //자식의 면 비율을 결정해주는 위젯 부모는 9/20이고 이것은 9/16이라 남는 9/4에 텍스트를 채운다는 개념.
                  aspectRatio: 10 / 2.5, // 박스 사이즈 조절 !!
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(
                        // 이것만 한다면 사진이 콘테이너를 초과하기 때문에 효과가 안 먹는다. clipBehavior도 해줘야 함.
                        Sizes.size20,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(3, 4),
                        ),
                      ],
                    ), //Color(0xffACEDD9),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 30,
                          left: 30,
                          bottom: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "기본정보수정",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: Sizes.size18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 30,
                          top: 30,
                          bottom: 20,
                          child: GestureDetector(
                            onTap: () => _onPressedUserInfo(context),
                            child: FaIcon(
                              FontAwesomeIcons.chevronRight,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v80,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.minus,
                        color: Theme.of(context).primaryColor,
                      ),
                      Gaps.h20,
                      Text(
                        "비밀번호 변경",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.minus,
                        color: Theme.of(context).primaryColor,
                      ),
                      Gaps.h20,
                      Text(
                        "약관 및 이용동의",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: () => _onPressedLogOut(context),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.minus,
                          color: Theme.of(context).primaryColor,
                        ),
                        Gaps.h20,
                        Text(
                          "로그아웃",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: () => _onPressedDropOut(context),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.minus,
                          color: Theme.of(context).primaryColor,
                        ),
                        Gaps.h20,
                        Text(
                          "회원탈퇴",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v20,
                ],
              ),
            ),
            Gaps.v80,
            Gaps.v60,
            Text(
              "소중한 사람들",
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
            Text(
              "버전 1.0.0",
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
            // Center(
            //   child: CupertinoButton(
            //     color: Theme.of(context).primaryColor,
            //     onPressed: () => _onPressedLogOut(context),
            //     child: const Text("Log out"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
