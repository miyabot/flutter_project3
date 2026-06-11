import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}

class Spot{
  final String name; //スポット名
  final String desc; //説明
  final LatLng position;//座標
  final Image image; //画像

  //コンストラクタの設定
  Spot({required this.name,required this.desc,required this.position,required this.image});
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  //現在地を格納する変数(NULL許容型)
  LatLng? _currentPosition;

  //ロード中を判定する変数
  bool _loading = true;

  final List<Spot> spots = [
    Spot(name:'姫路城',desc: '世界遺産',position: LatLng(34.83, 134.69),image: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Himeji_castle_in_may_2015.jpg/330px-Himeji_castle_in_may_2015.jpg')),
    Spot(name:'有馬温泉',desc: '日本三古湯',position: LatLng(34.80, 135.25),image: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Himeji_castle_in_may_2015.jpg/330px-Himeji_castle_in_may_2015.jpg')),
    Spot(name:'城崎温泉',desc: '外湯めぐり',position: LatLng(35.62, 134.80),image: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Himeji_castle_in_may_2015.jpg/330px-Himeji_castle_in_may_2015.jpg')),
  ];

  //現在地点を取得する関数
  Future<void> _geoLocation()async{
    //パーミッション(権限)確認
    LocationPermission permission = await Geolocator.checkPermission();

    //denied:まだ一度も許可していない
    //deniedForever:「今後表示しない」で拒否した
    //whileInUse:アプリ使用中のみ許可
    //always:常に許可

    if(permission == LocationPermission.denied){
      //許可確認のダイアログを表示
      permission = await Geolocator.requestPermission(); 
    }
    //拒否した場合
    if(permission == LocationPermission.deniedForever){
      return;
    }

    //現在地の取得
    final pos = await Geolocator.getCurrentPosition();
    debugPrint('現在地：$pos');

    setState(() {
      _currentPosition = LatLng(pos.latitude, pos.longitude);
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _geoLocation();
  }

  @override
  Widget build(BuildContext context) {
    //ロード中か
    if(_loading){
      //ロード画面を表示
      return Scaffold(
        body:Center(
          child: CircularProgressIndicator()
        )
      );
    }

    final center = _currentPosition ?? const LatLng(40.6901, 95.1956);

    return Scaffold(
      appBar: AppBar(
        title: const Text('地図アプリ'),
      ),
      body:FlutterMap(
        options: MapOptions(
          //初期座標(緯度,経度)
          initialCenter: center,
          //初期ズームレベル
          initialZoom: 13.0,
          //余白を消す
          cameraConstraint: const CameraConstraint.containLatitude()
        ),
        children:[
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: center, 
                child: const Icon(Icons.location_pin,size: 40,color: Colors.red,)
              ),
            ]
          ),
          //観光地用
          MarkerLayer(
            markers:
              //spotsの要素を１つずつ取り出して処理
              spots.map(
                (spot)=>Marker(
                  point: spot.position, 
                  child: GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context, 
                        builder: (context){
                          return AlertDialog(
                            title:Text(spot.name),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                spot.image,
                                SizedBox(height: 8,),
                                Text(spot.desc)
                              ],
                            ),
                          );
                        }
                      );
                    },
                    child: const Icon(Icons.location_pin,size: 40,color: Colors.black)
                  )
                )
              ).toList(),
             
          )
        ]
      ),
    );
  }
}