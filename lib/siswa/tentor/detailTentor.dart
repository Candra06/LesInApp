import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/hexColor.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailTentor extends StatefulWidget {
  final String idTentor;
  DetailTentor({this.idTentor});
  @override
  _DetailTentorState createState() => _DetailTentorState();
}

class _DetailTentorState extends State<DetailTentor> {
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
          'Detail Tentor',
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
                            width: 80.0,
                            height: 80.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/icons/graduate.png')),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text('Febi Karina',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.textBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: Text('Febi',
                              style: TextStyle(
                                fontFamily: 'AirbnbMedium',
                                color: Config.textGrey,
                                fontSize: 16,
                              )),
                        ),
                        Container(
                          child: Text('08983368286',
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
                      'Rating : 5/5',
                      style: TextStyle(
                          color: Config.primary, fontFamily: 'Airbnb'),
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'Data Diri',
                  style: TextStyle(
                      fontFamily: 'AirbnbMedium',
                      color: Config.textBlack,
                      fontSize: 18),
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
                      style: TextStyle(
                          fontFamily: 'AirbnbMedium', color: Config.textGrey),
                    ),
                    Text(
                      'Jl. Mastrip No.21 Poncogati Jember',
                      style: TextStyle(
                          fontFamily: 'Airbnb', color: Config.textGrey),
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
                      style: TextStyle(
                          fontFamily: 'AirbnbMedium', color: Config.textGrey),
                    ),
                    Text(
                      'Musik, Tari',
                      style: TextStyle(
                          fontFamily: 'Airbnb', color: Config.textGrey),
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
                      style: TextStyle(
                          fontFamily: 'AirbnbMedium', color: Config.textGrey),
                    ),
                    Text(
                      'If you want the power hold the technology',
                      style: TextStyle(
                          fontFamily: 'Airbnb', color: Config.textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'Riwayat Pendidikan',
                  style: TextStyle(
                      fontFamily: 'AirbnbMedium',
                      color: Config.textBlack,
                      fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      isFirst: true,
                      beforeLineStyle:
                          LineStyle(color: Config.primary, thickness: 2),
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
                              'SD Negeri Dabasah 4',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.textGrey),
                            ),
                            Text(
                              'Lulus',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      beforeLineStyle:
                          LineStyle(color: Config.primary, thickness: 2),
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
                              'SD Negeri Dabasah 4',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.textGrey),
                            ),
                            Text(
                              'Lulus',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      beforeLineStyle:
                          LineStyle(color: Config.primary, thickness: 2),
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
                              'SD Negeri Dabasah 4',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.textGrey),
                            ),
                            Text(
                              'Lulus',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TimelineTile(
                      alignment: TimelineAlign.start,
                      beforeLineStyle:
                          LineStyle(color: Config.primary, thickness: 2),
                      isLast: true,
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
                              'SD Negeri Dabasah 4',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.textGrey),
                            ),
                            Text(
                              'Lulus',
                              style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'Prestasi',
                  style: TextStyle(
                      fontFamily: 'AirbnbMedium',
                      color: Config.textBlack,
                      fontSize: 18),
                ),
              ),
              Container(
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
                              borderRadius: BorderRadius.all(Radius.circular(
                                  displayWidth(context) * 0.025))),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Juara 1 Lomba Fisika Tingkat Provinsi',
                          style: TextStyle(fontFamily: 'Airbnb'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
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
                              borderRadius: BorderRadius.all(Radius.circular(
                                  displayWidth(context) * 0.025))),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Juara 1 Lomba Fisika Tingkat Provinsi',
                          style: TextStyle(fontFamily: 'Airbnb'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  color: Config.primary,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.PILIH_JADWAL);
                    // if (txEmail.text.isEmpty) {
                    //   Config.alert(0, "Email tidak valid!");
                    // } else if (txpassword.text.isEmpty) {
                    //   Config.alert(0, "Password tidak valid!");
                    // } else {
                    // login();
                    // }
                    // Navigator.pushNamed(context, Routes.HOME,
                    //     arguments: 0.toString());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Booking Tentor',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'AirbnbBold',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
