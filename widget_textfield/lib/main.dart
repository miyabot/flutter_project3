import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, //バナー非表示
      home:TextFieldSample()
    );
  }
}

class TextFieldSample extends StatefulWidget {
  const TextFieldSample({super.key});

  @override
  State<TextFieldSample> createState() => _TextFieldSampleState();
}

class _TextFieldSampleState extends State<TextFieldSample> {

  //パスワード認証用
  String pass = 'abc123';

  //エラーメッセージ用
  bool errorFlg = false;

  //パスワードの表示・非表示を切り替え用
  bool showFlg = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //サイズの情報を持った透明の箱
      body:Center(
        child: SizedBox(
          width: 300.0,
          //TextField:入力可能なフィールド
          child: TextField(
            
            //パスワードの表示・非表示
            obscureText: showFlg,

            //decoration:見た目の装飾
            decoration: InputDecoration(
              //suffix:右端
              suffixIcon: IconButton(
                onPressed: (){
                  //フラグの反転(!)
                  setState(() {
                    showFlg = !showFlg;
                  });
                },
                icon:Icon(Icons.visibility)
              ),
              labelText: 'パスワードを入力してください。',
              //errorText: 'パスワードが正しくありません。',
              border:OutlineInputBorder() //外枠をつける
            ),
          ),
        ),
      )
    );
  }
}