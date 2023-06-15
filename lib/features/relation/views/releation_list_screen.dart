import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/relation/view_models/relation_view_model.dart';
import 'package:precious_people/features/relation/views/widgets/relation_card.dart';
import '../../../constants/sizes.dart';
import '../../memory/views/save_memory_screen.dart';

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
                        name: relation.name,
                        relation: relation,
                      );
                    }),
                  ),
                ],
              );
            }));
  }
}
