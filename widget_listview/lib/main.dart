import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListViewSumple(),
    );
  }
}
class ListViewSumple extends StatelessWidget {
  const ListViewSumple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Column:縦に並べる(スクロール不可)
      //ListView:縦に並べる(スクロール可能)
      body:ListView(
        children: [
          Container(
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          ),    
          Container(
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          ),   
          Container(
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          ),   
          Container(
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          ),   
          Container(
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          ),   
          Container(
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          ),   
          Container(
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          ),   
        ],
      )
    );
  }
}