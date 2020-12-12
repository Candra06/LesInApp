import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;

class DialogAddPendidikan extends StatefulWidget {
  @override
  _DialogAddPendidikanState createState() => _DialogAddPendidikanState();
}

class _DialogAddPendidikanState extends State<DialogAddPendidikan> {
  TextEditingController txtSekolah = new TextEditingController();
  TextEditingController txtTahun = new TextEditingController();
  List<DropdownMenuItem<String>> tingkatan;
  List<DropdownMenuItem<String>> status;
  String getTingkatan = "", getStatus = '';
  List listTingkatan = [
    'Pilih Tingkatan',
    'SD',
    'SMP',
    'SMA',
    'Universitas',
  ];
  List listStatus = [
    'Pilih Status Pendidikan',
    'Lulus',
    'Sedang Menempuh',
  ];

  void changedDropDownItemTingkatan(String selectedTingkatan) {
    setState(() {
      getTingkatan = selectedTingkatan;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsTingkatan() {
    List<DropdownMenuItem<String>> items = new List();

    for (String jjg in listTingkatan) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  void changedDropDownItemStatus(String selectedStatus) {
    setState(() {
      getStatus = selectedStatus;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsStatus() {
    List<DropdownMenuItem<String>> items = new List();

    for (String jjg in listStatus) {
      items.add(new DropdownMenuItem(value: jjg, child: new Text(jjg)));
    }
    return items;
  }

  void simpanData() async {
    Config.loading(context);
    String token = await Config.getToken();
    String id = await Config.getID();
    var body = new Map<String, dynamic>();
    body['nama_sekolah'] = txtSekolah.text;
    body['id_tentor'] = id.toString();
    body['jenjang_pendidikan'] = getTingkatan;
    body['status_pendidikan'] = getStatus;
    body['tahun_lulus'] = txtTahun.text;
    http.Response req = await http.post(
        Config.ipServerAPI + 'addRiwayatPendidikan',
        body: body,
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, 'Berhasil menambahkan data');
      Navigator.pushNamed(context, Routes.RIWAYAT_PENDIDIKAN);
    } else {
      Navigator.pop(context);
      Config.alert(0, 'Gagal menambahkan data');
    }
  }

  @override
  void initState() {
    tingkatan = getDropDownMenuItemsTingkatan();
    getTingkatan = tingkatan[0].value;
    status = getDropDownMenuItemsStatus();
    getStatus = status[0].value;
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
          'Tambah Riwayat Pendidikan',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            formInput(txtSekolah, 'Nama Sekolah'),
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
                      'Pilih Tingkatan',
                      style: TextStyle(color: Config.textGrey),
                    ),
                    items: tingkatan,
                    onChanged: changedDropDownItemTingkatan,
                    value: getTingkatan,
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
                      'Pilih Status',
                      style: TextStyle(color: Config.textGrey),
                    ),
                    items: status,
                    onChanged: changedDropDownItemStatus,
                    value: getStatus,
                    style: TextStyle(
                        color: Config.textBlack, fontFamily: 'Airbnb'),
                  ),
                ),
              ),
            ),
            formInput(txtTahun, 'Tahun Lulus'),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: RaisedButton(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                color: Config.primary,
                onPressed: () {
                  if (txtSekolah.text.isEmpty) {
                    Config.alert(0, "Harap Mengisi Nama Sekolah!");
                  } else if (getStatus == '' ||
                      getStatus == 'Pilih Status Pendidikan') {
                    Config.alert(0, "Harap Memilih Status Pendidikan!");
                  } else if (getTingkatan == '' ||
                      getTingkatan == 'Pilih Tingkatan') {
                    Config.alert(0, "Harap Memilih Tingkatan Pendidikan!");
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
