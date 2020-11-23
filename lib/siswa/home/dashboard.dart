import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget item(index) {
    return Card(
      child: Container(
          margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tes',
                    // dataPenyakit[index]["nama_penyakit"],
                    style: TextStyle(fontSize: 16, fontFamily: 'AirbnbMedium'),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        'tes',
                        style: TextStyle(
                            fontFamily: 'Airbnb', color: Config.primary),
                      )),
                ],
              )),
              Container(
                  child: Row(
                children: <Widget>[
                  Text(
                    '3/5',
                    style: TextStyle(
                        fontFamily: 'AirbnbMedium', color: Config.primary),
                  )
                ],
              ))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FadeAnimation(
              1.4,
              new Container(
                height: 225,
                child: Stack(
                  children: <Widget>[
                    FadeAnimation(
                      1.2,
                      new Container(
                        width: displayWidth(context),
                        padding: EdgeInsets.only(right: 16, left: 16, top: 38),
                        height: 225,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(35),
                                bottomRight: Radius.circular(35)),
                            gradient: new LinearGradient(
                              colors: <Color>[
                                Config.primary,
                                Config.secondary,
                                Config.darkPrimary
                              ],
                              end: Alignment(1.5, 0.0),
                            )),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              "Halo, Kak Febi".toUpperCase(),
                              style: new TextStyle(
                                fontFamily: 'AirbnbBold',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            new Text(
                              'Selamat datang di Les.in'.toUpperCase(),
                              style: new TextStyle(
                                fontFamily: 'AirbnbBold',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 30,
                        right: 10,
                        child: FadeAnimation(
                          1.2,
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              size: 30,
                              color: Config.textWhite,
                            ),
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: new Container(
                            width: displayWidth(context),
                            margin: EdgeInsets.only(right: 16, left: 16),
                            height: 150,
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            width: 90.0,
                                            height: 90.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      'assets/icons/graduate.png')),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text('Febi Karina',
                                              style: TextStyle(
                                                  fontFamily: 'AirbnbMedium',
                                                  color: Config.textWhite,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Container(
                                          child: Text('Febi',
                                              style: TextStyle(
                                                  fontFamily: 'AirbnbMedium',
                                                  color: Config.textWhite,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            FadeAnimation(
              1.5,
              new Container(
                  width: displayWidth(context),
                  margin: EdgeInsets.only(right: 16, left: 16, top: 16),
                  height: 100,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: 30,
                                      child:
                                          Image.asset('assets/icons/chat.png')),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text('Chat',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontFamily: 'AirbnbMedium')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: 30,
                                      child: Image.asset(
                                          'assets/icons/credit-card.png')),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text('Pembayaran',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontFamily: 'AirbnbMedium')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.BOOKING_KELAS);
                            },
                            child: Card(
                              elevation: 3,
                              child: Container(
                                width: 50,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: 30,
                                        child: Image.asset(
                                            'assets/icons/booking.png')),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 55,
                                      margin: EdgeInsets.only(top: 8),
                                      child: Text('Booking Kelas',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black45,
                                              fontFamily: 'AirbnbMedium')),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            FadeAnimation(
              1.6,
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(
                  'Jadwal hari ini',
                  style: TextStyle(fontFamily: 'AirbnbMedium'),
                ),
              ),
            ),
            FadeAnimation(
              1.7,
              Container(
                constraints: BoxConstraints(minHeight: 300, maxHeight: 600),
                margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: ListView.separated(
                    separatorBuilder: (context, int i) {
                      return Container(
                        color: Config.textWhite,
                        width: displayWidth(context),
                        height: 1,
                      );
                    },
                    itemCount: 3,
                    itemBuilder: (context, int i) {
                      return item(1);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
