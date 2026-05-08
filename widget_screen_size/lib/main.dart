import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:SizeSample()
    );
  }
}

class SizeSample extends StatelessWidget {
  const SizeSample({super.key});



  @override
  Widget build(BuildContext context) {

    //スクリーンサイズの取得（縦、横）
    Size screenSize = MediaQuery.of(context).size;

    double screenWidth = screenSize.width; //横幅
    double screenheight = screenSize.height; //縦幅

    debugPrint('横幅：$screenWidth');
    debugPrint('縦幅：$screenheight');

    return Scaffold(
      body:Center(
        child: Container(
          width: screenWidth * 0.9,
          height: screenheight * 0.9,
          color: Colors.red,
        ),
      )
    );
  }
}