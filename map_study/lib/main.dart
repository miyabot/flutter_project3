import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {

  //Mapとクラスの使い分け
  //クラス：何が入るか分かっている大事なデータ
  //Map：とりあえず詰め込みたい一時的なデータ

  List<String> userList = ['田中','佐藤','鈴木'];

  //Map：キーと値のペアで管理
  Map<String,String> userMap = {
    '田中':'オンライン',
    '佐藤':'離席中',
    '鈴木':'オンライン',
  };

  //リストに値を追加する関数
  void addList(String name){
    setState(() {
      userList.add(name);  
    });
  }

  //マップに値を追加する関数
  void addMap(Map<String,String> newData){
    setState(() {
      //'高橋'というキーに'オンライン'という値を追加
      //既にキーが存在する場合は値の更新
      //userMap['高橋'] = 'オンライン';
      userMap.addAll(newData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Text('---Listの表示方法---',style: TextStyle(fontSize: 32),),
          //スプレッド演算子(...)：Listを分解
          ...userList.map((name)=>Text(name,style: TextStyle(fontSize: 32),)),

          //mapはkeyを指定して値(value)を取得
          Text('---Mapの表示方法---',style: TextStyle(fontSize: 32),),
          ...userMap.entries.map((name)=>Text(name.value,style: TextStyle(fontSize: 32),))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //addList('高橋');
          addMap({'高橋':'オンライン'});
          debugPrint('Mapの中身：$userMap');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}