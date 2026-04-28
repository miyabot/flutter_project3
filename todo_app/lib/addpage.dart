import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('追加画面'),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
              SizedBox(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){}, 
                    child: Text('キャンセル')
                  ),
                  SizedBox(width: 48,),
                  ElevatedButton(
                    onPressed: (){}, 
                    child: Text('追加')
                  ),
                ],
              )
          ],

        ),
      )
    );
  }
}