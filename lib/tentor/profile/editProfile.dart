import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';

class EditProfileTentor extends StatefulWidget {
  @override
  _EditProfileTentorState createState() => _EditProfileTentorState();
}

class _EditProfileTentorState extends State<EditProfileTentor> {
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
            'Edit Profil',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: [
              FadeAnimation(
                0.6,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.EDIT_DATA_DIRI);
                  },
                  child: Card(
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: new Row(children: <Widget>[
                        new Container(
                            margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
                            child: new Icon(
                              Icons.perm_device_information,
                              color: Config.primary,
                              size: 25.0,
                            )),
                        new Flexible(
                            child: Container(
                                width: double.infinity,
                                child: Text(
                                  'Ubah Data Diri',
                                  style: TextStyle(fontSize: 14),
                                ))),
                        new ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 25,
                            maxWidth: 110,
                          ),
                          child: Container(
                              child: new IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black38,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.EDIT_DATA_DIRI);
                            },
                          )),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                0.8,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.RIWAYAT_PENDIDIKAN);
                  },
                  child: Card(
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: new Row(children: <Widget>[
                        new Container(
                            margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
                            child: new Icon(
                              Icons.auto_stories,
                              color: Config.primary,
                              size: 25.0,
                            )),
                        new Flexible(
                            child: Container(
                                width: double.infinity,
                                child: Text(
                                  'Riwayat Pendidikan',
                                  style: TextStyle(fontSize: 14),
                                ))),
                        new ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 25,
                            maxWidth: 110,
                          ),
                          child: Container(
                              child: new IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black38,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.RIWAYAT_PENDIDIKAN);
                            },
                          )),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                1.0,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.DATA_MENGAJAR);
                  },
                  child: Card(
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: new Row(children: <Widget>[
                        new Container(
                            margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
                            child: new Icon(
                              Icons.app_registration,
                              color: Config.primary,
                              size: 25.0,
                            )),
                        new Flexible(
                            child: Container(
                                width: double.infinity,
                                child: Text(
                                  'Data Mengajar',
                                  style: TextStyle(fontSize: 14),
                                ))),
                        new ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 25,
                            maxWidth: 110,
                          ),
                          child: Container(
                              child: new IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black38,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.DATA_MENGAJAR);
                            },
                          )),
                        ),
                      ]),
                    ),
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
