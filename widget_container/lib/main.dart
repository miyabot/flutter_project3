import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home:Scaffold(
        //Container:見た目を変えることができる箱
        body:Container(
          color: Colors.green, //色
          width: 200.0, //横幅
          height: 200.0,//縦幅
          //child:子要素の指定
          child:Text('Containerの中')
        ),
      )
    )
  );
}