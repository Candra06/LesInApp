import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KelasTentorSide extends StatefulWidget {
  @override
  _KelasTentorSideState createState() => _KelasTentorSideState();
}

class _KelasTentorSideState extends State<KelasTentorSide> {
  List kelas = new List();
  bool load = true;
  void getKelas() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    String id = await Config.getID();

    http.Response req = await http.get(Config.ipServerAPI + 'listKelas/$id',
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        kelas = data['data'];
        load = false;
      });
    } else {
      setState(() {
        kelas = [];
        load = false;
      });
      Config.alert(0, "Gagal memuat data");
    }
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (kelas == [] || kelas == null || kelas.length == 0) {
      return Center(
        child: Container(
          child: Text(
            'Anda tidak memiliki kelas',
            style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 16),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: kelas.length,
          itemBuilder: (BuildContext context, int i) {
            String pertemuan = kelas[i]['pertemuan'].toString();
            String jumlah = kelas[i]['jumlah_pertemuan'].toString();
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.DETAIL_KELAS,
                    arguments: kelas[i]['id'].toString());
              },
              child: Card(
                child: Container(
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Container(
                            width: 35.0,
                            height: 35.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/icons/graduate.png')),
                            )),
                        Container(
                            constraints:
                                BoxConstraints(minWidth: 150, maxWidth: 300),
                            margin: EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  kelas[i]['siswa'],
                                  // dataPenyakit[index]["nama_penyakit"],
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'AirbnbMedium'),
                                ),
                                Container(
                                    child: Text(
                                  kelas[i]['username'],
                                  style: TextStyle(
                                      fontFamily: 'Airbnb',
                                      color: Config.textGrey),
                                )),
                                Container(
                                    child: Text(
                                  kelas[i]['mapel'],
                                  style: TextStyle(
                                      fontFamily: 'Airbnb',
                                      color: Config.primary),
                                )),
                              ],
                            )),
                        Flexible(
                          child: Container(
                              child: Row(
                            children: <Widget>[
                              Text(
                                '$pertemuan/$jumlah Pertemuan',
                                style: TextStyle(
                                    fontFamily: 'AirbnbMedium',
                                    color: Config.primary),
                              )
                            ],
                          )),
                        )
                      ],
                    )),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    getKelas();
    print('tentor');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          'Kelas',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: item(),
      ),
    );
  }
}
