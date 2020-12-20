import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LupaSandi extends StatefulWidget {
  @override
  _LupaSandiState createState() => _LupaSandiState();
}

class _LupaSandiState extends State<LupaSandi> {
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txtUsername = new TextEditingController();
  String _role = '';

  void login() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['email'] = txEmail.text;
    body['username'] = txtUsername.text;

    http.Response res =
        await http.post(Config.ipServerAPI + 'requestPassword', body: body);

    var respon = json.decode(res.body);
    if (res.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, respon['data'].toString());
      Navigator.pushNamed(context, Routes.RESET_SANDI, arguments: respon['id'].toString());
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
          if (_role == 'siswa') {
            Navigator.pushNamed(context, Routes.HOME, arguments: 0.toString());
          } else {
            Navigator.pushNamed(context, Routes.HOME_TENTOR,
                arguments: 0.toString());
          }
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.LOGIN);
      },
      child: Scaffold(
        body: Stack(
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
                            margin: EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Lupa Password',
                              style: TextStyle(
                                  fontFamily: 'AirbnbBold',
                                  fontSize: 30,
                                  color: Config.primary),
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 8),
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
                                      controller: txtUsername,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.people_alt,
                                          color: Colors.black54,
                                        ),
                                        alignLabelWithHint: true,
                                        hintText: "Username",
                                        fillColor: Colors.black54,
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
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
                            child: RaisedButton(
                              padding: EdgeInsets.only(top: 13, bottom: 13),
                              color: Config.primary,
                              onPressed: () {
                                if (txEmail.text.isEmpty) {
                                  Config.alert(0, "Username tidak valid!");
                                } else if (txtUsername.text.isEmpty) {
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
