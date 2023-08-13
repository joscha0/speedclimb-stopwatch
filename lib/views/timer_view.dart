import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerView extends ConsumerWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text('Timer'));
  }
}
