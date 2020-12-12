import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/siswa/kelas/dialogAbsensi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class ListModul extends StatefulWidget {
  final String idKelas;
  ListModul({this.idKelas});
  @override
  _ListModulState createState() => _ListModulState();
}

class _ListModulState extends State<ListModul> {
  String role = '';
  void info() async {
    var tmpRole = await Config.getRole();
    setState(() {
      role = tmpRole;
    });
  }

  List modul = new List();
  bool load = true;
  void getList() async {
    String token = await Config.getToken();
    String id = widget.idKelas;
    http.Response req = await http.get(Config.ipServerAPI + 'modul/$id',
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      print(data['data']);
      setState(() {
        load = false;
        modul = data['data'];
      });
    } else {
      Config.alert(0, 'Gagal memuat data');
    }
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (modul.isEmpty) {
      return Container(
        child: Center(
          child: Text(
            'Tidak ada modul',
            style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 18),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: modul.isEmpty ? 0 : modul.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                launch(Config.ipServer+modul[i]['file']);
              },
              child: Card(
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
                                  modul[i]['judul'],
                                  // dataPenyakit[index]["nama_penyakit"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'AirbnbMedium',
                                  ),
                                ),
                                Container(
                                    child: Text(
                                  'Materi : ' + modul[i]['materi'],
                                  style: TextStyle(
                                      fontFamily: 'Airbnb',
                                      color: Config.primary),
                                )),
                              ],
                            )),
                      ],
                    )),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    getList();
    info();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (role == 'siswa') {
          Navigator.pushNamed(context, Routes.DETAIL_KELAS,
              arguments: widget.idKelas);
        } else {
          Navigator.pushNamed(context, Routes.DETAIL_KELAS_TENTOR,
              arguments: widget.idKelas);
        }
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
            'Modul',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        floatingActionButton: role == 'tentor'
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.ADD_MODUL,
                      arguments: widget.idKelas);
                },
                child: Icon(Icons.add),
                backgroundColor: Config.primary,
              )
            : Container(),
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
