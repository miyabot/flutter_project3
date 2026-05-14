import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AsyncSample2(),
    );
  }
}

class AsyncSample2 extends StatefulWidget {
  const AsyncSample2({super.key});

  @override
  State<AsyncSample2> createState() => _AsyncSample2State();
}

class _AsyncSample2State extends State<AsyncSample2> {
  //インジケータの表示切り替え用
  bool _isWorking = false;

  //画面表示用
  List<String> _logs = [];

  //ログへの追加
  void _addLog(String msg){
    setState(() {
      _logs.add(msg);
    });
  }

  //各調理工程
  Future<String> _cookBurger() async {
    //２秒待つ
    await Future.delayed(const Duration(seconds: 2));
    return 'ハンバーガー';
  }
  Future<String> _fryPotato() async {
    //３秒待つ
    await Future.delayed(const Duration(seconds: 3));
    return 'ポテト';
  }
  Future<String> _pourDrink() async {
    //１秒待つ
    await Future.delayed(const Duration(seconds: 1));
    return 'コーラ';
  }

  //１．逐次処理：１つずつ順番に待つ
  Future<void> _orderSerial() async {
    setState(() {
      //インジケーターを表示に切り替え
      _isWorking = true;

      //ログのクリア
      _logs.clear();
    });

    //ストップウォッチの作成
    Stopwatch stopwatch = Stopwatch();

    //ストップウォッチを開始
    stopwatch.start();

    //ハンバーガーの調理
    String burger = await _cookBurger();
    _addLog('$burger 完了');

    //ポテトの調理
    String potato = await _fryPotato();
    _addLog('$potato 完了');

    //ドリンクを注ぐ 
    String drink = await _pourDrink();
    _addLog('$drink 完了');

    //ストップウォッチを停止
    stopwatch.stop();

    //調理にかかった時間をログに追加
    _addLog('調理完了までに${stopwatch.elapsed.inSeconds}秒かかりました');

    //インジケーターを非表示に切り替え
    setState(() {
      _isWorking = false;  
    });
  }

  //２．並列処理：一斉に始めて全部待つ
  Future<void> _orderParallel() async {
    setState(() {
      //インジケーターを表示に切り替え
      _isWorking = true;

      //ログのクリア
      _logs.clear();
    });

    //ストップウォッチの作成
    Stopwatch stopwatch = Stopwatch();

    //ストップウォッチを開始
    stopwatch.start();

    //すべての調理を一斉に開始、すべての結果が返ってくるまで待つ
    List<String> results = await Future.wait([
      _cookBurger(),
      _fryPotato(),
      _pourDrink()
    ]);

    //結果をログに追加
    //join：結合
    _addLog('${results.join('+')} が一斉に揃いました');

    //ストップウォッチを停止
    stopwatch.stop();

    //調理にかかった時間をログに追加
    _addLog('調理完了までに${stopwatch.elapsed.inSeconds}秒かかりました');

    //インジケーターを非表示に切り替え
    setState(() {
      _isWorking = false;  
    });

  }

  //３．タイムアウト：時間がかかりすぎたら諦める
  Future<void> _orderWithTimeout() async {
    setState(() {
      //インジケーターを表示に切り替え
      _isWorking = true;

      //ログのクリア
      _logs.clear();
    });

    //エラーが起きるかもしれない処理
    try{
      //1秒以内終わらなければエラーを投げる設定
      final result = await _cookBurger().timeout(const Duration(seconds: 1));
    }
    //タイムアウトした時に呼ばれる
    on TimeoutException{
      _addLog('時間がかかりすぎています');
    }
    //成功でも失敗でも最後に実行される
    finally{
      setState(() {
        _isWorking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          children: [
            //インジケータUI
            if(_isWorking)LinearProgressIndicator(),
            SizedBox(height:16),
            ElevatedButton(
              onPressed: (){
                _orderSerial();
              }, 
              child: Text('逐次')
            ),
            SizedBox(height:16),
            ElevatedButton(
              onPressed: (){
                _orderParallel();
              }, 
              child: Text('並列')
            ),
            SizedBox(height:16),
            ElevatedButton(
              onPressed: (){
                _orderWithTimeout();
              }, 
              child: Text('制限')
            ),

            //使用可能なスペースを埋める
            Flexible(
              //ログの内容を表示
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context,index){
                  return Text(_logs[index],style: TextStyle(fontSize: 20));
                }
              ),
            )
          ],
        ),
      )
    );
  }
}