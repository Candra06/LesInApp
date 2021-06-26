import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/hexColor.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailTentor extends StatefulWidget {
  final Map<String, dynamic> param;
  DetailTentor({this.param});
  @override
  _DetailTentorState createState() => _DetailTentorState();
}

class _DetailTentorState extends State<DetailTentor> {
  String idTentor = '', idMapel = '';
  List pendidikan = new List();
  List prestasi = new List();
  List jadwal = new List();
  bool load = true;
  String token = '', nama = '', username = '', rating = '', alamat = '', telepon = '', hobi = '', email = '', tarif = '', motto = '';
  void getDetail() async {
    setState(() {
      load = true;
    });
    token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'getInfo/' + idTentor, headers: {'Authorization': 'Bearer $token'});

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        nama = data['data']['nama'];
        email = data['data']['email'];
        username = data['data']['username'];
        hobi = data['data']['hobi'];
        alamat = data['data']['alamat'];
        telepon = data['data']['telepon'];
        motto = data['data']['motto'];
        rating = data['data']['rating'];
        tarif = data['data']['tarif'].toString();
      });
    } else {}
  }

  void getPendidikan() async {
    setState(() {
      load = true;
    });
    token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'riwayatPendidikan/' + idTentor, headers: {'Authorization': 'Bearer $token'});

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        pendidikan = data['data'];
      });
    } else {}
  }

  void getPrestasi() async {
    setState(() {
      load = true;
    });
    token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'getPrestasi/' + idTentor, headers: {'Authorization': 'Bearer $token'});

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        prestasi = data['data'];
      });
    } else {}
  }

  void getJadwal() async {
    setState(() {
      load = true;
    });
    token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'jadwal/' + idTentor, headers: {'Authorization': 'Bearer $token'});

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        jadwal = data['data'];
      });
    } else {}
  }

  Widget itemPrestasi(a) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 5),
              Container(
                height: displayWidth(context) * 0.025,
                width: displayWidth(context) * 0.025,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        HexColor('0e5ed3'),
                        HexColor('097cd7'),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(displayWidth(context) * 0.025))),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prestasi[a]['penghargaan'],
                style: TextStyle(fontFamily: 'Airbnb'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemJadwal(a) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 5),
              Container(
                height: displayWidth(context) * 0.025,
                width: displayWidth(context) * 0.025,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        HexColor('0e5ed3'),
                        HexColor('097cd7'),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(displayWidth(context) * 0.025))),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jadwal[a],
                style: TextStyle(fontFamily: 'Airbnb'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemPendidikan(i) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      isFirst: i == 0 ? true : false,
      isLast: i == pendidikan.length - 1 ? true : false,
      beforeLineStyle: LineStyle(color: Config.primary, thickness: 2),
      indicatorStyle: IndicatorStyle(
        width: 15,
        height: 15,
        color: Config.primary,
        padding: EdgeInsets.only(right: 8),
      ),
      endChild: Container(
        padding: EdgeInsets.only(top: 10),
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pendidikan[i]['nama_sekolah'],
              style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textGrey),
            ),
            Text(
              pendidikan[i]['status_pendidikan'],
              style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getDetail();
    getPendidikan();
    getPrestasi();
    getJadwal();
    idTentor = widget.param['idTentor'];
    idMapel = widget.param['idMapel'];
    print(widget.param);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[Config.primary, Config.secondary, Config.darkPrimary])),
        ),
        title: Text(
          'Detail Tutor',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/icons/graduate.png')),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    constraints: BoxConstraints(minWidth: 80, maxWidth: 130),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(nama == '' ? 'Memuat' : '$nama', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textBlack, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text(username == '' ? 'Memuat' : username,
                              style: TextStyle(
                                fontFamily: 'AirbnbMedium',
                                color: Config.textGrey,
                                fontSize: 14,
                              )),
                        ),
                        Container(
                          child: Text(telepon == '' ? 'Memuat' : '$telepon',
                              style: TextStyle(
                                fontFamily: 'AirbnbMedium',
                                color: Config.textGrey,
                                fontSize: 14,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 70, maxWidth: 110),
                    alignment: Alignment.centerRight,
                    child: Text(
                      rating == '' ? '' : 'Rating : $rating/5',
                      style: TextStyle(color: Config.primary, fontFamily: 'Airbnb'),
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'Data Diri',
                  style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textBlack, fontSize: 18),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat',
                      style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textGrey),
                    ),
                    Text(
                      alamat == '' ? 'Memuat' : alamat,
                      style: TextStyle(fontFamily: 'Airbnb', color: Config.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hobi',
                      style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textGrey),
                    ),
                    Text(
                      hobi == '' ? 'Memuat' : hobi,
                      style: TextStyle(fontFamily: 'Airbnb', color: Config.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                width: displayWidth(context),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Motto',
                      style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textGrey),
                    ),
                    Text(
                      motto == '' ? 'Memuat' : motto,
                      style: TextStyle(fontFamily: 'Airbnb', color: Config.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tarif',
                      style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textGrey),
                    ),
                    Text(
                      tarif == '' ? 'Memuat' : 'Rp. ' + Config.formatuang(tarif),
                      style: TextStyle(fontFamily: 'Airbnb', color: Config.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'Riwayat Pendidikan',
                  style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textBlack, fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    for (var i = 0; i < pendidikan.length; i++) ...{itemPendidikan(i)}
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'Prestasi',
                  style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textBlack, fontSize: 18),
                ),
              ),
              for (var i = 0; i < prestasi.length; i++) ...{itemPrestasi(i)},
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'Jadwal Tersedia',
                  style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.textBlack, fontSize: 18),
                ),
              ),
              for (var i = 0; i < jadwal.length; i++) ...{itemJadwal(i)},
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  color: Config.primary,
                  onPressed: () {
                    var param = {
                      'mapel': idMapel,
                      'tentor': idTentor,
                    };
                    Navigator.pushNamed(context, Routes.PILIH_JADWAL, arguments: param);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Booking Tentor',
                    style: TextStyle(color: Colors.white, fontFamily: 'AirbnbBold', fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
