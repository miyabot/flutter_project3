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

  //TextField内を管理するコントローラーの作成
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //サイズの情報を持った透明の箱
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0,
              //TextField:入力可能なフィールド
              child: TextField(
                //コントローラー(管理者)の設定
                controller: _controller,
                
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
                    icon:(showFlg == true) ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                  ),
                  labelText: 'パスワードを入力してください。',
                  //三項演算子((条件式) ? 真 : 偽)
                  errorText: (errorFlg == true) ? 'パスワードが正しくありません。' : null,
                  border:OutlineInputBorder() //外枠をつける
                ),
              ),
            ),
            //ログインボタン
            ElevatedButton(
              onPressed: (){
                if(pass == _controller.text) {
                  //ログイン成功
                  setState(() {
                    errorFlg = false;  
                  });
                }
                else{
                  //ログイン失敗
                  setState(() {
                    errorFlg = true;  
                  });
                } 
                //debugPrint('TextFieldの内容：${_controller.text}');
              }, 
              child: Text('送信')
            )
          ],
        ),
      )
    );
  }
}