import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:MarginSample()
    );
  }
}

class MarginSample extends StatelessWidget {
  const MarginSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('PaddingとMarginの違い')
      ),
      body:Center(
        child:Container(
          width: 300.0,
          height:300.0,
          color: Colors.blue,
          //padding:コンテナの内側に32px分の余白を作成
          padding: EdgeInsets.all(32.0),
          child: Container(
            //margin:コンテナの外側に32px分の余白を作成
            //margin: EdgeInsets.all(32.0),
            //margin: EdgeInsets.fromLTRB(32.0, 16.0, 96.0, 0),
            width: 150.0,
            height:150.0,
            color: Colors.white,
          ),
        )
      )
    );
  }
}