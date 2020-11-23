import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';

class DetailKelas extends StatefulWidget {
  final String idKelas;
  DetailKelas({this.idKelas});
  @override
  _DetailKelasState createState() => _DetailKelasState();
}

class _DetailKelasState extends State<DetailKelas> {
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
          'Detail Kelas',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Status Kelas : AKTIF',
                    style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),
                    textAlign: TextAlign.right,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8,bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tentor',
                    style: TextStyle(fontFamily: 'AirbnbBold', color: Config.primary),
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
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
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
                          Text('Momor HP', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('089877645234', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
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
                          Text('Alamat', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 8,bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pertemuan',
                    style: TextStyle(fontFamily: 'AirbnbBold', color: Config.primary),
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
                          Text('Tarif', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
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
                          Text('Jumlah Pertemuan', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
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
                          Text('Jadwal', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
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
                          Text('Total Tarif', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 8,bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Info Kelas',
                    style: TextStyle(fontFamily: 'AirbnbBold', color: Config.primary),
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
                          Text('Jenjang ', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
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
                          Text('Kelas', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
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
                          Text('Mata Pelajaran', style: TextStyle(fontFamily: 'Airbnb'),),
                          Text('Nama Tentor', style: TextStyle(fontFamily: 'AirbnbMedium', color: Config.primary),),
                        ],
                      ),
                      Divider()
                    ],
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
                          arguments: 0.toString());
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Lihat Modul',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'AirbnbBold',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
