import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoリスト'),
        actions: [
          IconButton(
            onPressed:(){} , 
            icon:Icon(Icons.delete_sweep) 
            )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              //利用可能なスペース分広がる
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'やることを入力',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(
                height: 56,
                child: FilledButton(
                  onPressed: (){}, 
                  child: Text('追加')
                ),
              )
            ],
          ),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0,label: Text('すべて')),
              ButtonSegment(value: 1,label: Text('未完了')),
              ButtonSegment(value: 2,label: Text('完了')),
            ], 
            selected: {0}
          ),
          
        ],
      ),
    );
  }
}