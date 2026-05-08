import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:FlexSample()
    );
  }
}

class FlexSample extends StatelessWidget {
  const FlexSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
       child: Column(
        children: [
          //１．固定サイズのコンテナ
          Container(
            height: 100,
            color: Colors.blue,
          ),

          //Flexble:子widgetが利用可能なスペースを埋めるように拡大する
          //２．残りスペースを「３」の割合で占める
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.greenAccent,
            )
          ),
          //３．残りスペースを「２」の割合で占める
          Flexible(
            flex: 2,
            //stack:重ねて表示
            child: Stack(
              children: [
                Container(color: Colors.orangeAccent,),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('背景の上に重ねる'),
                ),
                Positioned(
                  bottom:20,
                  right:20,
                  child: Icon(Icons.star,color: Colors.white,size:50)
                )
              ],
            )
          ),
        ],
       ), 
      )
    );
  }
}