import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //web通信用のパッケージ

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YubinApi(),
    );
  }
}

class YubinApi extends StatefulWidget {
  const YubinApi({super.key});

  @override
  State<YubinApi> createState() => _YubinApiState();
}

class _YubinApiState extends State<YubinApi> {
  //TextFieldの監視役
  final TextEditingController _controller = TextEditingController(); 

  //取得した住所情報を格納する変数
  String address = '';

  //メッセージを格納する変数
  String message = '';

  //郵便番号を検索する関数
  Future<void> searchCode(String code) async {
    //APIレスポンスを待ってることを示すメッセージ
    setState(() {
      message = 'APIレスポンス待ち';
    });

    //郵便番号検索APIへリクエストを送信
    final response = await http.get(
      //URLに変換
      Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$code')
    );

    //APIリクエストが失敗した場合は処理終了
    if(response.statusCode != 200){
      //早期リターン
      return;
    }

    //APIから帰ってきたJSONデータをMap型に変換
    final Map<String,dynamic> body = json.decode(response.body);
    //debugPrint('取得した情報：$body');

    //resuleというキーを使用して値を取り出す
    final List<dynamic> result = body['results'] ?? [];
    //debugPrint('取得した情報：$result');

    //結果が空ならエラーメッセージを表示
    if(result.isEmpty){
      setState(() {
        message = '住所が存在しません';
      });
    }
    else{
      //メッセージのクリア
      setState(() {
        message = '';

        //最初の結果を取得し、住所を代入
        final res = result[0];
        address = '${res['address1']}${res['address2']}${res['address3']}';
        debugPrint(address);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          //TextFieldに変更が発生するたびに呼ばれる
          onChanged: (value){
            //郵便番号検索
            searchCode(value);
          },
        ),
      ),
      //三項演算子による条件分岐
      body:(message.isEmpty) ? Text(address) : Text(message)
    );
  }
}
