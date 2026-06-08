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
            onPressed: (){},
            heroTag: 'btn2', //識別名
            child:const Text('くじを引く'),
          ),
        ],
      ),
    );
  }
}