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
      home:TimerApp()
    );
  }
}

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {

  //ストップウォッチ用
  //late:初期化を後回しにする
  late Stopwatch _stopwatch;

  Timer? _timer;

  //初期化関数
  @override
  void initState() {
    super.initState();

    _stopwatch = Stopwatch();

    //30ミリ秒ごとに画面と値を更新
    _timer = Timer.periodic(
      Duration(milliseconds: 30), //実行間隔(30ミリ秒ごと) 
      //30ミリ秒ごとに行う処理
      (Timer timer){
        setState(() {});
      }
    );
  }

  //表示用の経過時間(分:秒.ミリ秒)をフォーマット
  String _formatTime(){

    final _elapsed = _stopwatch.elapsed;

    String minutes = (_elapsed.inMinutes % 60).toString().padLeft(2,'0');
    String seconds = (_elapsed.inSeconds % 60).toString().padLeft(2,'0');
    String milliSeconds = (_elapsed.inMilliseconds % 1000).toString().padLeft(3,'0');

    return '$minutes:$seconds.$milliSeconds';
  }

  //画面が破棄されるときに呼ばれる
  @override
  void dispose() {
    super.dispose();

    //タイマーを破棄
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        //elapsed:経過時間
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_formatTime(),style: TextStyle(fontSize: 36),),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  //ボタンの見た目を変更
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    minimumSize: Size(130,75)
                  ),
                  onPressed:(){
                    //ストップウォッチを開始
                    _stopwatch.start();
                  }, 
                  child:Text('スタート',style: TextStyle(fontSize: 20),)
                ),
                SizedBox(width: 16,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    minimumSize: Size(130,75)
                  ),
                  onPressed:(){
                    //ストップウォッチを停止
                    _stopwatch.stop();
                  }, 
                  child:Text('ストップ',style: TextStyle(fontSize: 20),)
                ),
                SizedBox(width: 16,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    minimumSize: Size(130,75)
                  ),
                  onPressed:(){
                    //ストップウォッチをリセット
                    _stopwatch.reset();
                  }, 
                  child:Text('リセット',style: TextStyle(fontSize: 20),)
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}