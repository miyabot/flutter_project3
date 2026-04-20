import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

//勇者クラス(継承なし)：データのまとまり
class Hero{
  int hp;
  int mp;
  String name; 

  //コンストラクタ(初期化関数)
  //required:設定必須の引数
  Hero({
    required this.hp,
    required this.mp,
    required this.name,
  });
}

//基盤を作成するクラス
//Stateless(状態なし):画面にwidgetを配置する際に必要
class Base extends StatelessWidget {
  const Base({super.key});

  //build():処理を書くところ
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Home()
    );
  }
}

//中身(scaffold以降)を作成するクラス
class Home extends StatelessWidget {
  Hero hero = Hero(hp: 100, mp: 50, name: 'Akihara'); 
  Home({super.key});

  //処理を書くところ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Text('勇者の名前：${hero.name}'),
          Text('勇者のhp：${hero.hp}'),
          Text('勇者のmp：${hero.mp}'),
        ],
      )
    );
  }
}
