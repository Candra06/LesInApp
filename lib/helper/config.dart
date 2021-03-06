import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lesin_app/helper/hexColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Config {
  static final HexColor primary = new HexColor('#119ac6');
  static final HexColor secondary = new HexColor('#3076d1');
  static final HexColor darkPrimary = new HexColor('#3e32a2');
  static final HexColor textWhite = new HexColor('#ffffff');
  static final HexColor textAuth = new HexColor('#407a9d');
  static final HexColor textMerah = new HexColor('#e82b3f');
  static final HexColor textGrey = new HexColor('#b7b8bc');
  static final HexColor textBlack = new HexColor('#000000');
  static final HexColor boxGreen = new HexColor('#e7f9f2');
  static final HexColor boxRed = new HexColor('#fbedee');
  static final HexColor boxBlue = new HexColor('#eceff1');
  static final HexColor onprogres = new HexColor('#008EE5');
  static final HexColor closed = new HexColor('#B3B3B3');
  static final HexColor open = new HexColor('#00C45C');

  static final String ipServer = 'http://backoffice.belajardirumah.online/';
  static final String ipServerAPI = ipServer + 'api/';
  static final String ipAssets = '';

  static loading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              // backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  padding: EdgeInsets.all(18),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitCubeGrid(color: Config.primary, size: 50.0),
                      SizedBox(height: 30.0),
                      Text(
                        "Memuat Data",
                        style: TextStyle(fontSize: 18, fontFamily: 'Airbnb'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )));
        });
  }

  static alert(tipe, pesan) {
    Fluttertoast.showToast(
        msg: pesan,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: (tipe == 1 ? Colors.green : Colors.red),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static newloader(pesan) {
    return Center(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitCubeGrid(color: Config.primary, size: 50.0),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: new Text(
                pesan,
                style: new TextStyle(color: Colors.black54, fontSize: 16.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  static formattanggal(String tgl) {
    try {
      DateTime dt = DateTime.parse(tgl.toString());

      var bln = [
        '',
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ];
      var newDt = DateFormat.EEEE().format(dt);
      var bulan = tgl.toString().split('-');
      // print(newDt + ', ' + bln[int.parse(bulan[1])] + ' ' + bulan[0]);
      String tanggal = newDt + ', ' + bln[int.parse(bulan[1])] + ' ' + bulan[0];
      return tanggal;
    } catch (e) {
      // print('error' + e);
      return tgl.toString();
    }
  }

  static formatuang(amount) {
    try {
      final oCcy = new NumberFormat("#,##0", "id_ID");
      return oCcy.format(double.parse(amount)).toString();
    } catch (e) {
      return amount;
    }
  }

  static getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    return token;
  }

  static getNama() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String nama = preferences.getString('nama');
    return nama;
  }

  static getID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    return id;
  }

  static getIDAkun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idAkun = preferences.getString('id_akun');
    return idAkun;
  }

  static getGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String gender = preferences.getString('gender');
    return gender;
  }

  static getRating() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String rating = preferences.getString('rating');
    return rating;
  }

  static getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString('email');
    return email;
  }

  static getAlamat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String alamat = preferences.getString('alamat');
    return alamat;
  }

  static getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    return username;
  }

  static getHobi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String hobi = preferences.getString('hobi');
    return hobi;
  }

  static getMotto() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String motto = preferences.getString('motto');
    return motto;
  }

  static getTelepon() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String telepon = preferences.getString('telepon');
    return telepon;
  }

  static getTanggalLahir() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tglLahir = preferences.getString('tglLahir');
    return tglLahir;
  }

  static getRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String role = preferences.getString('role');
    return role;
  }

  static getLatitude() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String latitude = preferences.getString('latitude');
    return latitude;
  }

  static getLongitude() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String longitude = preferences.getString('longitude');
    return longitude;
  }
}
