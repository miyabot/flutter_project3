//ChangeNotifierを使うためのimport文
import 'package:flutter/foundation.dart';
import 'package:mvvm_sample/model/todo_model.dart';

enum TodoFilter {
  all,      //全て
  active,   //未完了
  completed //完了
}

//変化を知らせる機能が搭載！
class TodoViewModel extends ChangeNotifier {
  final List<Todo> _todos=[
    Todo(title:'確認用１',isDone:true),
    Todo(title:'確認用２'),
  ];

  TodoFilter _filter = TodoFilter.all;
  
  //情報の取得専用
  List<Todo> get todos{

    if(_filter == TodoFilter.active){
      //完了していないものだけreturnする
      return _todos.where((todo)=>!todo.isDone).toList();
    }
    else if(_filter == TodoFilter.completed){
      //完了しているものだけreturnする
      return _todos.where((todo)=>todo.isDone).toList();
    }

    //本体の_todosをそのまま渡すとViewから書き換えることが可能になってしまうので
    //toListでコピーを作って渡す。
    return _todos.toList();
  } 

  //選択している絞り込みの情報を取得
  TodoFilter get filter => _filter;

  void addTodo(String text){
    //前後の空白を取り除く
    final title = text.trim();

    //入力内容が空かどうかチェック
    if(title.isEmpty){
      return;
    }

    //追加
    _todos.add(Todo(title: title));

    //変化を通知
    notifyListeners();
  }

  //完了・未完了の切り替え処理
  void toggleDone(Todo todo){
    //反転処理
    todo.isDone = !todo.isDone;

    //変化を通知
    notifyListeners();
  }

  //チェックの入っているものをまとめて削除する
  void deleteCompleted(){
    //removeWhere:条件に合うものを全て消す
    _todos.removeWhere((todo)=>todo.isDone);

    notifyListeners();
  }

  //絞り込みを変更する
  void changeFilter(TodoFilter filter){
    _filter = filter;
    notifyListeners();
  }
  
}