import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo{
  //コンストラクタ（初期値）の設定
  const Todo({required this.id,required this.title,this.done = false});

  final int id;
  final String title;
  final bool done; 
}

class TodoList extends Notifier<List<Todo>> {
  @override
   build() {
    return [];
  }

  //追加
  void add(String title){
    //クラスのインスタンス化
    final todo = Todo(id:0,title:title);
    state = [...state,todo];
  }
}

//TodoListクラスを見に行くためのProvider
final todoListProvider = NotifierProvider<TodoList,List<Todo>>(TodoList.new);