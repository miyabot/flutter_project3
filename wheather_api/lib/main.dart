import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherApi(),
    );
  }
}

class WeatherApi extends StatefulWidget {
  const WeatherApi({super.key});

  @override
  State<WeatherApi> createState() => _WeatherApiState();
}

class _WeatherApiState extends State<WeatherApi> {

  String areaName = ''; //地域名
  String weather = ''; //天気
  double temperature = 0; //温度
  double temperatureMax = 0; //最高気温
  double temperatureMin = 0; //最高気温
  int humidity = 0; //湿度

  //地域を検索して天気情報を取得する関数
  Future<void> searchWeather(String area)async{
    //weatherAPIへリクエストを送信
    final response = await http.get(
      //URLに変換
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?appid=66d7d1034d5abb6115ceff69223e0a75&lang=ja&units=metric&q=$area')
    );

    //成功リクエストかどうか
    if(response.statusCode != 200){
      //debugPrint('取得に失敗した${response.statusCode}');
      return;
    }
    //debugPrint(response.body);

    //JSONからMap型にデコード
    final Map<String,dynamic> body = json.decode(response.body);
    //??:値が入っていなかったら(null)
    final Map<String,dynamic> main = body['main'] ?? {};
    debugPrint('$main');

    setState(() {
        areaName = body['name'] ?? '';
        weather = body['weather'][0]['description'] ?? '';
        temperature = main['temp'] ?? 0.0;
        temperatureMax = main['temp_max'] ?? 0.0;
        temperatureMin = main['temp_min'] ?? 0.0;
        humidity = main['humidity'] ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          //入力内容が変わるたびに呼ばれる
          onChanged: (value){
            searchWeather(value);
          },
        ),
      ),
      body:ListView(
        children: [
          ListTile(title:Text('地域'),subtitle: Text(areaName)),
          ListTile(title:Text('天気'),subtitle: Text(weather)),
          ListTile(title:Text('温度'),subtitle: Text('$temperature')),
          ListTile(title:Text('最高気温'),subtitle: Text('$temperatureMax')),
          ListTile(title:Text('最低気温'),subtitle: Text('$temperatureMin')),
          ListTile(title:Text('湿度'),subtitle: Text('$humidity')),
        ],
      )
    );
  }
}