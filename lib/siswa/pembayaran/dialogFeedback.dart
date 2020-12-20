import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:http/http.dart' as http;
import 'package:lesin_app/helper/routes.dart';

class DialogFeedback extends StatefulWidget {
  final String idKelas;
  final String harga;
  final String idTentor;
  DialogFeedback({this.idKelas, this.harga, this.idTentor});
  @override
  _DialogFeedbackState createState() => _DialogFeedbackState();
}

class _DialogFeedbackState extends State<DialogFeedback>
    with TickerProviderStateMixin {
  TextEditingController txtRating = new TextEditingController();
  TextEditingController txtFeedback = new TextEditingController();
  DateTime tglMulai;
  String fileName = '';
  Future<File> foto;
  String base64Image;
  File tmpFile;
  Future<File> file;

  List<String> listRekening = new List();
  List<String> idRekening = new List();
  String getRekening = '';

  void simpan() async {
    Config.loading(context);
    String token = '';
    String id = '';
    var tmp = await Config.getToken();
    var idSiswa = await Config.getID();
    setState(() {
      token = tmp;
      id = idSiswa;
    });
    var body = new Map<String, dynamic>();
    body['id_tentor'] = widget.idTentor;
    body['id_kelas'] = widget.idKelas;
    body['id_siswa'] = id;
    body['feedback'] = txtFeedback.text;
    body['rating'] = int.parse(txtRating.text).toString();
    print(body);
    http.Response res = await http.post(Config.ipServerAPI + 'feedback',
        body: body, headers: {'Authorization': 'Bearer $token'});
    print(res.body);
    if (res.statusCode == 200) {
      Navigator.pushNamed(context, Routes.HOME, arguments: '1');
      // success(context);
      Config.alert(1, 'Berhasil menambahkan feedback');
    } else {
      Navigator.pop(context);
      Config.alert(2, 'Gagal menambahkan data');
    }
  }

  @override
  void initState() {
    print(widget.harga);
    print(widget.idKelas);
    print(widget.idTentor);
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
          'Fedback ',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            formInput(txtFeedback, 'Feedback'),
            formInputType(txtRating, 'Rating(1-5)', TextInputType.number),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: RaisedButton(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                color: Config.primary,
                onPressed: () {
                  if (txtFeedback.text.isEmpty) {
                    Config.alert(0, 'Harap memasukkan Feedback');
                  } else if (txtRating.text.isEmpty) {
                    Config.alert(0, 'Harap memasukkan rating tentor');
                  } else if (int.parse(txtRating.text.toString()) > 5 ||
                      int.parse(txtRating.text.toString()) <= 0) {
                    Config.alert(0, 'Rating tidak valid');
                  } else {
                    simpan();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'KIRIM',
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
