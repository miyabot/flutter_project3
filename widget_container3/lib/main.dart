import 'package:flutter/material.dart';

void main() {

  //指定した色のコンテナを作成する関数
  Widget generateContainer(Color col){
    return Container(
      width: 100,
      height: 100,
      color: col,
    );
  }

  runApp(
    MaterialApp(
      home:Scaffold(
        body:Column(
          children: [
            //generateContainer(Colors.red),
            //generateContainer(Colors.blue),
            //generateContainer(Colors.yellow),
            //generateContainer(Colors.green),

            //for文でコンテナ5個表示
            //スプレッド演算子(...):childrenの中でfor文を使いたい場合に使用
            for(int i = 0;i < 5;i++)...{
              //$:変数の中身を表示
              //{}:変数の範囲を指定
              Text('コンテナ${i+1}',style: TextStyle(fontSize: 32),),
              Container(
                width: 100,
                height:100,
                color: Colors.red,
              )
            } 
          ],
        )
      )
    )
  );
}