import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/common/widgets/nav_tab.dart';
import 'package:precious_people/features/relation/views/releation_list_screen.dart';


import '../constants/sizes.dart';
import '../features/friend/views/friend_list_screen.dart';
import '../features/memory/views/memory_list_screen.dart';
import '../features/user/views/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const routeName = "MainNavigation";
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "friends",
    "memories",
    "settings",
  ];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // flutter는 키보드가 나타날 떄 자동으로 body를 축소시킨다.
      //이를 방지하기 위해 false를 해주면 키보드가 화면을 가리는 형태가 된다.
      body: Stack(
        children: [
          Offstage(
            //Offstage는 네비게이터의 여러 탭을 한번에 구동시킨다. 이와 같이 처리해야 다른 탭에 갔다가 와도 캐시가 유지된다.
            offstage: _selectedIndex != 0,
            child: const RelationListScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const FriendListScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const MemoryListScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const SettingsScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(
                    0), //widget을 만들어서 onTap을 required로 지정해뒀다. _onTap(0)을 실행시킴.
              ),
              NavTab(
                text: "Friends",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.solidUser,
                selectedIcon: FontAwesomeIcons.solidUser,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(
                    1), //widget을 만들어서 onTap을 required로 지정해뒀다. _onTap(0)을 실행시킴.
              ),
              NavTab(
                text: "Memories",
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.cloud,
                selectedIcon: FontAwesomeIcons.cloud,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(
                    2), //widget을 만들어서 onTap을 required로 지정해뒀다. _onTap(0)을 실행시킴.
              ),
              NavTab(
                text: "Settings",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.ellipsisVertical,
                selectedIcon: FontAwesomeIcons.ellipsisVertical,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(
                    3), //widget을 만들어서 onTap을 required로 지정해뒀다. _onTap(0)을 실행시킴.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
