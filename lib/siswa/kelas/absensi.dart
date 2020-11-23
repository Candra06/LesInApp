import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';

class AbsensiPage extends StatefulWidget {
  final String idKelas;
  AbsensiPage({this.idKelas});
  @override
  _AbsensiPageState createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  Widget item(index) {
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
                        'Selasa, 23 November 2020',
                        // dataPenyakit[index]["nama_penyakit"],
                        style:
                            TextStyle(fontSize: 14, fontFamily: 'AirbnbMedium'),
                      ),
                      Container(
                          child: Text(
                        '15.00',
                        style: TextStyle(
                            fontFamily: 'Airbnb', color: Config.textGrey),
                      )),
                      Container(
                          child: Text(
                        'Jurnal : Aljabar Komputasi',
                        style: TextStyle(
                            fontFamily: 'Airbnb', color: Config.primary),
                      )),
                    ],
                  )),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Config.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Text('Tidak Hadir', style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 13,color: Config.textWhite),),
                  )
            ],
          )),
    );
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
          'Absensi dan Jurnal',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: FadeAnimation(
            0.2,
            ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int i) {
                  return item(i);
                }),
          )),
    );
  }
}
