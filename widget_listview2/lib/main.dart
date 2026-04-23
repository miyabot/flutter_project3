import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:ListViewSample()
    );
  }
}

class ListViewSample extends StatefulWidget {
  ListViewSample({super.key});

  @override
  State<ListViewSample> createState() => _ListViewSampleState();
}

class _ListViewSampleState extends State<ListViewSample> {
  List<String> list = ['りんご','バナナ','ぶどう','いちご','みかん'];

    //リストに果物を追加する関数
    void addList(String fruit){
      list.add(fruit);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar:画面上部に表示
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
      ),
      //builder:可変式リスト(実行中に要素数を変更できる)
      body:ListView.builder(
        itemCount:list.length, //要素数
        //要素ごとの処理
        //index:widget毎の要素番号
        itemBuilder: (context,index){
          return Text(list[index]);
        }
      ),
      //画面の右下に表示されるボタン
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //画面更新
          setState(() {
            //リストに追加
            addList('メロン');
          });
          //リストの中身を確認
          debugPrint('List:$list');
        }
      ),
    );
  }
}