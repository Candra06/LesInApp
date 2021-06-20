import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardTentorPage extends StatefulWidget {
  @override
  _DashboardTentorPageState createState() => _DashboardTentorPageState();
}

class _DashboardTentorPageState extends State<DashboardTentorPage> {
  String nama = '', username = '', token = '', id = '';
  void getInfo() async {
    var tmpNama = await Config.getNama();
    var tmpToken = await Config.getToken();
    var tmpUsername = await Config.getUsername();
    var tmpID = await Config.getID();
    setState(() {
      nama = tmpNama;
      username = tmpUsername;
      token = tmpToken;
      id = tmpID;
    });
  }

  List jadwal = new List();
  bool load = true;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  getUserLocation() async {
    await Permission.location.request();
    var status = await Permission.location.status;
    var latitude, longitude;
    if (status.isGranted) {
      Location location = new Location();
      LocationData myLocation;
      String error;
      try {
        myLocation = await location.getLocation();
        _currentLatLong = myLocation.latitude.toString() + ', ' + myLocation.longitude.toString();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          print(error);
        }
        myLocation = null;
      }
      setState(() {
        var lokasi = _currentLatLong.split(",");
        latitude = double.parse(lokasi[0]);
        longitude = double.parse(lokasi[1]);
      });
    } else {
      print('kosong');
    }
    myLat = latitude.toString();
    myLong = longitude.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('latitude', myLat);
    await pref.setString('longitude', myLong);
  }

  void getJadwal() async {
    String tokenn = await Config.getToken();
    setState(() {
      load = true;
    });
    http.Response res = await http.get(Config.ipServerAPI + 'listJadwal', headers: {'Authorization': 'Bearer $tokenn'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        jadwal = data['data'];
        load = false;
      });
    } else {
      setState(() {
        Config.alert(0, 'Gagal memuat data');
        load = false;
      });
    }
  }

  String _currentLatLong;
  var location = new Location();
  String myLat, myLong;

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (jadwal.length == 0) {
      return Center(
        child: Container(
          child: Text(
            'Tidak ada jadwal hari ini',
            style: TextStyle(fontFamily: 'AirbnbBold'),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: jadwal.isEmpty ? 0 : jadwal.length,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              child: Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            jadwal[i]['nama'],
                            style: TextStyle(fontSize: 16, fontFamily: 'AirbnbMedium'),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                jadwal[i]['mapel'],
                                style: TextStyle(fontFamily: 'Airbnb', color: Config.primary),
                              )),
                        ],
                      )),
                      Container(
                          child: Row(
                        children: <Widget>[
                          Text(
                            jadwal[i]['pertemuan'].toString() + '/' + jadwal[i]['jumlah_pertemuan'].toString(),
                            style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),
                          )
                        ],
                      ))
                    ],
                  )),
            );
          });
    }
  }

  @override
  void initState() {
    getInfo();
    getUserLocation();
    getJadwal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FadeAnimation(
              1.4,
              new Container(
                height: 225,
                child: Stack(
                  children: <Widget>[
                    FadeAnimation(
                      1.2,
                      new Container(
                        width: displayWidth(context),
                        padding: EdgeInsets.only(right: 16, left: 16, top: 38),
                        height: 225,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
                            gradient: new LinearGradient(
                              colors: <Color>[Config.primary, Config.secondary, Config.darkPrimary],
                              end: Alignment(1.5, 0.0),
                            )),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              "Halo, $nama".toUpperCase(),
                              style: new TextStyle(
                                fontFamily: 'AirbnbBold',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            new Text(
                              'Selamat datang'.toUpperCase(),
                              style: new TextStyle(
                                fontFamily: 'AirbnbBold',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: new Container(
                            width: displayWidth(context),
                            margin: EdgeInsets.only(right: 16, left: 16),
                            height: 150,
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            width: 90.0,
                                            height: 90.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/icons/graduate.png')),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8, bottom: 8),
                                    height: 50,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text('$nama', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                                        ),
                                        Container(
                                          child: Text('$username', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textWhite, fontSize: 14, fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            FadeAnimation(
              1.5,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.LIST_CHAT_TENTOR);
                },
                child: new Container(
                    width: displayWidth(context),
                    margin: EdgeInsets.only(right: 16, left: 16, top: 16),
                    height: 100,
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              elevation: 3,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(width: 30, child: Image.asset('assets/icons/chat.png')),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Text('Chat', style: TextStyle(color: Colors.black45, fontFamily: 'AirbnbMedium')),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.DOMPET);
                              },
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(width: 30, child: Image.asset('assets/icons/wallet.png')),
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: Text('Dompet', style: TextStyle(color: Colors.black45, fontFamily: 'AirbnbMedium')),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            FadeAnimation(
              1.6,
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(
                  'Jadwal hari ini',
                  style: TextStyle(fontFamily: 'AirbnbMedium'),
                ),
              ),
            ),
            FadeAnimation(
              1.7,
              Container(constraints: BoxConstraints(minHeight: 200, maxHeight: 300), margin: EdgeInsets.fromLTRB(16, 8, 16, 8), child: item()),
            )
          ],
        ),
      ),
    );
  }
}
