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
        child:Column(
          //中央に寄せる
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                //画面遷移
                Navigator.push(
                  context,  //現在地 
                  MaterialPageRoute(builder: (context)=>Page2(s:str)) //遷移先
                );
              }, 
              child:Text('ページ２へ') 
            ),
            //SizedBox:サイズの情報を持った透明の箱
            SizedBox(
              height: 32.0, //縦幅
            ),
            ElevatedButton(
              onPressed: (){
                //画面遷移
                Navigator.push(
                  context,  //現在地 
                  MaterialPageRoute(builder: (context)=>Page3(s:str)) //遷移先
                );
              }, 
              child:Text('ページ３へ') 
            ),
          ],
        ),
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

//窓口：外部からデータを受け取る場所
class Page3 extends StatefulWidget {
  //コンストラクタの設定(引数の設定)
  Page3({super.key,required this.s});

  //受け取り用の変数
  String s;

  @override
  State<Page3> createState() => _Page3State();
}

//中身：実際に処理などを書く場所
class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('ページ３')
      ),
      body:Center(
        //widget:親クラスが持っている情報を取得
        child: Text(widget.s),
      )
    );
  }
}