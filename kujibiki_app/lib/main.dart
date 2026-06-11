import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KujiApp(),
    );
  }
}

//くじの「中身」を表すデータクラス
class Kuji{
  String name;
  int value;
  Kuji({required this.name,required this.value});
}

//くじの「束」を表すデータクラス
class KujiBako{
  String title;
  List<Kuji> items;
  KujiBako({required this.title,required this.items});
}

class KujiApp extends StatefulWidget {
  const KujiApp({super.key});

  @override
  State<KujiApp> createState() => _KujiAppState();
}

class _KujiAppState extends State<KujiApp> {

  final TextEditingController _con = TextEditingController();

  //作成したくじ箱を保存するリスト
  List<KujiBako> kujiBako = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          //spaceBetween:均等配置
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('くじ引き'),
            IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
          ],
        ),
      ),
      body:ListView.builder(
        itemCount: kujiBako.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            //GestureDetector：子要素をタップできるようにする
            child: GestureDetector(
              onTap: (){
                //くじの詳細ページに移動
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>KujiDetail(kujibako: kujiBako[index],))
                );
              },
              child: Container(
                height:80.0,    
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.grey
                  )
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.help_center,
                      size: 50.0,
                      color: const Color.fromARGB(255, 21, 63, 190),
                    ),
                    Text(kujiBako[index].title,style: TextStyle(fontSize: 20),)
                  ],
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButton: SizedBox(
        width: 90.0,
        height:45.0,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 21, 63, 190),
          foregroundColor: Colors.white,
          onPressed:(){
            //ダイアログの表示
            showDialog(
              context: context, 
              builder: (context){
                //ダイアログの見た目
                return AlertDialog(
                  title:Text('くじ引き作成'),
                  content: TextField(
                    controller: _con,
                    decoration: InputDecoration(
                      labelText: 'くじ引きタイトル',
                      border: OutlineInputBorder()
                    ),
                  ),
                  actions: [
                    TextButton(onPressed: (){}, child: Text('キャンセル')),
                    ElevatedButton(
                      onPressed: (){
                        //KujiBakoオブジェクトをリストに追加
                        setState(() {
                          kujiBako.add(KujiBako(title:_con.text, items: []));  
                        });
                        Navigator.pop(context);
                      }, 
                      child: Text('作成')
                    ),

                  ],
                );
              }
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.help_center),
              SizedBox(width: 6),
              Text('作成'),
            ],
          ),
        ),
      ),
    );
  }
}

class KujiDetail extends StatefulWidget {
  const KujiDetail({super.key,required this.kujibako});
  final KujiBako kujibako;

  @override
  State<KujiDetail> createState() => _KujiDetailState();
}

class _KujiDetailState extends State<KujiDetail> {

  final TextEditingController _nameCon = TextEditingController();
  final TextEditingController _valueCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          //spaceBetween:均等配置
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.kujibako.title),
            IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
          ],
        ),
      ),
      body:ListView.builder(
        itemCount: widget.kujibako.items.length,
        itemBuilder: (context,index){
          final kuji = widget.kujibako.items[index];
          return Padding(
            padding:const EdgeInsets.all(8) ,
            child:Container(
              height:80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 221, 221, 221)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(kuji.name),
                    const Spacer(), //余白を全て埋める
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 21, 63, 190),
                      ),
                      child: Center(
                        child: Text('${kuji.value}',style: TextStyle(color: Colors.white))
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        }
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    title:const Text('くじ追加'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameCon,
                          decoration: const InputDecoration(
                            labelText: 'くじの内容',
                            border: OutlineInputBorder()
                          ),
                        ),
                        SizedBox(height: 16,),
                        TextField(
                          maxLength: 3, //入力文字数の制限
                          keyboardType: TextInputType.number,//キーボードの種類
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],//入力内容の制限
                          controller: _valueCon,
                          decoration: const InputDecoration(
                            labelText: 'くじの枚数(0～999)',
                            border: OutlineInputBorder()
                          ),
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text('キャンセル')
                      ),
                      ElevatedButton(
                        onPressed: (){
                          setState(() {
                            widget.kujibako.items.add(
                              Kuji(name: _nameCon.text, value:int.parse(_valueCon.text))
                            );
                          });
                          Navigator.pop(context);
                        }, 
                        child: Text('追加')
                      ),
                    ],
                  );
                }
              );
            },
            heroTag: 'btn1', //識別名
            child:const Text('追加'),
          ),
          SizedBox(height: 24,),
          FloatingActionButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KujiPlay(kujibako: widget.kujibako)
                )
              );
            },
            heroTag: 'btn2', //識別名
            child:const Text('くじを引く'),
          ),
        ],
      ),
    );
  }
}

class KujiPlay extends StatefulWidget {
  const KujiPlay({super.key,required this.kujibako});
  final KujiBako kujibako;

  @override
  State<KujiPlay> createState() => _KujiPlayState();
}

class _KujiPlayState extends State<KujiPlay> {
  //残り枚数格納用
  int stock = 0;

  //大元のデータを壊さないためのコピー
  List<Kuji> copy = [];

  //くじの結果格納用
  String result = '';

  //初期化関数
  @override
  void initState() {
    super.initState();

    //残り枚数の算出
    for(int i = 0;i < widget.kujibako.items.length;i++){
      copy.add(Kuji(
        name: widget.kujibako.items[i].name, 
        value: widget.kujibako.items[i].value
      ));
      stock += widget.kujibako.items[i].value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 92, 191),
      appBar: AppBar(
        //戻るボタンの設定
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        title: Text(widget.kujibako.title,style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 34, 92, 191),
      ),
      body:Center(
        child: Column(
          children: [
            Text('残り$stock枚',style: TextStyle(color: Colors.white,fontSize: 20)),
            const SizedBox(height: 150,),
            Text(result,style: TextStyle(color: Colors.white,fontSize: 40)),
            const SizedBox(height: 200,),
            GestureDetector(
              onTap: (){
                //残り枚数が０枚なら終了
                if(stock <= 0){
                  setState(() {
                    result = '中身がありません';
                  });
                  return;
                }

                //0 ~ (stock - 1)の乱数を生成
                int rnd = Random().nextInt(stock);

                //各くじの担当範囲の開始位置
                int border = 0;
                //くじを順番に並べる
                for(int i = 0;i < copy.length;i++){
                  if(rnd >= border && rnd < border + copy[i].value){
                    setState(() {
                      result = copy[i].name;
                      copy[i].value--;
                      stock--;
                    });
                    //当選したくじが決まったのでループ終了
                    break;
                  }
                  //次のくじの担当範囲へ移動
                  border += copy[i].value;
                }
              },  
              child: Icon(Icons.help_center,color: Colors.white,size:150), 
            ),
            const SizedBox(height: 50,),
            Text('箱をタップする',style: TextStyle(color: Colors.white,fontSize: 20)),
          ],
        ),
      )
      
    );
  }
}