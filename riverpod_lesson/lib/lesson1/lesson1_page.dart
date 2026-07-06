import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//returnで返す値＝refが持っている値
final messageProvider = Provider<String>((ref) {
  return 'はじめてのRiverpod';
});

//Provider<返す値の型>
final lessonNumberProvider = Provider<int>((ref){
  return 1;
});

class Lesson1Page extends ConsumerWidget {
  const Lesson1Page({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    //watch：監視し続ける
    String message = ref.watch(messageProvider);
    int lessonNumber = ref.watch(lessonNumberProvider);

    return Scaffold(
      body:Center(
        child: Column(
          children: [
            Text(message),
            Text('Lesson$lessonNumber')
          ],
        ),
      )
    );
  }
}