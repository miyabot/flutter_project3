import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo{
  //コンストラクタ（初期値）の設定
  const Todo({required this.id,required this.title,this.done = false});

  final int id;
  final String title;
  final bool done; 
}

class TodoList extends Notifier<List<Todo>> {

  //Todoに割り当てるID
  int _nextId = 0;

  @override
   build() {
    return [];
  }

  //追加
  void add(String title){
    //クラスのインスタンス化
    final todo = Todo(id:_nextId++,title:title);
    state = [...state,todo];
  }

  //チェックボックスの切り替え
  void toggle(int id){
    state = [
      for(final todo in state)
        //idが一致していたら反転処理
        if(todo.id == id) Todo(id: todo.id, title: todo.title,done:!todo.done)
        else todo
    ];
  }

  //削除
  void remove(int id){
    //条件に一致する情報だけ残す
    state = state.where((todo)=>todo.id != id).toList();
  }
}

//TodoListクラスを見に行くためのProvider
final todoListProvider = NotifierProvider<TodoList,List<Todo>>(TodoList.new);