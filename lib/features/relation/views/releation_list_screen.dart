import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/relation/view_models/relation_view_model.dart';
import 'package:precious_people/features/relation/views/widgets/relation_card.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../memory/views/save_memory_screen.dart';
import '../models/relation_model.dart';

class RelationListScreen extends ConsumerStatefulWidget {
  const RelationListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RelationListScreenState();
}

class _RelationListScreenState extends ConsumerState<RelationListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _onLongPressCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SaveMemorySelectScreen(),
      ),
    );
  }

  void _saveMemory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SaveMemorySelectScreen(),
      ),
    );
  }

  void _setSnooze(BuildContext context, RelationModel relation) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: const Text(
          "Snooze!",
        ),
      ),
    );
    ref
        .read(relationViewModel.notifier)
        .snoozeRelation(context, relation.friendId, relation);
  }

  void _setDone(BuildContext context, RelationModel relation) async {
    await ref
        .read(relationViewModel.notifier)
        .completeAndResetRelation(context, relation.friendId, relation);
    popSnackBar();
  }

  void popSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        showCloseIcon: false,
        duration: const Duration(seconds: 3),
        content: Stack(
          children: [
            const Row(
              children: [
                Gaps.h16,
                Text("타이머 완료!"),
              ],
            ),
            Positioned(
              right: Sizes.size16,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  _saveMemory();
                }, // 스터디 때 질문할 것..
                child: Container(
                  width: 80,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "추억 등록",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "소중한 사람들",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ref.watch(relationViewModel).when(
            error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            data: (relations) {
              if (relations.isEmpty) {
                return const Center(
                  child: Text("소중한 관계를 등록하세요."),
                );
              }
              return Stack(
                children: [
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 10 / 3.3,
                    ),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    // 그리드를 드래그하면 키보드가 자동으로 사라진다.
                    itemCount: relations.length,
                    padding: const EdgeInsets.all(
                      Sizes.size20,
                    ),
                    itemBuilder: (context, index) =>
                        LayoutBuilder(builder: (context, constraints) {
                      final relation = relations[index];
                      return RelationCard(
                        index: index,
                        relation: relation,
                        setSnoozeFunction: () => _setSnooze(context, relation),
                        setDoneFunction: () => _setDone(context, relation),
                      );
                    }),
                  ),
                ],
              );
            }));
  }
}
