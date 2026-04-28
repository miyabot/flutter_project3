import 'package:flutter/material.dart';
import 'package:todo_app/addpage.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:AddPage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //ToDoリストの内容を管理
  List<String> _list = []; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム画面'),
        shape: Border(bottom: BorderSide(width:1.0)),
      ),
      //スクロール対応(可変式)
      body:ListView.builder(
        itemCount: _list.length, //要素数
        //要素ごとの処理
        itemBuilder:(context,index){
          return ListTile(
            title: Text(_list[index]),
          );
        } 
      )
    );
  }
}

