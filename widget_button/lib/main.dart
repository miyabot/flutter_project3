import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

//基盤を作成するクラス
class Base extends StatelessWidget {
  const Base({super.key});

  //buildの中に処理を書く
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:ButtonSumple()
    );
  }
}

//中身(Scaffold以降)を作成するクラス
class ButtonSumple extends StatelessWidget {
  const ButtonSumple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          //TextButton：文字のみ
          TextButton(
            onPressed: (){}, 
            child: Text('TextButton')
          ),
          //OutlinedButton:枠付き
          OutlinedButton(
            onPressed: (){}, 
            child: Text('OutlinedButton')
          ),
          //ElevatedButton：影付き
          ElevatedButton(
            //押した時に呼ばれる
            onPressed: (){ 
              debugPrint('ボタンが押されました！');
            }, 
            child: Text('ボタン') //ボタン内で表示するwidgetを指定
          ),
        ],
      )
    );
  }
}

