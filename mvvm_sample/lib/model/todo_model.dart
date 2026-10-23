//データの形を決めるファイル
class Todo{
  //コンストラクタの設定
  Todo({required this.title,this.isDone = false});

  //やることの名前
  String title;

  //タスクが完了したかどうか
  bool isDone;
}