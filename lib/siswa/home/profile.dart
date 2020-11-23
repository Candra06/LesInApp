import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/size.dart';

class SideProfile extends StatefulWidget {
  @override
  _SideProfileState createState() => _SideProfileState();
}

class _SideProfileState extends State<SideProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          FadeAnimation(1.2,
                     Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Config.primary,
                        Config.secondary,
                        Config.darkPrimary
                      ])),
              //menampilkan detail profile akun
              child: Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(10, 38, 10, 8),
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(57.0),
                      child: Image.asset(
                        "assets/images/user.png",
                        fit: BoxFit.fill,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'nama',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text(
                      'email',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
              ]),
            ),
          ),
          FadeAnimation(1.4, Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: new Column(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Nama',
                            style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                          ))),
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Febrina Karlina',
                            style: TextStyle(fontSize: 14, fontFamily: 'AirbnbBold', color: Config.primary),
                          ))),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Tanggal Lahir',
                            style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                          ))),
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Febrina Karlina',
                            style: TextStyle(fontSize: 14, fontFamily: 'AirbnbBold', color: Config.primary),
                          ))),
                        ]),
                  ),
                ),GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Jenis Kelamin',
                            style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                          ))),
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Febrina Karlina',
                            style: TextStyle(fontSize: 14, fontFamily: 'AirbnbBold', color: Config.primary),
                          ))),
                        ]),
                  ),
                ),GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Nomor HP',
                            style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                          ))),
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Febrina Karlina',
                            style: TextStyle(fontSize: 14, fontFamily: 'AirbnbBold', color: Config.primary),
                          ))),
                        ]),
                  ),
                ),GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Username',
                            style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                          ))),
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Febrina Karlina',
                            style: TextStyle(fontSize: 14, fontFamily: 'AirbnbBold', color: Config.primary),
                          ))),
                        ]),
                  ),
                ),GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Email',
                            style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                          ))),
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Febrina Karlina',
                            style: TextStyle(fontSize: 14, fontFamily: 'AirbnbBold', color: Config.primary),
                          ))),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Alamat',
                            style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                          ))),
                          new Flexible(
                              child: Container(
                                  child: Text(
                            'Febrina Karlina',
                            style: TextStyle(fontSize: 14, fontFamily: 'AirbnbBold', color: Config.primary),
                          ))),
                        ]),
                  ),
                ),
              ]),
            ),
          ),
          FadeAnimation(1.6, Container(
            child: Column(
              children: [
                Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(16, 4, 16, 8),
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            color: Config.primary,
                            onPressed: () {
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
                              'Ubah ',
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
                          margin: EdgeInsets.fromLTRB(16, 4, 16, 8),
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            color: Config.textWhite,
                            
                            onPressed: () {
                              // Navigator.pushNamed(context, Routes.REGISTER);
                            },
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Config.primary),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Config.primary,
                                  fontFamily: 'AirbnbBold',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
