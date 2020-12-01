import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/siswa/kelas/dialogAbsensi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AbsensiPage extends StatefulWidget {
  final String idKelas;
  AbsensiPage({this.idKelas});
  @override
  _AbsensiPageState createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  List absensi = new List();
  bool load = true;
  void getList() async {
    String token = await Config.getToken();
    String id = widget.idKelas;
    http.Response req = await http.get(Config.ipServerAPI + 'absensi/$id',
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      print(data['data']);
      setState(() {
        load = false;
        absensi = data['data'];
      });
    } else {
      Config.alert(0, 'Gagal memuat data');
    }
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (absensi.isEmpty) {
      return Container(
        child: Center(
          child: Text(
            'Tidak ada absensi',
            style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 18),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: absensi.isEmpty ? 0 : absensi.length,
          itemBuilder: (BuildContext context, int i) {
            
            return Card(
              child: Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Config.formattanggal(absensi[i]['created_at']),
                                // dataPenyakit[index]["nama_penyakit"],
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'AirbnbMedium'),
                              ),
                              Container(
                                  child: Text(
                                absensi[i]['jam'],
                                style: TextStyle(
                                    fontFamily: 'Airbnb',
                                    color: Config.textGrey),
                              )),
                              Container(
                                  child: Text(
                                'Jurnal : '+absensi[i]['jurnal'],
                                style: TextStyle(
                                    fontFamily: 'Airbnb',
                                    color: Config.primary),
                              )),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Config.secondary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          absensi[i]['kehadiran'],
                          style: TextStyle(
                              fontFamily: 'AirbnbMedium',
                              fontSize: 13,
                              color: Config.textWhite),
                        ),
                      )
                    ],
                  )),
            );
          });
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.DETAIL_KELAS,
            arguments: widget.idKelas);
      },
      child: Scaffold(
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
            'Absensi dan Jurnal',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => DialogAbsensi(
                      idKelas: widget.idKelas,
                    ));
          },
          child: Icon(Icons.add),
          backgroundColor: Config.primary,
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: FadeAnimation(
              0.2,
              item(),
            )),
      ),
    );
  }
}
