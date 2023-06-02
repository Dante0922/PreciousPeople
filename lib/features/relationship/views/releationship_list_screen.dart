import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:precious_people/features/relationship/views/set_relation_timer_screen.dart';
import 'package:precious_people/features/relationship/views/widgets/relation_card.dart';

import '../../../constants/sizes.dart';
import '../../memory/views/save_memory_screen.dart';

class RelationshipListScreen extends ConsumerStatefulWidget {
  const RelationshipListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RelationshipListScreenState();
}

class _RelationshipListScreenState
    extends ConsumerState<RelationshipListScreen> {
  void _onLongPressCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SaveMemorySelectScreen(),
      ),
    );
  }

  void _setRerationTimer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetRelationTimer(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "소중한 사람들",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 10 / 3.3,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                .onDrag, // 그리드를 드래그하면 키보드가 자동으로 사라진다.
            itemCount: 20,
            padding: const EdgeInsets.all(
              Sizes.size20,
            ),
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) => RelationCard(
                index: index,
                name: "홍길동",
              ),
            ),
          ),
          // Positioned(
          //   right: Sizes.size40,
          //   bottom: Sizes.size32,
          //   child: FloatingActionButton(
          //     backgroundColor: Theme.of(context).primaryColor,
          //     onPressed: _setRerationTimer,
          //     child: const Icon(
          //       Icons.add,
          //       size: Sizes.size52,
          //       color: Colors.amber,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
