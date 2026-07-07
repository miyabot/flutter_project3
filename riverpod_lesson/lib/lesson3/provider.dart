import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends Notifier<int> {

  //stateの初期値
  @override
   build() {
    return 0;
  }

  void increment(){
    state++;
  }
}

final counterProvider = NotifierProvider<Counter,int>(Counter.new);

//２倍の値を返すProvider
//counterProviderの値が変わると、こちらも変わる
final doubleProvider = Provider<int>((ref)=>ref.watch(counterProvider) * 2);