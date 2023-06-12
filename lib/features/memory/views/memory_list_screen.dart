import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/memory/views/widgets/memory_card.dart';
import 'package:precious_people/features/relation/views/set_relation_timer_screen.dart';



import '../../../constants/sizes.dart';
import 'save_memory_screen.dart';

class MemoryListScreen extends ConsumerStatefulWidget {
  const MemoryListScreen({super.key});
  static String routeUrl = "/memorylistScreen";
  static String routeName = "memorylistScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MemoryListScreenState();
}

class _MemoryListScreenState extends ConsumerState<MemoryListScreen> {
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
          "소중한 추억들",
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
              childAspectRatio: 10 / 5,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                .onDrag, // 그리드를 드래그하면 키보드가 자동으로 사라진다.
            itemCount: 20,
            padding: const EdgeInsets.all(
              Sizes.size20,
            ),
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) => MemoryCard(
                index: index,
                name: "유진",
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
