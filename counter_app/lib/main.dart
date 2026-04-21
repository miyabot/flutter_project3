import 'package:flutter/material.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:CounterApp()
    );
  }
}

//stateful:状態あり(画面の更新ができる)
//状態：変化する可能性のあるデータ
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {

  //変数や関数の定義場所
  int cnt = 0;

  //statefulでも処理はbuildの中
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Center:中央に寄せる
      body:Center(
        child: Column(
          //Columnを使う場合の中央寄せ
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$cnt',style: TextStyle(fontSize: 36)),
            ElevatedButton(
              onPressed: (){
                //setState:画面更新  
                setState(() {
                  cnt++;
                });
                debugPrint('カウント数：$cnt');
              }, 
              child: Text('+1',style: TextStyle(fontSize: 36)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200,50)
              ),
            )
          ],
        ),
      )
    );
  }
}

//Stateless:状態を持たないクラス(画面の更新が出来ない)
// class ConterApp extends StatelessWidget {
//   ConterApp({super.key});

//   //変数や関数の定義場所
//   int cnt = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Column(
//         children: [
//           Text('0',style: TextStyle(fontSize: 36)),
//           ElevatedButton(
//             onPressed: (){
//               cnt++;
//               debugPrint('カウント数：$cnt');
//             }, 
//             child: Text('+1',style: TextStyle(fontSize: 36)),
//             style: ElevatedButton.styleFrom(
//               minimumSize: Size(200,50)
//             ),
//           )
//         ],
//       )
//     );
//   }
// }

