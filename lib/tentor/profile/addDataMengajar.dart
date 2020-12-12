import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DialogAddDataMengajar extends StatefulWidget {
  @override
  _DialogAddDataMengajarState createState() => _DialogAddDataMengajarState();
}

class _DialogAddDataMengajarState extends State<DialogAddDataMengajar> {
  TextEditingController txtSekolah = new TextEditingController();
  TextEditingController txtMapel = new TextEditingController();
  List<DropdownMenuItem<String>> tingkatan;
  List<DropdownMenuItem<String>> status;
  String getMapel = '', getId = '', nmMpl = '';

  List<String> mapel = new List();
  List<String> idMapel = new List();

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

  void getDataMapel() async {
    String token = await Config.getToken();
    http.Response req = await http.get(Config.ipServerAPI + 'mapel',
        headers: {'Authorization': 'Bearer $token'});
    print(req.body);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      List<String> val = new List();
      List<String> idMpl = new List();
      List tmp = data['data'];
      for (var i = 0; i < tmp.length; i++) {
        val.add(tmp[i]['mapel'] +
            '(' +
            tmp[i]['kelas'] +
            ' ' +
            tmp[i]['jenjang'] +
            ')');
        idMpl.add(tmp[i]['id'].toString());
      }
      setState(() {
        print(val);
        mapel = val;
        idMapel = idMpl;
      });
    } else {
      setState(() {
        Config.alert(0, 'Gagal memuat data');
      });
    }
  }

  void simpanData() async {
    Config.loading(context);
    String token = await Config.getToken();
    String id = await Config.getID();
    var body = new Map<String, dynamic>();
    body['mapel'] = getMapel;
    body['tentor'] = id.toString();
    print(body);
    http.Response req = await http.post(
        Config.ipServerAPI + 'addDataMengajar',
        body: body,
        headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, 'Berhasil menambahkan data');
      Navigator.pushNamed(context, Routes.DATA_MENGAJAR);
    } else {
      Navigator.pop(context);
      Config.alert(0, 'Gagal menambahkan data');
    }
  }

  List<String> getSuggestions(String query) {
    mapel.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return mapel;
  }

  @override
  void initState() {
    tingkatan = getDropDownMenuItemsTingkatan();
    getTingkatan = tingkatan[0].value;
    status = getDropDownMenuItemsStatus();
    getStatus = status[0].value;
    getDataMapel();
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
          'Tambah Data Mengajar',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 8),
                width: displayWidth(context),
                height: 50,
                child: DropdownSearch(
                  mode: Mode.MENU,
                  searchBoxController: txtMapel,
                  showSearchBox: true,
                  showSelectedItem: true,
                  items: mapel == null ? ['Pilih mapel'] : mapel,
                  label: "Mata Pelajaran",
                  hint: "Mata Pelajaran",
                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (value) {
                    setState(() {
                      nmMpl = value;
                      getMapel = idMapel[mapel.indexOf(value)];
                      print(getMapel);
                    });
                  },
                  // selectedItem: ,
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: RaisedButton(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                color: Config.primary,
                onPressed: () {
                  if (getMapel == '') {
                    Config.alert(0, "Harap Memilih Mata Pelajaran!");
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
