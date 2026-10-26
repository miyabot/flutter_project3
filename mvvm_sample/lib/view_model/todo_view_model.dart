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

  //情報の取得専用
  List<Todo> get todos{

    //本体の_todosをそのまま渡すとViewから書き換えることが可能になってしまうので
    //toListでコピーを作って渡す。
    return _todos.toList();
  } 

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
}