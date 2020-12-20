import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JadwalKelas extends StatefulWidget {
  final Map<String, dynamic> param;
  JadwalKelas({this.param});
  @override
  _JadwalKelasState createState() => _JadwalKelasState();
}

class _JadwalKelasState extends State<JadwalKelas> {
  List<DropdownMenuItem<String>> hari;
  String getHari = "", token = "", idTentor = "";
  void getJadwal() async {
    token = await Config.getToken();
    idTentor = widget.param['tentor'];
    http.Response res = await http.get(
        Config.ipServerAPI + 'jadwal/' + idTentor,
        headers: {'Authorization': 'Bearer $token'});
    List tmp = new List();
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      for (var i = 0; i < data['data'].length; i++) {
        tmp.add(data['data'][i]);
      }
      setState(() {
        print(tmp);
        listHari = tmp;
        hari = getDropDownMenuItemsHari();
        getHari = hari[0].value;
      });
    } else {}
  }

  TextEditingController txtJumlah = new TextEditingController();
  List listHari = [
    'Pilih Hari',
  ];

  void changedDropDownItemHari(String selectedHari) {
    setState(() {
      getHari = selectedHari;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsHari() {
    List<DropdownMenuItem<String>> items = new List();

    for (String jjg in listHari) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  @override
  void initState() {
    getJadwal();

    print(widget.param);
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
          'Jadwal Kelas',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    'Silahkan isi data informasi Jadwal Kelas, lalu klik selanjutnya untuk menentukan tarif dengan tentor!',
                    style: TextStyle(fontFamily: 'Airbnb'),
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
                            keyboardType: TextInputType.number,
                            controller: txtJumlah,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              fillColor: Colors.black54,
                              hintText: "Jumlah Pertemuan",
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
                          'Pilih Hari',
                          style: TextStyle(color: Config.textGrey),
                        ),
                        items: hari,
                        onChanged: changedDropDownItemHari,
                        value: getHari,
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
                      if (txtJumlah.text.isEmpty) {
                        Config.alert(0, "Harap mengisi jumlah pertemuan");
                      } else if (getHari == '' || getHari == 'Pilih Hari') {
                        Config.alert(0, "Harap mengisi jumlah pertemuan");
                      } else {
                        var parameter = {
                          'mapel': widget.param['mapel'],
                          'tentor': widget.param['tentor'],
                          'hari': getHari.toString(),
                          'pertemuan': txtJumlah.text,
                        };
                        Navigator.pushNamed(context, Routes.NEGO_TARIF,
                            arguments: parameter);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Selanjutnya',
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
