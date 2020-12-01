import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingKelasPage extends StatefulWidget {
  @override
  _BookingKelasPageState createState() => _BookingKelasPageState();
}

class _BookingKelasPageState extends State<BookingKelasPage> {
  String token = '';
  List<DropdownMenuItem<String>> jenjang;
  List<DropdownMenuItem<String>> kelas;
  List<DropdownMenuItem<String>> mapel;
  String getKelas = "";
  String getJenjang = "";
  String getMapel = "";
  List listJenjang = ['Pilih Jenjang', 'SD', 'SMP', 'SMA'];
  List listKelas = ['Pilih Kelas'];
  List listMapel = [
    'Pilih Mapel',
    'Bahasa Indonesia',
    'Bahasa Inggris',
    'Matematika',
    'IPA'
  ];

  void changedDropDownItemJenjang(String selectedJenjang) {
    setState(() {
      getJenjang = selectedJenjang;
      print(getJenjang);
      if (selectedJenjang == 'SD') {
        List tmpKelas = ['Pilih Kelas', '1', '2', '3', '4', '5', '6'];
        listKelas = [];
        for (var i = 0; i < tmpKelas.length; i++) {
          listKelas.add(tmpKelas[i]);
        }
        print(listKelas);
      } else if (selectedJenjang == 'SMP') {
        List tmpKelas = ['Pilih Kelas', '7', '8', '9'];
        listKelas = [];
        for (var i = 0; i < tmpKelas.length; i++) {
          listKelas.add(tmpKelas[i]);
        }
        print(listKelas);
      } else if (selectedJenjang == 'SMA') {
        List tmpKelas = ['Pilih Kelas', '10', '11', '12'];
        listKelas = [];
        for (var i = 0; i < tmpKelas.length; i++) {
          listKelas.add(tmpKelas[i]);
        }
        print(listKelas);
      } else {
        listKelas = ['Pilih Kelas'];
      }
      kelas = getDropDownMenuItemsKelas();
      getKelas = kelas[0].value;
    });
  }

  void getDataKelas() async {
    Config.loading(context);
    token = await Config.getToken();
    String kls = getKelas.toString();
    String mpl = getMapel.toString();
    http.Response res = await http.get(Config.ipServerAPI + 'mapelBy/$kls/$mpl',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      Navigator.pop(context);
      if (data['data'] == null || data['data'] == '') {
        showAlertDialog(context, '2');
      } else {
        Navigator.pushNamed(context, Routes.LIST_TENTOR,
            arguments: data['data']['id'].toString());
      }
    } else {
      Navigator.pop(context);
      showAlertDialog(context, '3');
    }
  }

  showAlertDialog(BuildContext context, String paaram) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        if (paaram == '1') {
          Navigator.pushNamed(context, Routes.HOME, arguments: 0.toString());
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
              ? 'Mapel tidak ditemukan'
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

  List<DropdownMenuItem<String>> getDropDownMenuItemsJenjang() {
    List<DropdownMenuItem<String>> items = new List();
    for (String jjg in listJenjang) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  void changedDropDownItemKelas(String selectedKelas) {
    setState(() {
      getKelas = selectedKelas;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsKelas() {
    List<DropdownMenuItem<String>> items = new List();

    for (String jjg in listKelas) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  void changedDropDownItemMapel(String selectedMapel) {
    setState(() {
      getMapel = selectedMapel;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsMapel() {
    List<DropdownMenuItem<String>> items = new List();
    for (String jjg in listMapel) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  @override
  void initState() {
    jenjang = getDropDownMenuItemsJenjang();
    getJenjang = jenjang[0].value;

    mapel = getDropDownMenuItemsMapel();
    getMapel = mapel[0].value;
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
          'Booking Kelas',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: [
                Text(
                  'Silahkan isi data informasi kelas , lalu temukan tentor disekitar anda',
                  style: TextStyle(fontFamily: 'Airbnb'),
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
                          'Pilih Jenjang',
                          style: TextStyle(color: Config.textGrey),
                        ),
                        items: jenjang,
                        onChanged: changedDropDownItemJenjang,
                        value: getJenjang,
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
                          'Pilih Kelas',
                          style: TextStyle(color: Config.textGrey),
                        ),
                        items: kelas,
                        onChanged: changedDropDownItemKelas,
                        value: getKelas,
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
                          'Pilih Mapel',
                          style: TextStyle(color: Config.textGrey),
                        ),
                        items: mapel,
                        onChanged: changedDropDownItemMapel,
                        value: getMapel,
                        style: TextStyle(
                            color: Config.textBlack, fontFamily: 'Airbnb'),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: RaisedButton(
                    padding: EdgeInsets.only(top: 13, bottom: 13),
                    color: Config.primary,
                    onPressed: () {
                      if (getJenjang == '' || getJenjang == 'Pilih Jenjang') {
                        Config.alert(0, 'Mohon memilih jenjang pendidikan');
                      } else if (getKelas == '' || getKelas == 'Pilih Kelas') {
                        Config.alert(0, 'Mohon memilih kelas');
                      } else if (getMapel == '' || getMapel == 'Pilih Mapel') {
                        Config.alert(0, 'Mohon memilih mata pelajaran');
                      } else {
                        getDataKelas();
                      }
                      // Navigator.pushNamed(context, Routes.LIST_TENTOR,
                      //     arguments: 0.toString());
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Cari Tentor',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'AirbnbBold',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
