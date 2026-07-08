import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lesson/lesson4/provider.dart';


//ConsumerWidget：自分のフィールドを用意しない
//ConsumerStatefulWidget：自分のフィールドを用意する
class Lesson4Page extends ConsumerStatefulWidget {
  const Lesson4Page({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Lesson4PageState();
}

class _Lesson4PageState extends ConsumerState<Lesson4Page> {
  final  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = ref.watch(todoListProvider);

    return Scaffold(
      body:Column(
        children: [
          Padding(
            padding:EdgeInsets.all(16),
            child: Row(
              children: [
                //余った分だけ使う
                Expanded(
                  child:TextField(
                    controller: _controller,
                  ), 
                ),
                ElevatedButton(
                  onPressed: (){
                    ref.read(todoListProvider.notifier).add(_controller.text);
                    debugPrint('$todos');
                    _controller.clear();
                  }, 
                  child: Text('追加')
                )
              ]
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context,index){
                return CheckboxListTile(
                  value: todos[index].done,  //チェックの有無
                  onChanged: (_){
                    //切り替え
                    ref.read(todoListProvider.notifier).toggle(todos[index].id);
                  },
                  title: Text(todos[index].title,style: TextStyle(fontSize: 36),),
                  secondary: IconButton(
                    onPressed: (){
                      ref.read(todoListProvider.notifier).remove(todos[index].id);
                    }, 
                    icon: Icon(Icons.delete)
                  ),
                );
              }
            )
          )
        ],
      )
    );
  }
}