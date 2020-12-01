import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:http/http.dart' as http;
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';

class DialogAbsensi extends StatefulWidget {
  final String idKelas;
  DialogAbsensi({this.idKelas});
  @override
  _DialogAbsensiState createState() => _DialogAbsensiState();
}

class _DialogAbsensiState extends State<DialogAbsensi>
    with TickerProviderStateMixin {
  TextEditingController txtJurnal = new TextEditingController();
  TextEditingController txtTglMulai = new TextEditingController();
  DateTime tglMulai;

  List<DropdownMenuItem<String>> kehadiran;
  String getKehadiran = "";
  List listKehadiran = [
    'Pilih Status Kehadiran',
    'Hadir',
    'Tidak Hadir',
  ];

  void changedDropDownItemKehadiran(String selectedKehadiran) {
    setState(() {
      getKehadiran = selectedKehadiran;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsKehadiran() {
    List<DropdownMenuItem<String>> items = new List();

    for (String jjg in listKehadiran) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  void addAbsensi() async {
    String token = await Config.getToken();
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['id_kelas'] = widget.idKelas;
    body['kehadiran'] = getKehadiran;
    body['jurnal'] = txtJurnal.text;
    http.Response req = await http.post(Config.ipServerAPI + 'absensi',
        body: body, headers: {'Authorization': 'Bearer $token'});

    if (req.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, 'Berhasil menambahkan kelas');
      Navigator.pushNamed(context, Routes.ABSENSI, arguments: widget.idKelas);
    } else {
      print(req.body);
      Config.alert(0, 'Gagal menambahkan kelas');
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    kehadiran = getDropDownMenuItemsKehadiran();
    getKehadiran = kehadiran[0].value;
    print(widget.idKelas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(top: 8),
          height: 290,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            decoration: new BoxDecoration(
              color: Config.textWhite,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Tambah Absensi',
                  style: TextStyle(fontFamily: 'AirbnbBold', fontSize: 18),
                ),
                SizedBox(
                  height: 20,
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
                          'Pilih Kehadiran',
                          style: TextStyle(color: Config.textGrey),
                        ),
                        items: kehadiran,
                        onChanged: changedDropDownItemKehadiran,
                        value: getKehadiran,
                        style: TextStyle(
                            color: Config.textBlack, fontFamily: 'Airbnb'),
                      ),
                    ),
                  ),
                ),
                formInput(txtJurnal, 'Jurnal'),
                Container(
                  height: 100,
                  child: Stack(children: <Widget>[
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          color: Config.primary,
                          onPressed: () {
                            if (getKehadiran == '' ||
                                getKehadiran == 'Pilih StatusKehadiran') {
                              Config.alert(0, 'Harap memilih status kehadiran');
                            } else {
                              addAbsensi();
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
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
