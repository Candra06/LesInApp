import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:http/http.dart' as http;

class DialogAddPrestasi extends StatefulWidget {
  @override
  _DialogAddPrestasiState createState() => _DialogAddPrestasiState();
}

class _DialogAddPrestasiState extends State<DialogAddPrestasi> {
  TextEditingController txtTingkatan = new TextEditingController();
  TextEditingController txtPenghargaan = new TextEditingController();
 
  void simpanData() async {
    Config.loading(context);
    String token = await Config.getToken();
    String id = await Config.getID();
    var body = new Map<String, dynamic>();
    body['tingkatan'] = txtTingkatan.text;
    body['tentor'] = id.toString();
    body['penghargaan'] = txtPenghargaan.text;
    http.Response req = await http.post(
        Config.ipServerAPI + 'addPrestasi',
        body: body,
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, 'Berhasil menambahkan data');
      Navigator.pushNamed(context, Routes.DATA_PRESTASI);
    } else {
      Navigator.pop(context);
      Config.alert(0, 'Gagal menambahkan data');
    }
  }

  @override
  void initState() {
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
          'Tambah Riwayat Prestasi',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            formInput(txtTingkatan, 'Tingkatan Prestasi'),
            
            formInput(txtPenghargaan, 'Penghargaan'),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: RaisedButton(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                color: Config.primary,
                onPressed: () {
                  if (txtTingkatan.text.isEmpty) {
                    Config.alert(0, "Harap Mengisi Tingkatan!");
                  } else if (txtPenghargaan.text == '' ) {
                    Config.alert(0, "Harap Penghargaan!");
                  } else {
                    simpanData();
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
    );
  }
}
