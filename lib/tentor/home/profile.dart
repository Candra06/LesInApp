import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideProfileTentor extends StatefulWidget {
  @override
  _SideProfileTentorState createState() => _SideProfileTentorState();
}

class _SideProfileTentorState extends State<SideProfileTentor> {
  String nama = '', email = '', username = '', telepon = '', tglLahir = '', gender = '', alamat;
  void getInfo() async {
    var tmpNama = await Config.getNama();
    var tmpEmail = await Config.getEmail();
    var tmpUsername = await Config.getUsername();
    var tmpTelepon = await Config.getTelepon();
    var tmpAlamat = await Config.getAlamat();
    var tmpTglLahir = await Config.getTanggalLahir();
    var tmpGender = await Config.getGender();
    setState(() {
      nama = tmpNama;
      email = tmpEmail;
      username = tmpUsername;
      telepon = tmpTelepon;
      tglLahir = tmpTglLahir;
      gender = tmpGender;
      alamat = tmpAlamat;
    });
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.pushNamed(context, Routes.LOGIN);
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          FadeAnimation(
            1.2,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: <Color>[Config.primary, Config.secondary, Config.darkPrimary])),
              //menampilkan detail profile akun
              child: Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(10, 38, 10, 8),
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(57.0),
                      child: Image.asset(
                        "assets/icons/graduate.png",
                        fit: BoxFit.fill,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      '$nama',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text(
                      '$username',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
              ]),
            ),
          ),
          FadeAnimation(
            1.4,
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: new Column(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Routes.EDIT_PROFIL, arguments: id.toString());
                  },
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Flexible(
                          child: Container(
                              child: Text(
                        'Nama',
                        style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                      ))),
                      new Flexible(
                          child: Container(
                              child: Text(
                        '$nama',
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
                    height: 35,
                    child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Flexible(
                          child: Container(
                              child: Text(
                        'Tanggal Lahir',
                        style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                      ))),
                      new Flexible(
                          child: Container(
                              child: Text(
                        Config.formattanggal(tglLahir),
                        textAlign: TextAlign.right,
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
                    child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Flexible(
                          child: Container(
                              child: Text(
                        'Jenis Kelamin',
                        style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                      ))),
                      new Flexible(
                          child: Container(
                              child: Text(
                        '$gender',
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
                    child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Flexible(
                          child: Container(
                              child: Text(
                        'Nomor HP',
                        style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                      ))),
                      new Flexible(
                          child: Container(
                              child: Text(
                        '$telepon',
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
                    child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Flexible(
                          child: Container(
                              child: Text(
                        'Username',
                        style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                      ))),
                      new Flexible(
                          child: Container(
                              child: Text(
                        '$username',
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
                    height: 35,
                    child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Flexible(
                          child: Container(
                              child: Text(
                        'Email',
                        style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                      ))),
                      new Flexible(
                          child: Container(
                              child: Text(
                        '$email',
                        textAlign: TextAlign.right,
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
                    height: 40,
                    child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Flexible(
                          child: Container(
                              child: Text(
                        'Alamat',
                        style: TextStyle(fontSize: 14, fontFamily: 'Airbnb', color: Config.textGrey),
                      ))),
                      new Flexible(
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '$alamat',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 14, fontFamily: 'AirbnbBold', color: Config.primary),
                              ))),
                    ]),
                  ),
                ),
              ]),
            ),
          ),
          FadeAnimation(
            1.6,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.EDIT_DATA_DIRI);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Card(
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: new Row(children: <Widget>[
                      new Flexible(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Ubah Data Diri',
                                  style: TextStyle(fontSize: 15, fontFamily: 'AirbnbBold', color: Config.primary),
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Ubah Data Diri',
                                  style: TextStyle(fontFamily: 'AirbnbReguler', color: Config.textGrey),
                                )),
                          ],
                        ),
                      )),
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
                            Navigator.pushNamed(context, Routes.EDIT_DATA_DIRI);
                          },
                        )),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.6,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.RIWAYAT_PENDIDIKAN);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Card(
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: new Row(children: <Widget>[
                      new Flexible(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Riwayat Pendidikan',
                                  style: TextStyle(fontSize: 15, fontFamily: 'AirbnbBold', color: Config.primary),
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Tambah data riwayat pendidikan',
                                  style: TextStyle(fontFamily: 'AirbnbReguler', color: Config.textGrey),
                                )),
                          ],
                        ),
                      )),
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
                            Navigator.pushNamed(context, Routes.RIWAYAT_PENDIDIKAN);
                          },
                        )),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.6,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.DATA_MENGAJAR);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Card(
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: new Row(children: <Widget>[
                      new Flexible(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Data Mengajar',
                                  style: TextStyle(fontSize: 15, fontFamily: 'AirbnbBold', color: Config.primary),
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Tambah dan hapus Data Mengajar',
                                  style: TextStyle(fontFamily: 'AirbnbReguler', color: Config.textGrey),
                                )),
                          ],
                        ),
                      )),
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
                            Navigator.pushNamed(context, Routes.DATA_MENGAJAR);
                          },
                        )),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.6,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.DATA_PRESTASI);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Card(
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: new Row(children: <Widget>[
                      new Flexible(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Data Prestasi',
                                  style: TextStyle(fontSize: 15, fontFamily: 'AirbnbBold', color: Config.primary),
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Tambah dan hapus Data Prestasi',
                                  style: TextStyle(fontFamily: 'AirbnbReguler', color: Config.textGrey),
                                )),
                          ],
                        ),
                      )),
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
                            Navigator.pushNamed(context, Routes.DATA_PRESTASI);
                          },
                        )),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.6,
            GestureDetector(
              onTap: () {
                logout();
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Card(
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: new Row(children: <Widget>[
                      new Flexible(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'LogOut',
                                  style: TextStyle(fontSize: 15, fontFamily: 'AirbnbBold', color: Config.primary),
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Keluar dari akun yang sedang aktif',
                                  style: TextStyle(fontFamily: 'AirbnbReguler', color: Config.textGrey),
                                )),
                          ],
                        ),
                      )),
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
                            Navigator.pushNamed(context, Routes.DATA_MENGAJAR);
                          },
                        )),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
