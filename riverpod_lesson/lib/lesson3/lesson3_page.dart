import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider.dart';

class Lesson3Page extends ConsumerWidget {
  const Lesson3Page({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    int counter = ref.watch(counterProvider);
    int doubled = ref.watch(doubleProvider);

    return Scaffold(
      body:Padding(
        padding:EdgeInsets.all(16),
         child:Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child:Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('カウント:$counter',style: TextStyle(fontSize: 32),),
                      SizedBox(height:8),
                      ElevatedButton(
                        onPressed: (){
                          ref.read(counterProvider.notifier).increment();
                        }, 
                        child: const Text('+1')
                      )
                    ],
                  ),
                ),
              ),
              Divider(height: 48,),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('2倍の値：$doubled',style: TextStyle(fontSize: 36),),
                ),
              )
            ],
           ),
         )
      )
    );
  }
}