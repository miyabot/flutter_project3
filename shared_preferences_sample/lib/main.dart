import 'package:flutter/material.dart';
//ローカル保存用
import 'package:shared_preferences/shared_preferences.dart'; 

//JSON変換用
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

//保存したいデータを定義したクラス
class Memo{
  final String title;
  final DateTime createdAt;

  //コンストラクタの設定
  Memo({required this.title,required this.createdAt});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _con = TextEditingController();

  //保存したテキスト表示用
  String _saveText = '';

  //リスト表示用
  List<String> _saveList = [];

  //マップ表示用
  Map<DateTime,String> _saveMap = {};

  //クラス内の変数表示用
  //?:null許容型
  Memo? _saveClass;

  //初期化関数(buildよりも前に呼ばれる)
  @override
  void initState() {
    super.initState();

    //ロード
    _loadSaveData();
    _loadSaveDataList();
    _loadSaveDateMap();
  }


  //入力したテキストを保存する関数
  Future<void> _saveData()async{
    //SharedPreferenceを使うための準備
    final prefs = await SharedPreferences.getInstance();

    //TextFieldに入力した文字列を「save_text」というkeyで保存
    await prefs.setString('save_text', _con.text);

    setState(() {
      _saveText = _con.text;  
    });
    
  }

  //保存されているテキストを読み込む関数
  Future<void> _loadSaveData()async{
    //SharedPreferenceを使うための準備
    final prefs = await SharedPreferences.getInstance();
    
    //起動時に保存されているデータを読み込む
    setState(() {
      //データがなければ(null)空文字('')を使う
      _saveText = prefs.getString('save_text') ?? '';
    });

  }

  //List<String>を保存する関数
  Future<void> _saveDataList()async{
    final prefs = await SharedPreferences.getInstance();

    //入力内容をリストに追加
    setState(() {
      _saveList.add(_con.text);
    });

    //保存
    await prefs.setStringList('save_list', _saveList);
  }

  //保存されているList<String>を読み込む関数
  Future<void> _loadSaveDataList()async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      //データがなければ空リストを使う
      _saveList = prefs.getStringList('save_list') ?? [];
    });
  }

  //Map<DateTime,String>を保存する関数
  Future<void> _saveDataMap()async{
    final prefs = await SharedPreferences.getInstance();

    //現在時刻と入力内容をMapに追加
    setState(() {
      _saveMap[DateTime.now()] = _con.text;
    });

    //Map<DateTime,String>をMap<String,dynamic>に変換
    final Map<String,dynamic> encodeMap = {};

    //_saveMapの各要素をencodeMapに代入
    _saveMap.forEach((key,value){
      //「DateTime型」を「JSONが理解できるString型」に変換
      encodeMap[key.toIso8601String()] = value;
    });

    //中身の確認
    debugPrint('$encodeMap');

    //JSON文字列に変換
    final jsonString = json.encode(encodeMap);

    //'save_map'というキーで保存
    await prefs.setString('save_map', jsonString);
  }

  //保存されているJSON文字列を読み込む関数
  Future<void> _loadSaveDateMap()async{
    final prefs = await SharedPreferences.getInstance();

    //JSON文字列を取り出す。データがなければ空のJSON文字列を返す
    final jsonString = prefs.getString('save_map') ?? '{}';

    //JSON文字列をMap<String,dynamic>に変換 
    final decodeMap = json.decode(jsonString) as Map<String,dynamic>;

    //Map<String,dynamic>をMap<DateTime,String>に変換
    final Map<DateTime,String> tempMap = {};
    decodeMap.forEach((key,value){
      //StringからDateTimeへ変換(parse)
      tempMap[DateTime.parse(key)] = value;
    });

    setState(() {
      _saveMap = tempMap;
    });

  }

  //クラスを保存する関数
  Future<void> _saveClassData()async{
    final prefs = await SharedPreferences.getInstance();
  }

  //保存されているクラスを読み込む処理
  Future<void> _loadSaveClassData()async{
    final prefs = await SharedPreferences.getInstance();
  }

  //保存されているテキストを削除する関数
  Future<void> _clearData()async{
    final prefs = await SharedPreferences.getInstance();

    //指定したkeyのデータを削除
    await prefs.remove('save_text');
    await prefs.remove('save_list');

    setState(() {
      //アプリ側の削除
      _saveText = '';
      _saveList = [];
      _saveMap = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          TextField(
            controller: _con,
          ),
          SizedBox(height:12),
          ElevatedButton(onPressed:_saveData,child: const Text('テキスト保存')),
          SizedBox(height:12),
          ElevatedButton(onPressed: _saveDataList,child: const Text('リスト保存')),
          SizedBox(height:12),
          ElevatedButton(onPressed: _saveDataMap,child: const Text('マップ保存')),
          SizedBox(height:12),
          ElevatedButton(
            onPressed: (){
              _saveClassData();
            }, 
            child: const Text('クラス保存')
          ),
          SizedBox(height:12),
          ElevatedButton(
            onPressed: (){
              _clearData();
            }, 
            child: const Text('削除')
          ),
          SizedBox(height:12),
          Text('保存されているテキスト(String)'),
          Text(_saveText,style: TextStyle(fontSize: 36),),
          Text('保存されているテキスト(List<String>)'),
          Text(_saveList.join('\n'),style: TextStyle(fontSize: 36),),
          Text('保存されているテキスト(Map<String,int>'),
          //_saveMapの各要素を取りだしてそれぞれのkeyとvalueを表示
          Text(_saveMap.entries.map((e)=>'${e.key} : ${e.value}').join('\n'),style: TextStyle(fontSize: 36),)
        ],
      )
    );
  }
}
