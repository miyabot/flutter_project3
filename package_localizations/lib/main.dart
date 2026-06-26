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
    return const MaterialApp(
      home:HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

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
            Text('こんにちは！'),
            Text('ボタンを押すと言語が切り替わります。'),
            Text('ボタンを押した回数'),
            Text('0回'),
            ElevatedButton(
              onPressed: (){}, 
              child: Text('+1')
            ),
            Text('言語を切り替える'),
            ElevatedButton(
              onPressed: (){}, 
              child: Text('日本語')
            ),
            ElevatedButton(
              onPressed: (){}, 
              child: Text('英語')
            ),
          ],
        ),
      )
    );
  }
}