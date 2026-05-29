import 'package:flutter/material.dart';
//ローカル保存用
import 'package:shared_preferences/shared_preferences.dart'; 

void main() {
  runApp(const MyApp());
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

  //初期化関数(buildよりも前に呼ばれる)
  @override
  void initState() {
    super.initState();

    //ロード
    _loadSaveData();
    _loadSaveDataList();
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
          ElevatedButton(
            onPressed: (){
              _saveData();
            }, 
            child: const Text('テキスト保存')
          ),
          SizedBox(height:12),
          ElevatedButton(
            onPressed: (){
              _saveDataList();
            }, 
            child: const Text('リスト保存')
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
          Text(_saveList.join('\n'),style: TextStyle(fontSize: 36),)
        ],
      )
    );
  }
}
