import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Page1()
    );
  }
}
class Page1 extends StatelessWidget {
  Page1({super.key});

  String str = '渡したい値';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('ページ１'),
      ),
      body:Center(
        child:ElevatedButton(
          onPressed: (){
            //画面遷移
            Navigator.push(
              context,  //現在地 
              MaterialPageRoute(builder: (context)=>Page2(s:str)) //遷移先
            );
          }, 
          child:Text('次のページへ') 
        )
      )
    );
  }
}

class Page2 extends StatelessWidget {
  //コンストラクタ(引数)の設定
  Page2({super.key,required this.s});

  //受け取り用の変数
  String s;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('ページ２'),
      ),
      body:Center(
        child: Column(
          //Column,Rowを使うときに中央に寄せたい場合
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s),
            ElevatedButton(
              onPressed: (){
                //１つ前に戻る
                Navigator.pop(context);
              }, 
              child: Text('前のページへ')
            )
          ],
        ),
      )
    );
  }
}