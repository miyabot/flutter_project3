import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  //TextField用のコントローラーを作成
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //戻るボタンを非表示
        automaticallyImplyLeading: false,
        title: Text('追加画面'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
              SizedBox(
                width: 300.0,
                child: TextField(
                  controller: _titleController, //コントローラーの設定
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'タイトルを入力'
                  ),
                ),
              ),
              SizedBox(height: 16,),
              SizedBox(
                width: 300.0,
                child: TextField(
                  controller: _subTitleController, //コントローラーの設定
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'サブタイトルを入力'
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: Text('キャンセル')
                  ),
                  SizedBox(width: 48,),
                  ElevatedButton(
                    onPressed: (){
                      //TextFeildが空じゃなかったら
                      if(_titleController.text.isNotEmpty &&_subTitleController.text.isNotEmpty){
                        ToDoItem newItem = ToDoItem(
                          title: _titleController.text, 
                          subTitle: _subTitleController.text
                        );

                        //値を持って帰る(１つまで)
                        Navigator.pop(context,newItem);
                      }
                      else{
                        //スナックバーの表示
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('タイトルとサブタイトルを入力してください'),
                            backgroundColor: Colors.black, //背景色
                            duration: Duration(seconds: 2),//2秒間表示
                          )
                        );
                      }
                    }, 
                    child: Text('追加')
                  ),
                ],
              )
          ],

        ),
      )
    );
  }
}