import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:DialogSample()
    );
  }
}

class DialogSample extends StatefulWidget {
  const DialogSample({super.key});

  @override
  State<DialogSample> createState() => _DialogSampleState();
}

class _DialogSampleState extends State<DialogSample> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: ElevatedButton(
          onPressed: (){
            //ダイアログの表示
            showDialog(
              context: context, 
              //ダイアログの見た目を変える
              builder: (context)=>AlertDialog(
                backgroundColor: Colors.white, //背景色
                title: Center(child: Text('アカウント削除',style: TextStyle(fontWeight: FontWeight.bold),)),
                //中身(title以外の部分)
                content: Column(
                  //内容に合わせて最小限の高さになる
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('削除すると以下の情報がすべて失われます'),
                    SizedBox(height: 20.0,),
                    Container(
                      //見た目の変更
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 245, 245, 245),
                      ),
                      padding: EdgeInsets.all(12),
                      width:250.0,
                      height: 150.0,
                      child: Column(
                        //左端
                        crossAxisAlignment: CrossAxisAlignment.start,

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('・プロフィール情報'),
                          Text('・写真データ'),
                          Text('・メッセージ'),
                          Text('・お気に入り'),
                          Text('・フォロー/フォロワー'),
                        ],
                      ),
                    ),
                  ],
                ),
                //ユーザーが取るべき最終アクション
                actions: [
                  Row(
                    //spaceAround:等間隔に並べる
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        //見た目の変更
                        style: ElevatedButton.styleFrom(
                          //サイズ変更(最小サイズの設定)
                          minimumSize: Size(120, 50),
                          backgroundColor: Colors.white,
                          //枠線
                          side:BorderSide(),
                          //角丸
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),

                        onPressed: (){
                          //前の画面に戻る
                          Navigator.pop(context);  
                        }, 
                        child: Text('キャンセル',style:TextStyle(color: const Color.fromARGB(169, 0, 0, 0)))
                      ),
                      ElevatedButton(
                        //見た目の変更
                        style: ElevatedButton.styleFrom(
                          //サイズ変更(最小サイズの設定)
                          minimumSize: Size(130, 50),
                          backgroundColor: const Color.fromARGB(255, 250, 98, 87),

                          //角丸
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                        onPressed: (){
                          //タスクキル
                          exit(0);
                        }, 
                        child: Text('削除',style:TextStyle(color: Colors.white))
                      ),
                    ],
                  ),
                ],
              )
            );
          }, 
          child: Text('アカウント削除')
        ),
      )
    );
  }
}