import 'package:flutter/material.dart';
void main() {
  runApp(
    MaterialApp(
      home:Scaffold(
        //Column:縦に複数のwidgetを並べる
        //Row:横に複数のwidgetを並べる
        // body:Column(
        //   children: [
        //     Text('１つめ',style: TextStyle(fontSize: 36),),
        //     Text('２つめ',style: TextStyle(fontSize: 36),),
        //     Text('３つめ',style: TextStyle(fontSize: 36),),
        //     Row(
        //       children: [
        //         Text('４つめ',style: TextStyle(fontSize: 36),),
        //         Text('５つめ',style: TextStyle(fontSize: 36),),
        //       ],
        //     )
        //   ],
        // )
        body:Column(
          children: [
            Row(
              children: [
                Container(
                  width: 150.0,
                  height:150.0,
                  color: Colors.red,
                ),
                Container(
                  width: 150.0,
                  height:150.0,
                  color: Colors.green,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 150.0,
                  height:150.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 150.0,
                  height:150.0,
                  color: Colors.yellow,
                ),
              ],
            ),
          ],
        )
      )
    )
  );
}

