import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/providers/nav_provider.dart';
import 'package:speedclimbing/views/history_view.dart';
import 'package:speedclimbing/views/timer_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int pageIndex = ref.watch(pageIndexProvider);
    final PageController controller = PageController(initialPage: pageIndex);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Speed Climbing Timer'),
        ),
        body: PageView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (value) {
            ref.read(pageIndexProvider.notifier).state = value;
          },
          children: const [
            TimerView(),
            HistoryView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (index) {
            ref.read(pageIndexProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.show_chart), label: 'History'),
          ],
        ));
  }
}
