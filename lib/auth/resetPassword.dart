import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPassword extends StatefulWidget {
  final String idUser;
  ResetPassword({this.idUser});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isHidden = true, visible = true;
  TextEditingController txpassword = new TextEditingController();
  TextEditingController txConfirm = new TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _toggleVisibility2() {
    setState(() {
      visible = !visible;
    });
  }

  void login() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['password'] = txConfirm.text;
    body['id'] = widget.idUser.toString();

    http.Response res =
        await http.post(Config.ipServerAPI + 'resetPassword', body: body);

    var respon = json.decode(res.body);
    if (res.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, respon['data'].toString());
      Navigator.pushNamed(context, Routes.LOGIN);
    } else if (res.statusCode == 401) {
      Navigator.pop(context);
      Config.alert(0, respon['error'].toString());
    }
  }

  showAlertDialog(BuildContext context, String paaram) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        if (paaram == '1') {
        } else {
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(paaram == '1'
          ? 'Berhasil'
          : paaram == '2'
              ? 'Gagal'
              : 'Error'),
      content: Text(paaram == '1'
          ? 'Login Berhasil'
          : paaram == '2'
              ? 'Username dan Password salah'
              : 'Server Error'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    print('object'+widget.idUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamed(context, Routes.LUPA_SANDI);
        },
        child: Scaffold(
            body: Stack(children: [
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

          Positioned(
              //bulet pojok kanan
              bottom: -(displayWidth(context) * 0.45),
              right: -(displayWidth(context) * 0.35),
              child: FadeAnimation(
                0.1,
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
              // bulet pojok kanan 2
              bottom: (displayWidth(context) * 0.09),
              right: -(displayWidth(context) * 0.1),
              child: FadeAnimation(
                0.2,
                Container(
                  height: displayWidth(context) * 0.3,
                  width: displayWidth(context) * 0.3,
                  decoration: BoxDecoration(
                      color: Config.primary.withOpacity(0.7),
                      borderRadius: BorderRadius.all(
                          Radius.circular(displayWidth(context) * 0.5))),
                ),
              )),

          Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 100,
                          maxHeight: 300,
                        ),
                        // color: Colors.transparent,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 16, bottom: 16),
                              child: Text(
                                'Buat Password Baru',
                                style: TextStyle(
                                    fontFamily: 'AirbnbBold',
                                    fontSize: 30,
                                    color: Config.primary),
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
                                        obscureText: visible,
                                        controller: txConfirm,
                                        decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          hintText: "Konfirmasi Password",
                                          fillColor: Colors.black54,
                                          hintStyle: TextStyle(
                                              // color: Config.textWhite,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16),
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            onPressed: _toggleVisibility2,
                                            icon: visible
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
                                  if (txpassword.text.isEmpty) {
                                    Config.alert(0, "Username tidak valid!");
                                  } else if (txConfirm.text !=
                                      txpassword.text) {
                                    Config.alert(0, "Password tidak valid!");
                                  } else {
                                    login();
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Reset Password'.toUpperCase(),
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
                    ]),
              ))
        ])));
  }
}
