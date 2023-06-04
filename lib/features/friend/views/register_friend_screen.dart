import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precious_people/constants/gaps.dart';
import 'package:precious_people/features/authentication/repos/authentication_repo.dart';
import 'package:precious_people/features/authentication/views/widgets/input_field.dart';
import 'package:precious_people/features/friend/models/friend_profile_model.dart';
import 'package:precious_people/features/friend/view_models/friend_view_model.dart';
import 'package:precious_people/features/relationship/views/set_relation_timer_screen.dart';

import '../../../constants/sizes.dart';

class RegisterFriendScreen extends ConsumerStatefulWidget {
  FriendProfileModel? friend;

  RegisterFriendScreen({super.key, this.friend});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterFriendScreenState();
}

class _RegisterFriendScreenState extends ConsumerState<RegisterFriendScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _momentEditingController =
      TextEditingController();
  final TextEditingController _contactEditingController =
      TextEditingController();

  DateTime initialDate = DateTime.now();
  DateTime maximumDate = DateTime.now();
  String _name = "";
  String _friendaversery = "";
  String _contact = "";

  @override
  void initState() {
    super.initState();
    _nameEditingController.addListener(() {
      setState(() {
        _name = _nameEditingController.text;
      });
    });
    _momentEditingController.addListener(() {
      setState(() {
        _friendaversery = _momentEditingController.text;
      });
    });
    _contactEditingController.addListener(() {
      setState(() {
        _contact = _contactEditingController.text;
      });
    });
    if (widget.friend != null) {
      _nameEditingController.text = widget.friend!.name;
      _momentEditingController.text = widget.friend!.friendaversery;
      _contactEditingController.text = widget.friend!.contact;
      initialDate = DateTime.parse(widget.friend!.friendaversery);
    }
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _momentEditingController.dispose();
    _contactEditingController.dispose();
    super.dispose();
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _momentEditingController.value = TextEditingValue(text: textDate);
  }

  void _submit(BuildContext context) async {
    final uid = ref.read(authRepo).user!.uid;
    if (_name.isEmpty || _friendaversery.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: false,
          content: Text("이름과 시기를 등록하세요."),
        ),
      );
      return;
    }
    if (widget.friend == null) {
      ref
          .read(friendViewModel.notifier)
          .createFriend(_name, _friendaversery, _contact, context);
    } else {
      ref.read(friendViewModel.notifier).updateFriend(
          widget.friend!, _name, _friendaversery, _contact, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "친구 추가",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v32,
            Center(
              child: CircleAvatar(
                // onTap - 사진 변경 기능 추가할 것.
                radius: Sizes.size72,
                backgroundColor: Theme.of(context).primaryColor,
                child: const FaIcon(
                  FontAwesomeIcons.user,
                  color: Colors.amber,
                  size: Sizes.size72,
                ),
              ),
            ),
            Gaps.v20,
            const Padding(
              padding: EdgeInsets.only(
                left: Sizes.size8,
              ),
              child: Text(
                "이름",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InputField(
              textEditingController: _nameEditingController,
              onTapFunction: () {},
              hintText: "친구의 이름을 입력해주세요.",
            ),
            Gaps.v20,
            const Padding(
              padding: EdgeInsets.only(
                left: Sizes.size8,
              ),
              child: Text(
                "친구가 된 시기",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InputField(
              textEditingController: _momentEditingController,
              onTapFunction: () {},
              hintText: "친구와 첫 만남은?",
            ),
            Gaps.v20,
            SizedBox(
              height: Sizes.size96,
              child: CupertinoDatePicker(
                onDateTimeChanged: _setTextFieldDate,
                mode: CupertinoDatePickerMode.date,
                maximumDate: maximumDate,
                initialDateTime: initialDate,
              ),
            ),
            Gaps.v20,
            const Padding(
              padding: EdgeInsets.only(
                left: Sizes.size8,
              ),
              child: Text(
                "연락처",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InputField(
              textEditingController: _contactEditingController,
              onTapFunction: () {},
              hintText: "연락처(선택)",
            ),
            Gaps.v20,
            CupertinoButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.43,
                vertical: Sizes.size20,
              ),
              onPressed: () {
                _submit(context);
              },
              child: const Text("등록"),
            ),
          ],
        ),
      ),
    );
  }
}
