import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:lesin_app/helper/input_file.dart';
import 'package:lesin_app/helper/repository.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahModul extends StatefulWidget {
  final String idKelas;
  TambahModul({this.idKelas});
  @override
  _TambahModulState createState() => _TambahModulState();
}

class _TambahModulState extends State<TambahModul> {
  String role = '';
  void info() async {
    var tmpRole = await Config.getRole();
    setState(() {
      role = tmpRole;
      print(widget.idKelas);
    });
  }

  LocalRepository _repo = LocalRepository();
  PlatformFile labelModul;
  TextEditingController txtJudul = new TextEditingController();
  TextEditingController txtMateri = new TextEditingController();

  List modul = new List();
  bool load = true;
  void getList() async {
    String token = await Config.getToken();
    String id = widget.idKelas;
    http.Response req = await http.get(Config.ipServerAPI + 'modul/$id', headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      print(data['data']);
      setState(() {
        load = false;
        modul = data['data'];
      });
    } else {
      Config.alert(0, 'Gagal memuat data');
    }
  }

  void addMateri() async {
    Config.loading(context);
    String token = await Config.getToken();
    String id = await Config.getID();
    Map<String, String> headers = {'Authorization': 'Bearer ' + token, 'Accept': 'application/json'};
    print(labelModul.path);
    final save = http.MultipartRequest(
      'POST',
      Uri.parse(Config.ipServerAPI + 'modul'),
    );
    save.files.add(await http.MultipartFile.fromPath('file', labelModul.path));
    save.headers.addAll(headers);
    save.fields['id_kelas'] = widget.idKelas;
    save.fields['judul'] = txtJudul.text;
    save.fields['materi'] = txtMateri.text;
    save.fields['id_tentor'] = id;
    var res = await save.send();
    var conf = res.reasonPhrase;
    print("resnya" + conf.toString());

    if (res.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.LIST_MODUL, arguments: widget.idKelas);
      // success(context);
      Config.alert(1, 'Berhasil menambahkan modul');
    } else {
      Navigator.pop(context);
      Config.alert(2, 'Gagal menambahkan data');
    }
  }

  @override
  void initState() {
    getList();
    info();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushNamed(context, Routes.LIST_MODUL, arguments: widget.idKelas);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[Config.primary, Config.secondary, Config.darkPrimary])),
          ),
          title: Text(
            'Tambah Modul',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: FadeAnimation(
                0.2,
                Column(
                  children: [
                    Text(
                      'Lengkapi form berikut untuk menambahkan modul',
                      style: TextStyle(fontFamily: 'Airbnb'),
                    ),
                    formInput(txtJudul, 'Judul'),
                    formInput(txtMateri, 'Materi'),
                    SizedBox(
                      height: 10,
                    ),
                    FormInputFile(
                        label: labelModul,
                        onTap: () async {
                          labelModul = await _repo.uploadFile(
                            allowedExtensions: [
                              'pdf',
                              'doc',
                              'docx',
                            ],
                          );
                          setState(() {});
                        }),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(0, 8, 4, 8),
                      child: RaisedButton(
                        padding: EdgeInsets.only(top: 13, bottom: 13),
                        color: Config.primary,
                        onPressed: () {
                          if (txtJudul.text.isEmpty) {
                            Config.alert(0, 'Judul harap diisi');
                          } else if (txtMateri.text.isEmpty) {
                            Config.alert(0, 'Materi harap diisi');
                          } else if (labelModul.path == '') {
                            Config.alert(0, 'Harap memilih file modul');
                          } else {
                            addMateri();
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
                ))),
      ),
    );
  }
}
