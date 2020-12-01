import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lesin_app/helper/size.dart';
import 'package:lesin_app/siswa/pembayaran/dialogTransfer.dart';

class DetailKelas extends StatefulWidget {
  final String idKelas;
  DetailKelas({this.idKelas});
  @override
  _DetailKelasState createState() => _DetailKelasState();
}

class _DetailKelasState extends State<DetailKelas> {
  String status = '',
      tentor = '',
      hpTentor = '',
      alamatTentor = '',
      tarif = '',
      pertemuan = '',
      total = '',
      hari = '',
      ttlTarif = '',
      jenjang = '',
      kelas = '',
      mapel = '',
      token = '';
  bool load = true;

  void getDetail() async {
    setState(() {
      load = true;
    });
    token = await Config.getToken();
    String id = widget.idKelas;

    http.Response res = await http.get(Config.ipServerAPI + 'kelasSiswa/$id',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var mentor = data['data']['mentor'];
      var dataPertemuan = data['data']['pertemuan'];
      var dataKelas = data['data']['dataKelas'];
      var jmlPertemuan = dataPertemuan['jumlah_pertemuan'];
      var totalTarif = dataPertemuan['tarif'];
      setState(() {
        load = false;
        tentor = mentor['nama'];
        hpTentor = mentor['telepon'];
        alamatTentor = mentor['alamat'];

        hari = dataPertemuan['hari'];
        tarif = totalTarif.toString();
        pertemuan = dataPertemuan['pertemuan'].toString();
        ttlTarif = totalTarif.toString();
        total = jmlPertemuan.toString();

        mapel = dataKelas['mapel'];
        jenjang = dataKelas['mapel'];
        kelas = dataKelas['kelas'];
        status = dataKelas['status'];
      });
    } else {
      Config.alert(0, 'Gagal memuat data');
    }
  }

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.HOME, arguments: '1');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.payment,
                  color: Config.textWhite,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.LOG_PEMBAYARAN,
                      arguments: widget.idKelas);
                })
          ],
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
            'Detail Kelas',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        body: SingleChildScrollView(
          child: load == true
              ? Container(
                  height: displayHeight(context),
                  child: Center(
                    child: Container(
                      child: Config.newloader('Memuat data'),
                    ),
                  ))
              : Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Status Kelas : $status',
                          style: TextStyle(
                              fontFamily: 'AirbnbMedium',
                              color: Config.primary),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tentor',
                          style: TextStyle(
                              fontFamily: 'AirbnbBold', color: Config.primary),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Tentor',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$tentor',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Momor HP',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$hpTentor',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        constraints:
                            BoxConstraints(minHeight: 10, maxHeight: 36),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Alamat',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$alamatTentor',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pertemuan',
                          style: TextStyle(
                              fontFamily: 'AirbnbBold', color: Config.primary),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tarif',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$tarif',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Jumlah Pertemuan',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$pertemuan / $total',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Jadwal',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$hari',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Tarif',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$ttlTarif',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Info Kelas',
                          style: TextStyle(
                              fontFamily: 'AirbnbBold', color: Config.primary),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Jenjang ',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$jenjang',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Kelas',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$kelas',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Mata Pelajaran',
                                  style: TextStyle(fontFamily: 'Airbnb'),
                                ),
                                Text(
                                  '$mapel',
                                  style: TextStyle(
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                      if (status == 'Pending') ...{
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Config.primary),
                          child: Text(
                            'Silahkan melakukan pembayaran minimal 50% sebelum kelas dimulai dan unggah bukti pembayaran untuk mengaktifkan status kelas.',
                            style: TextStyle(
                                fontFamily: 'Airbnb', color: Config.textWhite),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            color: Config.primary,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DialogTransfer(
                                        idKelas: widget.idKelas,
                                        harga: tarif,
                                      ));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Transfer',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'AirbnbBold',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      } else ...{
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            color: Config.primary,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DialogTransfer(
                                        idKelas: widget.idKelas,
                                        harga: tarif,
                                      ));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Transfer',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'AirbnbBold',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            color: Config.primary,
                            onPressed: () {
                              // Navigator.pushNamed(context, Routes.HOMEPAGE,
                              //     arguments: 0.toString());
                              Navigator.pushNamed(context, Routes.ABSENSI,
                                  arguments: widget.idKelas);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Absensi',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'AirbnbBold',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      }
                    ],
                  )),
        ),
      ),
    );
  }
}
