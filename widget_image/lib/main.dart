import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:ImageSumple()
    );
  }
}

class ImageSumple extends StatelessWidget {
  const ImageSumple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Center:中央に寄せる
      body:Center(
        //Image:画像の表示
        //asset:ローカルに保存している画像を表示
        // child:Image.asset(
        //   'images/dog_akitainu.png',
        //   fit:BoxFit.fill //サイズ調整
        // )

        //network:ネットワーク上の画像を表示
        child: Image.network('https://www.kobedenshi.ac.jp/assets/img/info/campus/img_campus06.webp'),
      )
    );
  }
}