import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:DialogSample2()
    );
  }
}

class DialogSample2 extends StatefulWidget {
  const DialogSample2({super.key});

  @override
  State<DialogSample2> createState() => _DialogSample2State();
}

class _DialogSample2State extends State<DialogSample2> {

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: ElevatedButton(
          onPressed: (){
            //ダイアログの表示
            showDialog(
              context: context, 
              //StatefulBuilder:特定のwidgetのみを再構築することができる
              builder: (context)=>StatefulBuilder(
                //newSetState:StatefulBuilder内で使用するsetStateの名前
                builder: (context,newSetState)=>AlertDialog(
                  title: const Text('リアルタイム更新'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('ダイアログの中でsetState'),
                      Text('$_counter',style: TextStyle(fontSize: 32),),
                    ],
                  ),
                  actions: [
                    Center(
                      child: IconButton(
                        onPressed: (){
                          //新しく作成したsetStateを使用
                          newSetState(() {
                            _counter++;
                          });
                        }, 
                        icon: Icon(Icons.add)
                      ),
                    )
                  ],
                )
              )
            );
          }, 
          child:const Text('ダイアログ開く')
        ),
      )
    );
  }
}