import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/hexColor.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isHidden = true;
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();

  TextEditingController cNama = new TextEditingController();
  TextEditingController cEmail = new TextEditingController();
  TextEditingController cPassword = new TextEditingController();
  TextEditingController cTelepon = new TextEditingController();
  TextEditingController cwa = new TextEditingController();
  TextEditingController cgender = new TextEditingController();
  TextEditingController ctglLahir = new TextEditingController();
  TextEditingController calamat = new TextEditingController();

  String _valGender;
  List _sdGender = [
    "laki-laki",
    "perempuan",
  ];
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('ffffff'),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Bulet bulet
              Positioned(
                  //bulet pojok kiri
                  top: -(displayWidth(context) * 0.18),
                  left: -(displayWidth(context) * 0.3),
                  child: FadeAnimation(
                    0.5,
                    Container(
                      height: displayWidth(context) * 0.69,
                      width: displayWidth(context) * 0.69,
                      decoration: BoxDecoration(
                          color: Config.secondary,
                          borderRadius: BorderRadius.all(
                              Radius.circular(displayWidth(context) * 0.5))),
                    ),
                  )),

              Positioned(
                  // bulet pojok kiri 2
                  top: -(displayWidth(context) * 0.1),
                  left: (displayWidth(context) * 0.1),
                  child: FadeAnimation(
                    0.6,
                    Container(
                      height: displayWidth(context) * 0.45,
                      width: displayWidth(context) * 0.45,
                      decoration: BoxDecoration(
                          color: Config.primary.withOpacity(0.7),
                          borderRadius: BorderRadius.all(
                              Radius.circular(displayWidth(context) * 0.5))),
                    ),
                  )),

              Container(
                padding: EdgeInsets.only(
                  top: displayHeight(context) * 0.04,
                  left: displayWidth(context) * 0.08,
                  right: displayWidth(context) * 0.08,
                  bottom: displayHeight(context) * 0.225,
                ),
                margin: EdgeInsets.only(top: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      Container(
                        margin: EdgeInsets.only(top: 72),
                        child: Text(
                          'Daftar',
                          style: TextStyle(
                              fontFamily: 'AirbnbBold',
                              fontSize: 35,
                              color: Config.primary),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: txEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.account_box,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: "Nama",
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: txEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person_pin_circle,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: "Alamat",
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: txEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: "Tanggal Lahir",
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: txEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: "Nomor HP",
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: txEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.switch_account,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: "Gender",
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: txEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email_sharp,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: txEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.account_circle_rounded,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black54,
                                    hintText: "Username",
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: _isHidden,
                                  controller: txpassword,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: "Password",
                                    fillColor: Colors.black54,
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: _toggleVisibility,
                                      icon: _isHidden
                                          ? Icon(Icons.visibility_off,
                                              color: Colors.black45)
                                          : Icon(Icons.visibility,
                                              color: Colors.black45),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                  style: TextStyle(color: Colors.black54),
                                  obscureText: _isHidden,
                                  controller: txpassword,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black54,
                                    ),
                                    alignLabelWithHint: true,
                                    hintText: "Password",
                                    fillColor: Colors.black54,
                                    hintStyle: TextStyle(
                                        // color: Config.textWhite,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: _toggleVisibility,
                                      icon: _isHidden
                                          ? Icon(Icons.visibility_off,
                                              color: Colors.black45)
                                          : Icon(Icons.visibility,
                                              color: Colors.black45),
                                    ),
                                  )),
                            )
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
                            if (txEmail.text.isEmpty) {
                              Config.alert(0, "Email tidak valid!");
                            } else if (txpassword.text.isEmpty) {
                              Config.alert(0, "Password tidak valid!");
                            } else {
                              // login();
                            }
                            // Navigator.pushNamed(context, Routes.HOMEPAGE,
                            //     arguments: 0.toString());
                            // Navigator.pushNamed(context, Routes.HOME,
                            //     arguments: 0.toString());
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'DAFTAR',
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
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          color: Config.textWhite,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.LOGIN);
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Config.primary),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Config.primary,
                                fontFamily: 'AirbnbBold',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: displayWidth(context) * 0.05),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
