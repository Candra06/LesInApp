import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/hexColor.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isHidden = true, visible = true;
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();
  TextEditingController txUsername = new TextEditingController();
  TextEditingController txConfirm = new TextEditingController();

  TextEditingController cNama = new TextEditingController();
  TextEditingController cPassword = new TextEditingController();
  TextEditingController cTelepon = new TextEditingController();
  TextEditingController cgender = new TextEditingController();
  TextEditingController ctglLahir = new TextEditingController();
  TextEditingController calamat = new TextEditingController();
  DateTime tglLahir;
  List<DropdownMenuItem<String>> gender;
  String getGender = "";
  List listGender = [
    'Pilih Gender',
    'laki-laki',
    'perempuan',
  ];

  void changedDropDownItemGender(String selectedGender) {
    setState(() {
      getGender = selectedGender;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsGender() {
    List<DropdownMenuItem<String>> items = new List();

    for (String jjg in listGender) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  @override
  void initState() {
    gender = getDropDownMenuItemsGender();
    getGender = gender[0].value;
    super.initState();
  }

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

  void register() async {
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['nama'] = cNama.text;
    body['tgl_lahir'] = ctglLahir.text;
    body['telepon'] = cTelepon.text;
    body['alamat'] = calamat.text;
    body['gender'] = getGender.toString();
    body['username'] = txUsername.text;
    body['email'] = txEmail.text;
    body['password'] = txpassword.text;
    print(body);

    http.Response res = await http.post(Config.ipServerAPI + 'register', body: body);
    print(Config.ipServerAPI + 'register');
    print(res.body);
    if (res.statusCode == 200) {
      Navigator.pop(context);
      showAlertDialog(context, '1');
    } else {
      Navigator.pop(context);
      showAlertDialog(context, '2');
    }
  }

  showAlertDialog(BuildContext context, String paaram) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        if (paaram == '1') {
          Navigator.pushNamed(context, Routes.LOGIN, arguments: 0);
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
          ? 'Register Berhasil'
          : paaram == '2'
              ? 'Register Gagal'
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

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah Anda Yakin?'),
            content: new Text('Ingin Keluar Dari Aplikasi'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'Tidak',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text(
                  'Ya',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onWillPop();
      },
      child: Scaffold(
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
                        decoration: BoxDecoration(color: Config.secondary, borderRadius: BorderRadius.all(Radius.circular(displayWidth(context) * 0.5))),
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
                        decoration: BoxDecoration(color: Config.primary.withOpacity(0.7), borderRadius: BorderRadius.all(Radius.circular(displayWidth(context) * 0.5))),
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
                            'Daftar Siswa',
                            style: TextStyle(fontFamily: 'AirbnbBold', fontSize: 30, color: Config.primary),
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
                                    keyboardType: TextInputType.text,
                                    controller: cNama,
                                    decoration: InputDecoration(
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
                                    keyboardType: TextInputType.text,
                                    controller: calamat,
                                    decoration: InputDecoration(
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
                                    controller: ctglLahir,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.date_range),
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            currentDate: DateTime.now(),
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1970),
                                            lastDate: DateTime.now(),
                                          ).then((date) {
                                            tglLahir = date;
                                            String tanggal = tglLahir.toString().replaceAll("00:00:00.000", "");
                                            print(tanggal);
                                            print(Config.formattanggal(tanggal.toString()));
                                            ctglLahir.text = Config.formattanggal(tglLahir.toString().replaceAll("00:00:00.000", ""));
                                          });
                                        },
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
                                    keyboardType: TextInputType.phone,
                                    controller: cTelepon,
                                    decoration: InputDecoration(
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
                          width: displayWidth(context),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              child: DropdownButton(
                                underline: SizedBox(),
                                dropdownColor: Colors.white,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Config.textBlack,
                                ),
                                hint: Text(
                                  'Pilih Gender',
                                  style: TextStyle(color: Config.textGrey),
                                ),
                                items: gender,
                                onChanged: changedDropDownItemGender,
                                value: getGender,
                                style: TextStyle(color: Config.textBlack, fontFamily: 'Airbnb'),
                              ),
                            ),
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
                                    controller: txUsername,
                                    decoration: InputDecoration(
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
                                        icon: _isHidden ? Icon(Icons.visibility_off, color: Colors.black45) : Icon(Icons.visibility, color: Colors.black45),
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
                                        icon: visible ? Icon(Icons.visibility_off, color: Colors.black45) : Icon(Icons.visibility, color: Colors.black45),
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
                              } else if (txConfirm.text != txpassword.text) {
                                Config.alert(0, "Password tidak sesuai!");
                              } else if (txpassword.text.isEmpty) {
                                Config.alert(0, "Password tidak valid!");
                              } else if (getGender == '' || getGender == 'Pilih Gender') {
                                Config.alert(0, "Pilih Gender!");
                              } else if (txUsername.text.isEmpty) {
                                Config.alert(0, "Username tidak valid!");
                              } else if (cTelepon.text.isEmpty) {
                                Config.alert(0, "Telepon tidak valid!");
                              } else if (calamat.text.isEmpty) {
                                Config.alert(0, "Alamat tidak valid!");
                              } else if (cNama.text.isEmpty) {
                                Config.alert(0, "Nama tidak valid!");
                              } else {
                                register();
                              }
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'DAFTAR',
                              style: TextStyle(color: Colors.white, fontFamily: 'AirbnbBold', fontSize: 18, fontWeight: FontWeight.bold),
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
                            shape: RoundedRectangleBorder(side: BorderSide(color: Config.primary), borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(color: Config.primary, fontFamily: 'AirbnbBold', fontSize: 18, fontWeight: FontWeight.bold),
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
          )),
    );
  }
}
