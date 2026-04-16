import 'package:flutter/material.dart'; //アプリ開発に必須

//エントリーポイント：一番最初に呼ばれる関数
void main(){
  //実行するアプリの指定
  runApp(
  //アプリの基盤を作成
    MaterialApp(
      //scaffold:アプリの下地を作成
      //home:最初に呼び出したい画面の指定
      home:Scaffold(
        //widget:アプリUIにおける部品
        body:Text(
          'Test',
          style: TextStyle(fontSize: 36)
        )
      )
    )
  );
}

