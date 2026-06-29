import 'package:flutter/material.dart';

import 'package:flutter_localization/flutter_localization.dart';

import 'app_locale.dart';

void main() async{

  //おまじない
  WidgetsFlutterBinding.ensureInitialized();
  
  //初期化
  await FlutterLocalization.instance.ensureInitialized();

  runApp(const LocalizationSetting());
}

class LocalizationSetting extends StatefulWidget {
  const LocalizationSetting({super.key});

  @override
  State<LocalizationSetting> createState() => _LocalizationSettingState();
}

class _LocalizationSettingState extends State<LocalizationSetting> {

  //Localizationのインスタンス
  final FlutterLocalization _localization = FlutterLocalization.instance;

  //Localizationの設定を初期化
  @override
  void initState() {
    super.initState();

    _localization.init(
      //サポート対象の言語リスト
      mapLocales: [
        const MapLocale('ja', AppLocale.ja), //日本語
        const MapLocale('en', AppLocale.en), //英語
      ],
      initLanguageCode: 'ja'
    );

    //言語が切り替わった時に呼ばれる
    _localization.onTranslatedLanguage = (Locale? locale){
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      //パッケージが生成する「対応言語リスト」をMaterialAppに渡す
      supportedLocales: _localization.supportedLocales,

      //「どの言語の時にどのテキストを使うか」を管理する仕組み
      localizationsDelegates: _localization.localizationsDelegates,

      home:const HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //カウンタ変数
  int _count = 0;

  //言語を切り替える関数
  void _changeLanguage(String code){
    //言語コードを渡す
    FlutterLocalization.instance.translate(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocale.greeting.getString(context),style: TextStyle(fontSize: 24),),
            Text(AppLocale.description.getString(context),style: TextStyle(fontSize: 24),),
            Text(AppLocale.buttonLabel.getString(context),style: TextStyle(fontSize: 24),),
            //翻訳テキストの｛0｝を_countに置き換えて表示
            Text(AppLocale.counter.getString(context).replaceAll('{0}', '$_count'),style: TextStyle(fontSize: 24),),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _count++;
                });
              }, 
              child: Text('+1')
            ),
            Text(AppLocale.changeLanguage.getString(context),style: TextStyle(fontSize: 24),),
            ElevatedButton(
              onPressed: (){
                //日本語に変換
                _changeLanguage('ja');
              }, 
              child: Text(AppLocale.langJa.getString(context),style: TextStyle(fontSize: 24),),
            ),
            ElevatedButton(
              onPressed: (){
                //英語に変換
                _changeLanguage('en');
              }, 
              child: Text(AppLocale.langEn.getString(context),style: TextStyle(fontSize: 24),),
            ),
          ],
        ),
      )
    );
  }
}