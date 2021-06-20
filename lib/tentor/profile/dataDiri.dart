import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataDiri extends StatefulWidget {
  @override
  _DataDiriState createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  bool _isHidden = true, visible = true, hide = true;
  String token = '';
  int rating = 0;
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();
  TextEditingController txUsername = new TextEditingController();
  TextEditingController txConfirm = new TextEditingController();
  TextEditingController txHobi = new TextEditingController();
  TextEditingController txMotto = new TextEditingController();

  TextEditingController cNama = new TextEditingController();
  TextEditingController cTelepon = new TextEditingController();
  TextEditingController cgender = new TextEditingController();
  TextEditingController ctglLahir = new TextEditingController();
  TextEditingController calamat = new TextEditingController();
  DateTime tglLahir;
  String _currentLatLong;
  var location = new Location();
  String myLat, myLong;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  getUserLocation() async {
    await Permission.location.request();
    var status = await Permission.location.status;
    var latitude, longitude;
    if (status.isGranted) {
      Location location = new Location();
      LocationData myLocation;
      String error;
      try {
        myLocation = await location.getLocation();
        _currentLatLong = myLocation.latitude.toString() + ', ' + myLocation.longitude.toString();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          Config.alert(0, error);
          // print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          Config.alert(0, error);
          // print(error);
        }
        myLocation = null;
      }
      setState(() {
        var lokasi = _currentLatLong.split(",");
        latitude = double.parse(lokasi[0]);
        longitude = double.parse(lokasi[1]);
      });
    } else {
      Config.alert(0, 'Gagal mendapatkan lokasi');
    }
    myLat = latitude.toString();
    myLong = longitude.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('latitude', myLat);
    await pref.setString('longitude', myLong);
  }

  List<DropdownMenuItem<String>> gender;
  String getGender = "", tanggal;
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

  void getInfo() async {
    var tmpNama = await Config.getNama();
    var tmpUsername = await Config.getUsername();
    var tmpTelepon = await Config.getTelepon();
    var tmpAlamat = await Config.getAlamat();
    var tmpGender = await Config.getGender();
    var tmpTglLahir = await Config.getTanggalLahir();
    var tmpEmail = await Config.getEmail();
    var tmpToken = await Config.getToken();
    var tmpHobi = await Config.getHobi();
    var tmpMotto = await Config.getMotto();
    var tmpRating = await Config.getRating();
    setState(() {
      cNama.text = tmpNama;
      cTelepon.text = tmpTelepon;
      calamat.text = tmpAlamat;
      cgender.text = tmpGender;
      ctglLahir.text = tmpTglLahir;
      txUsername.text = tmpUsername;
      txEmail.text = tmpEmail;
      token = tmpToken;
      double rate = double.parse(tmpRating.toString());
      rating = rate.round();

      tanggal = tmpTglLahir.toString();
      ctglLahir.text = Config.formattanggal(tmpTglLahir);
      // tglLahir = DateTime.parse(tmpTglLahir.toString());
      txMotto.text = tmpMotto;
      txHobi.text = tmpHobi;
    });
  }

  void updateProfil() async {
    Config.loading(context);
    var body = Map<String, dynamic>();
    tanggal = tglLahir.toString().replaceAll("00:00:00.000", "");
    body['nama'] = cNama.text;
    body['email'] = txEmail.text;
    body['password'] = txpassword.text;
    body['telepon'] = cTelepon.text;
    body['username'] = txUsername.text;
    body['gender'] = getGender;
    body['tgl_lahir'] = tanggal;
    body['alamat'] = calamat.text;
    body['hobi'] = txHobi.text;
    body['motto'] = txMotto.text;
    body['lattitude'] = myLat;
    body['longitude'] = myLong;
    print(body);
    http.Response up = await http.post(Config.ipServerAPI + 'updateUser', body: body, headers: {'Authorization': 'Bearer $token'});
    if (up.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, 'Berhasil mengubah profil');
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('nama', cNama.text);
      await pref.setString('email', txEmail.text);
      await pref.setString('username', txUsername.text);
      await pref.setString('telepon', cTelepon.text);
      await pref.setString('gender', getGender);
      await pref.setString('tglLahir', tanggal);
      await pref.setString('alamat', calamat.text);
      await pref.setString('hobi', txHobi.text);
      await pref.setString('motto', txMotto.text);
      Navigator.pushNamed(context, Routes.HOME_TENTOR, arguments: '2');
    } else {
      Navigator.pop(context);
      Config.alert(0, 'Gagal mengubah profil');
      print(up.body);
    }
  }

  @override
  void initState() {
    gender = getDropDownMenuItemsGender();
    getGender = gender[0].value;
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[Config.primary, Config.secondary, Config.darkPrimary])),
        ),
        title: Text(
          'Edit Profil',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Rating : ',
                    style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 16, color: Config.primary),
                  ),
                  if (rating == 0) ...{
                    Icon(
                      Icons.star,
                      color: Colors.yellow[800],
                    ),
                    Text(
                      '0',
                      style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 16, color: Config.primary),
                    ),
                  } else ...{
                    for (var i = 0; i < rating; i++) ...{
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                    }
                  }
                ],
              ),
              formInput(cNama, 'Nama'),
              formInput(cTelepon, 'Telepon'),
              formInput(txUsername, 'Username'),
              formInput(calamat, 'Alamat'),
              formInput(txHobi, 'Hobi'),
              formInput(txMotto, 'Motto'),
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
              formInput(txEmail, 'Email'),
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
              Text('Pastikan anda berada pada lokasi anda tinggal saat ini untuk mendapatkan kordinat lokasi anda saat ini.'),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  color: Config.primary,
                  onPressed: () {
                    getUserLocation();
                    if (myLat == '' || myLong == '') {
                      setState(() {
                        hide = true;
                      });
                    } else {
                      setState(() {
                        hide = false;
                        Config.alert(1, 'Lokasi berhasil didapatkan');
                        print(myLat);
                        print(myLong);
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Dapatkan Lokasi',
                    style: TextStyle(color: Colors.white, fontFamily: 'AirbnbBold', fontSize: 18, fontWeight: FontWeight.bold),
                  ),
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
                      updateProfil();
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white, fontFamily: 'AirbnbBold', fontSize: 18, fontWeight: FontWeight.bold),
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
