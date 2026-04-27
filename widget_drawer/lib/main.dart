import 'package:flutter/material.dart';
import 'package:widget_drawer/tile1.dart';
import 'package:widget_drawer/tile2.dart';
import 'package:widget_drawer/tile3.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:DrawerSample()
    );
  }
}

class DrawerSample extends StatefulWidget {
  const DrawerSample({super.key});

  @override
  State<DrawerSample> createState() => _DrawerSampleState();
}

class _DrawerSampleState extends State<DrawerSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Drawerの作成にはAppBarが必要
      appBar: AppBar(),
      //drawer:サイドメニュー
      drawer: Drawer(
        child: Column(
          children: [
            //ヘッダーの作成
            DrawerHeader(
              child:Center(
                child: Text('Header部分'),
              ) 
            ),
            //ListTile:リスト表示の際に使いやすい
            ListTile(
              title: Text('リストタイル１'),
              //押された時に呼ばれる
              onTap:(){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>const Tile1())
                );
              }
            ),
            ListTile(
              title: Text('リストタイル２'),
              onTap:(){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>const Tile2())
                );
              }
            ),
            ListTile(
              title: Text('リストタイル３'),
              onTap:(){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>const Tile3())
                );
              }
            ),
          ],
        )
      ),
    );
  }
}