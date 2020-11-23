import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: 'AirbnbBold',
                          fontSize: 35,
                          color: Config.primary),
                    ),
                  ),
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
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, Routes.LUPA_SANDI);
                              },
                              child: Text(
                                'Lupa Password?',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'AirBnb',
                                    color: Config.primary,
                                    fontSize: 15),
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
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
                              Navigator.pushNamed(context, Routes.HOME,
                                  arguments: 0.toString());
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'LOGIN',
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
                              Navigator.pushNamed(context, Routes.REGISTER);
                            },
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Config.primary),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'DAFTAR',
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
