import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AsyncSmaple(),
    );
  }
}

class AsyncSmaple extends StatefulWidget {
  const AsyncSmaple({super.key});

  @override
  State<AsyncSmaple> createState() => _AsyncSmapleState();
}

class _AsyncSmapleState extends State<AsyncSmaple> {

  //結果を表示するための変数
  String _log = '注文を待っています...';

  //肉を焼く処理関数
  //async、await:非同期処理のキーワード
  //Future<型>：非同期処理を使う場合に指定が必要
  Future<String> _cook() async {
    //await:結果が返ってくるまで待ってほしい時に使用
    await Future.delayed(const Duration(seconds:3));
    return '上手に焼けました！';
  }

  //awaitなし関数
  void _makePatty(){
    //_logを'調理開始！'に変更
    setState(() {
      _log = '調理開始！';
    });

    //調理関数を呼び出す
    Future<String> patty = _cook();

    //_logを'お待たせしました　パティの状態：'
    setState(() {
      _log = 'お待たせしました パティの状態：$patty';
    });
  }

  //awaitあり関数
  Future<void> _makePattyProperly()async{
    //_logを'調理開始！'に変更
    setState(() {
      _log = '調理開始！';
    });

    //調理関数を呼び出す
    //結果が返ってくるまで待つ
    String patty = await _cook();

    //_logを'お待たせしました　パティの状態：'
    setState(() {
      _log = 'お待たせしました パティの状態：$patty';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('async/await'),
      ),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(20),
                child: Text(_log,style:TextStyle(fontSize: 32)),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: (){
                  _makePatty();
                }, 
                child: const Text('awaitなし')
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  _makePattyProperly();
                }, 
                child: const Text('awaitあり')
              ),
          
            ],
          ),
        ),
      )
    );
  }
}