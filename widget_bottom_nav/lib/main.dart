import 'package:flutter/material.dart';
import 'package:widget_bottom_nav/account.dart';
import 'package:widget_bottom_nav/calendar.dart';
import 'package:widget_bottom_nav/home.dart';
import 'package:widget_bottom_nav/setting.dart';


void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:BottomNavSample()
    );
  }
}
class BottomNavSample extends StatefulWidget {
  const BottomNavSample({super.key});

  @override
  State<BottomNavSample> createState() => _BottomNavSampleState();
}

class _BottomNavSampleState extends State<BottomNavSample> {

  //選択中の番号を管理
  int _currentIndex = 0;

  //表示するページを管理
  final List<Widget> _page = [
    Home(),
    Calendar(),
    Account(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('BottomNavの基礎')
      ),
      body:_page[_currentIndex],
      //画面下部に表示するバー
      bottomNavigationBar: BottomNavigationBar(

        //現在選択されているアイコンのインデックス番号
        currentIndex: _currentIndex,

        //押された時に呼ばれる
        //selectIndex:選択されたアイコンのインデックス番号
        onTap: (int selectIndex){
          setState(() {
            _currentIndex = selectIndex;  
          });
        },

        //４つ以上並べる場合(デフォルト３つまで)
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month),label:'calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label:'account'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label:'setting'),
        ]
      ),
    );
  }
}
