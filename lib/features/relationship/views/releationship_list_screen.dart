import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/memory/views/save_memory_screen.dart';
import 'package:precious_people/features/relationship/views/widgets/relation_card.dart';

import '../../../constants/sizes.dart';

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
          builder: (context) => const SaveMemoryScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("소중한 관계"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 10 / 4,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
            .onDrag, // 그리드를 드래그하면 키보드가 자동으로 사라진다.
        itemCount: 20,
        padding: const EdgeInsets.all(
          Sizes.size20,
        ),
        itemBuilder: (context, index) => LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
              onLongPress: _onLongPressCard, child: const RelationCard()),
        ),
      ),
    );
  }
}
