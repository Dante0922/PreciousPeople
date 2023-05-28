import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/user/view_models/users_view_model.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  static String routeUrl = "/settings";
  static String routeName = "settings";
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _onPressedLogOut(BuildContext context) {
    context.go("/splash");
  }

  void _goToUserSettingScreen(BuildContext context) {
    context.pushNamed("userSetting");
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
        error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        data: (data) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "설정",
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
                                  top: 20,
                                  left: 30,
                                  bottom: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data.name}님",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          fontSize: Sizes.size18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        data.email,
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
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
                                    onTap: () =>
                                        _goToUserSettingScreen(context),
                                    child: FaIcon(
                                      FontAwesomeIcons.gear,
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                                FontAwesomeIcons.bullhorn,
                                color: Theme.of(context).primaryColor,
                              ),
                              Gaps.h20,
                              Text(
                                "공지사항",
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
                                FontAwesomeIcons.circleQuestion,
                                color: Theme.of(context).primaryColor,
                              ),
                              Gaps.h20,
                              Text(
                                "도움말",
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
                                FontAwesomeIcons.envelope,
                                color: Theme.of(context).primaryColor,
                              ),
                              Gaps.h20,
                              Text(
                                "문의하기",
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
                                FontAwesomeIcons.heart,
                                color: Theme.of(context).primaryColor,
                              ),
                              Gaps.h20,
                              Text(
                                "리뷰쓰기",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                            ],
                          ),
                          Gaps.v40,
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.palette,
                                color: Theme.of(context).primaryColor,
                              ),
                              Gaps.h20,
                              Text(
                                "테마변경",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                            ],
                          ),
                          Gaps.v20,
                        ],
                      ),
                    ),
                    Gaps.v80,
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
            ));
  }
}
