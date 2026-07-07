import 'package:flutter/material.dart';
import 'package:riverpod_lesson/lesson1/lesson1_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lesson/lesson2/lesson2_page.dart';
import 'package:riverpod_lesson/lesson3/lesson3_page.dart';
import 'package:riverpod_lesson/lesson4/lesson4_page.dart';

void main() {
  //ProviderScope：Riverpodを使えるようにする前準備
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
               colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Lesson4Page()
    );
  }
}