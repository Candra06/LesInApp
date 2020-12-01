import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListTentor extends StatefulWidget {
  final String idDataMengajar;
  ListTentor({this.idDataMengajar});
  @override
  _ListTentorState createState() => _ListTentorState();
}

class _ListTentorState extends State<ListTentor> {
  String token = '';
  bool load = true;
  List tentor = new List();

  Future<double> countDistance(String lat, long) async {
    Geolocator geolocator = new Geolocator();
    String latit = await Config.getLatitude();
    String longi = await Config.getLongitude();
    double la = double.parse(latit);
    double lo = double.parse(longi);
    Future<double> distance = geolocator.distanceBetween(
        la, lo, double.parse(lat), double.parse(long));
    double jarak = await distance / double.parse('1000');
    return jarak;
  }

  Future getData() async {
    setState(() {
      load = true;
    });
    List tempList = new List();
    String idMapel = widget.idDataMengajar;
    String latit = await Config.getLatitude();
    String longi = await Config.getLongitude();
    print(latit);
    print(longi);
    print(idMapel);
    token = await Config.getToken();
    http.Response res = await http.get(
        Config.ipServerAPI + 'getTentor/$idMapel',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data['data'].length);
      int len = data['data'].length;
      for (var i = 0; i < len; i++) {
        double tmpdis = await countDistance(
            data['data'][i]['lattitude'].toString(),
            data['data'][i]['longitude'].toString());
        if (tmpdis <= 10.000) {
          tempList.add(data['data'][i]);
        }
      }
      setState(() {
        tentor = tempList;
        load = false;
      });
    } else {
      Config.alert(2, "Terjadi Kesalahan. Silahkan Coba Lagi");
      setState(() {
        load = false;
      });
    }
  }

  Widget item(index) {
    String rating = tentor[index]['rating'];
    return InkWell(
      onTap: () {
        var param = {
          'idMapel' : widget.idDataMengajar,
          'idTentor' : tentor[index]['id_tentor'].toString()
        };
        Navigator.pushNamed(
          context,
          Routes.DETAIL_TENTOR,
          arguments: param,
        );
        // print(tentor[index]['id_tentor'].toString());
      },
      child: Card(
        child: Container(
            margin: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/icons/graduate.png')),
                    )),
                Container(
                    constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tentor[index]['nama'],
                          // dataPenyakit[index]["nama_penyakit"],
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'AirbnbMedium'),
                        ),
                        Container(
                            child: Text(
                          tentor[index]['telepon'],
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.textGrey),
                        )),
                        Container(
                            child: Text(
                          'Rating $rating/5',
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.primary),
                        )),
                      ],
                    )),
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Config.primary,
                    Config.secondary,
                    Config.darkPrimary
                  ])),
        ),
        title: Text(
          'Pilih Tentor',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: ListView.builder(
          itemCount: tentor.length == 0 || tentor == null || tentor == []
              ? 0
              : tentor.length,
          itemBuilder: (BuildContext context, int i) {
            if (load) {
              return Config.loading(context);
            } else if (tentor.length == 0) {
              return Center(
                child: Container(
                  child: Text(
                    'Data tentor kosong',
                    style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 18),
                  ),
                ),
              );
            } else {
              return item(i);
            }
          },
        ),
      ),
    );
  }
}
