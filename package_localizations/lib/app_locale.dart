//翻訳テキストを管理するクラス

mixin AppLocale{
  static const String greeting = 'greeting'; //あいさつ文
  static const String description = 'description'; //説明文
  static const String buttonLabel = 'buttonLabel'; //ボタンの説明ラベル
  static const String counter = 'counter'; //counter表示
  static const String changeLanguage = 'changeLanguage'; //言語切り替えボタンのラベル
  static const String langJa = 'langJa';
  static const String langEn = 'langEn';

  //日本語の翻訳データ
  static const Map<String,dynamic> ja = {
    greeting:'こんにちは！',
    description:'ボタンを押すと言語が切り替わります。',
    buttonLabel:'ボタンを押した回数',
    counter:'{0} 回',
    changeLanguage:'言語を切り替える',
    langJa:'日本語',
    langEn:'英語'
  };

  //英語の翻訳データ
  static const Map<String,dynamic> en = {
    greeting:'Hello!',
    description:'Tap the button to change the language.',
    buttonLabel:'Button pressed count',
    counter:'{0} times',
    changeLanguage:'Change Language',
    langJa:'Japanese',
    langEn:'English'
  };
}