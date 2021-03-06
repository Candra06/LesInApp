import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfil extends StatefulWidget {
  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  bool _isHidden = true, visible = true;
  String token = '';
  TextEditingController txEmail = new TextEditingController();
  TextEditingController txpassword = new TextEditingController();
  TextEditingController txUsername = new TextEditingController();
  TextEditingController txConfirm = new TextEditingController();

  TextEditingController cNama = new TextEditingController();
  TextEditingController cTelepon = new TextEditingController();
  TextEditingController cgender = new TextEditingController();
  TextEditingController ctglLahir = new TextEditingController();
  TextEditingController calamat = new TextEditingController();
  DateTime tglLahir;

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
    setState(() {
      cNama.text = tmpNama;
      cTelepon.text = tmpTelepon;
      calamat.text = tmpAlamat;
      cgender.text = tmpGender;
      ctglLahir.text = tmpTglLahir;
      txUsername.text = tmpUsername;
      txEmail.text = tmpEmail;
      token = tmpToken;
      tanggal = tmpTglLahir;
      tglLahir = tmpTglLahir;
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
    http.Response up = await http.post(Config.ipServerAPI + 'updateUser',
        body: body, headers: {'Authorization': 'Bearer $token'});
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
      Navigator.pushNamed(context, Routes.HOME, arguments: '2');
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: [
              formInput(cNama, 'Nama'),
              formInput(cTelepon, 'Telepon'),
              formInput(txUsername, 'Username'),
              formInput(calamat, 'Alamat'),
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
                      style: TextStyle(
                          color: Config.textBlack, fontFamily: 'Airbnb'),
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

                                  ctglLahir.text = Config.formattanggal(tglLahir
                                      .toString()
                                      .replaceAll("00:00:00.000", ""));
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Simpan',
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
      ),
    );
  }
}
