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
      home:HomePage()
    );
  }
}

//ListTileに表示する要素をまとめたクラス
class ToDoItem{
  //コンストラクタの設定
  ToDoItem({required this.title,required this.subTitle});

  String title;
  String subTitle;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //ToDoリストの内容を管理
  List<ToDoItem> _list = []; 

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
            title: Text(_list[index].title),
            subtitle: Text(_list[index].subTitle),
            trailing: IconButton(
              onPressed: (){
                setState(() {
                  _list.removeAt(index);
                });
              }, 
              icon:Icon(Icons.delete)
            ),
          );
        } 
      ),
      //追加ボタン
      floatingActionButton: FloatingActionButton(
        //async,await :非同期処理
        onPressed: ()async{
          //受け取り用
          ToDoItem result;

          //await:結果が返ってくるまで待つ
          result = await Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=>AddPage())  
          );

          //_listに追加
          setState(() {
            _list.add(result);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

