import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:ListViewSumple()
    );
  }
}

class ListViewSumple extends StatelessWidget {
  ListViewSumple({super.key});

  List<String> list = ['りんご','バナナ','ぶどう','いちご','みかん'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //builder:可変式リスト(実行中に要素数を変更できる)
      body:ListView.builder(
        itemCount:list.length, //要素数
        //要素ごとの処理
        //index:widget毎の要素番号
        itemBuilder: (context,index){
          return Text(list[index]);
        }
      )
    );
  }
}