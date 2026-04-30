import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  //TextField用のコントローラーを作成
  final TextEditingController _controller = TextEditingController();

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
                  controller: _controller, //コントローラーの設定
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
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
                      //値を持って帰る
                      Navigator.pop(context,_controller.text);
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