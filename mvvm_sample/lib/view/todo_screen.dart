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
              SegmentedButton(
                segments: [
                  ButtonSegment(value: 0,label: Text('すべて')),
                  ButtonSegment(value: 1,label: Text('未完了')),
                  ButtonSegment(value: 2,label: Text('完了')),
                ], 
                selected: {0}
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.todos.length,
                  itemBuilder: (context,index){
        
                    //todo一件のデータを取ってくる
                    final todo = viewModel.todos[index];
        
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
                        value: false, 
                        //チェックの状態が切り替わったら呼ばれる
                        onChanged: (value){
        
                        },
                        title:Text(todo.title)
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