import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'package:lesin_app/helper/routes.dart';
import 'dart:convert';

import 'package:lesin_app/tentor/profile/addPendidikan.dart';

class RiwayatPendidikan extends StatefulWidget {
  @override
  _RiwayatPendidikanState createState() => _RiwayatPendidikanState();
}

class _RiwayatPendidikanState extends State<RiwayatPendidikan> {
  List riwayat = new List();
  bool load = true;
  void getData() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    String id = await Config.getID();
    http.Response req = await http.get(
        Config.ipServerAPI + 'riwayatPendidikan/$id',
        headers: {'Authorization': 'Bearer $token'});
    print(req.body);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        riwayat = data['data'];
        load = false;
      });
    } else {
      setState(() {
        load = false;
        Config.alert(0, 'Gagal memuat data');
      });
    }
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (riwayat.isEmpty) {
      return Center(
        child: Container(
          child: Text(
            'Tidak ada data riwayat pendidikan.',
            style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 16),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: riwayat.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(riwayat[i]['nama_sekolah'], style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
                      Text(riwayat[i]['jenjang_pendidikan']+' - '+riwayat[i]['status_pendidikan'], style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textBlack),),
                      Text(riwayat[i]['tahun_lulus'], style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textGrey),),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.HOME_TENTOR, arguments: '2');
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
            'Riwayat Pendidikan',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Config.primary,
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return new DialogAddPendidikan();
                },
                fullscreenDialog: true));
          },
          child: Icon(
            Icons.add,
            color: Config.textWhite,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(
                    'Tambahkan data riwayat pendidikan anda dengan menekan tombol tambah',
                    style: TextStyle(fontFamily: 'Airbnb'),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minHeight: 300,maxHeight: 450),
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: item(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
