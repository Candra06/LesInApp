import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';

class JadwalSide extends StatefulWidget {
  @override
  _JadwalSideState createState() => _JadwalSideState();
}

class _JadwalSideState extends State<JadwalSide> {
  Widget item(index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_KELAS, arguments: 0.toString());
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
                          image: AssetImage('assets/icons/graduate.png')),
                    )),
                Container(
                    constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Febri Karina',
                          // dataPenyakit[index]["nama_penyakit"],
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'AirbnbMedium'),
                        ),
                        Container(
                            child: Text(
                          '@febri',
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.textGrey),
                        )),
                        Container(
                            child: Text(
                          'Matematika',
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.primary),
                        )),
                      ],
                    )),
                Flexible(
                  child: Container(
                      child: Row(
                    children: <Widget>[
                      Text(
                        '3/5 Pertemuan',
                        style: TextStyle(
                            fontFamily: 'AirbnbMedium', color: Config.primary),
                      )
                    ],
                  )),
                )
              ],
            )),
      ),
    );
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
          'Jadwal',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int i) {
              return item(i);
            }),
      ),
    );
  }
}
