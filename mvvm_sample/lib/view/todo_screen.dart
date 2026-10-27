import 'package:flutter/material.dart';
import 'package:mvvm_sample/view_model/todo_view_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  //TodoViewModelのインスタンス化
  final viewModel = TodoViewModel();

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //監視を行ってくれるWidget
    return ListenableBuilder(
      listenable: viewModel, //監視対象
      builder: (context,child){
        //絞り込みに応じたリスト情報を渡す
        final VisibleTodos = viewModel.todos;

        return Scaffold(
          appBar: AppBar(
            title: const Text('ToDoリスト'),
            actions: [
              IconButton(
                onPressed:(){
                  //削除
                  viewModel.deleteCompleted();
                } , 
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
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'やることを入力',
                        border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    child: FilledButton(
                      onPressed: (){
                        viewModel.addTodo(_controller.text);
                      }, 
                      child: Text('追加')
                    ),
                  )
                ],
              ),
              SegmentedButton<TodoFilter>(
                segments: [
                  ButtonSegment(value: TodoFilter.all,label: Text('すべて')),
                  ButtonSegment(value: TodoFilter.active,label: Text('未完了')),
                  ButtonSegment(value: TodoFilter.completed,label: Text('完了')),
                ], 
                //今どれが選ばれているか(valueと関係あり)
                selected: {viewModel.filter},
                //ボタンが押されたら呼ばれる
                onSelectionChanged: (selected){
                  viewModel.changeFilter(selected.first);
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: VisibleTodos.length,
                  itemBuilder: (context,index){
        
                    //todo一件のデータを取ってくる
                    final todo = VisibleTodos[index];
        
                    //Dismissble:横にスワイプすると消せる
                    return Dismissible(
                      //どの行かを見分けるための目印
                      key: ValueKey<int>(0), 
                      //スワイプ方向の制限（右から左のスワイプ）
                      direction: DismissDirection.endToStart,
                      //スワイプ時の背景
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight, //子要素の位置指定
                        padding: const EdgeInsets.only(right: 20), //内側に余白作成
                        child: const Icon(Icons.delete,color: Colors.white,),
                      ),
        
                      child: CheckboxListTile(
                        //チェックボックスを左側に配置
                        controlAffinity: ListTileControlAffinity.leading,
                        //チェックの有無
                        value: todo.isDone, 
                        //チェックの状態が切り替わったら呼ばれる
                        onChanged: (value){
                          viewModel.toggleDone(todo);
                        },
                        title:Text(
                          todo.title,
                          style: TextStyle(
                            //三項演算子（条件式 ? 真 : 偽）
                            decoration: todo.isDone ? TextDecoration.lineThrough : null,
                            color: todo.isDone ? Colors.grey : null
                          ),
                        )
                      )
                    );
                  }
                )
              )
            ],
          ),
        );
      },
      
    );
  }
}