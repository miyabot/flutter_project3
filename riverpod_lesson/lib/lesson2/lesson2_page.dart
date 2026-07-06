import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Notifier<stateの型>
class Counter extends Notifier<int>{

  //build()の戻り値が初期値となる
  @override
  int build() => 0;

  //インクリメント
  void increment(){
    state++;
  }

  //デクリメント
  void decrement(){
    state--;
  }

  //リセット
  void reset(){
    state = 0;
  }

}

//counterProviderを通じて、アプリのどこからでもCounterにアクセスできる。
final counterProvider = NotifierProvider<Counter,int>(Counter.new);

class Lesson2Page extends ConsumerWidget {
  const Lesson2Page({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    //ref.watchで値を読み、値が変わるとここが自動的に再ビルドされる
    int counter = ref.watch(counterProvider);

    return Scaffold(
      body:Center(
        child: Text('$counter',style:TextStyle(fontSize: 64)),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              //read：一度だけ読み取る
              //notifier:関数を呼び出すときに記述
              ref.read(counterProvider.notifier).increment();
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height:16),
          FloatingActionButton(
            onPressed: (){
              //read：一度だけ読み取る
              //notifier:関数を呼び出すときに記述
              ref.read(counterProvider.notifier).reset();
            },
            child: Icon(Icons.settings_backup_restore_outlined),
          ),
          SizedBox(height:16),
          FloatingActionButton(
            onPressed: (){
              //read：一度だけ読み取る
              //notifier:関数を呼び出すときに記述
              ref.read(counterProvider.notifier).decrement();
            },
            child: Icon(Icons.minimize_outlined),
          ),
        ],
      ),
    );
  }
}