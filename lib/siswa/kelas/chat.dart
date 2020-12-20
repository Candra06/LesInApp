import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:lesin_app/siswa/kelas/dialogConfirm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NegoTarif extends StatefulWidget {
  final Map<String, dynamic> param;
  NegoTarif({this.param});
  @override
  _NegoTarifState createState() => _NegoTarifState();
}

class _NegoTarifState extends State<NegoTarif> {
  TextEditingController pesan = new TextEditingController();
  List nego = new List();
  String akun = '';
  String nama = '', username = '', hp = '', rating = '';
  bool load = true;
  void createChat() async {
    String token = await Config.getToken();
    String id = await Config.getID();
    String idAkun = await Config.getIDAkun();
    var body = new Map<String, dynamic>();
    body['id_siswa'] = id;
    body['created_by'] = idAkun;
    body['id_tentor'] = widget.param['tentor'].toString();
    body['message'] = pesan.text;

    http.Response req = await http.post(Config.ipServerAPI + 'createChat',
        body: body, headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      String room = data['room'].toString();
      getChat(room);
      print(req.body);
      setState(() {
        pesan.text = '';
      });
    } else {
      print(req.body);
    }
  }

  void getTentor() async {
    setState(() {
      load = true;
    });
    String tntr = widget.param['tentor'].toString();
    print(tntr);
    String token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'getInfo/' + tntr,
        headers: {'Authorization': 'Bearer $token'});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        nama = data['data']['nama'];
        username = data['data']['username'];
        hp = data['data']['telepon'];
        rating = data['data']['rating'];
      });
    } else {}
  }

  void getChat(String room) async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    String akn = await Config.getIDAkun();
    http.Response res = await http.get(Config.ipServerAPI + 'detailChat/$room',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        akun = akn;
        load = false;
        nego = data['data'];
      });
    } else {
      print('object');
    }
  }

  @override
  void initState() {
    print(widget.param);
    getTentor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                  title: new Text('Konfirmasi?'),
                  content: new Text(
                      'Apakah anda ingin keluar dari halaman ini dan menyimpan proses booking?'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: new Text(
                        'Tidak',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Config.primary),
                      ),
                    ),
                    new FlatButton(
                      onPressed: () async {
                        print(widget.param.toString());
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.setString('mapel', widget.param['mapel']);
                        await pref.setString('tentor', widget.param['tentor']);
                        await pref.setString('hari', widget.param['hari']);
                        await pref.setString(
                            'pertemuan', widget.param['pertemuan']);
                        Navigator.pushNamed(context, Routes.HOME,
                            arguments: '0');
                      },
                      child: new Text(
                        'Ya',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Config.primary),
                      ),
                    ),
                  ],
                ));
      },
      child: Scaffold(
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
            'Nego Tarif',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/icons/graduate.png')),
                                ))
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 8, bottom: 8),
                      //   height: 50,
                      // ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(nama == '' ? '' : nama,
                                  style: TextStyle(
                                    fontFamily: 'AirbnbMedium',
                                    color: Config.textBlack,
                                    fontSize: 16,
                                  )),
                            ),
                            Container(
                              child: Text(username == '' ? '' : username,
                                  style: TextStyle(
                                    fontFamily: 'AirbnbMedium',
                                    color: Config.textGrey,
                                    fontSize: 16,
                                  )),
                            ),
                            Container(
                              child: Text(hp == '' ? '' : hp,
                                  style: TextStyle(
                                    fontFamily: 'AirbnbMedium',
                                    color: Config.textGrey,
                                    fontSize: 14,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: 40, maxWidth: 50),
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.star, color: Colors.yellow[800]),
                            Text(
                              rating == '' ? '0' : rating,
                              style: TextStyle(
                                  color: Config.primary,
                                  fontFamily: 'AirbnbBold'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                      constraints:
                          BoxConstraints(minHeight: 200, maxHeight: 445),
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              constraints: BoxConstraints(
                                  minHeight: 100, maxHeight: 380),
                              margin: EdgeInsets.fromLTRB(4, 8, 4, 8),
                              child: ListView.separated(
                                  separatorBuilder: (context, int i) {
                                    return Container(
                                      color: Config.textWhite,
                                      width: displayWidth(context),
                                      height: 1,
                                    );
                                  },
                                  itemCount: nego.isEmpty ? 0 : nego.length,
                                  itemBuilder: (context, int i) {
                                    if (nego[i]['created_by'].toString() ==
                                        akun.toString()) {
                                      return Container(
                                        margin:
                                            EdgeInsets.only(left: 40, top: 4),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Config.secondary,
                                        ),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          nego[i]['message'],
                                          style: TextStyle(
                                              color: Config.textWhite,
                                              fontFamily: 'Airbnb'),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin:
                                            EdgeInsets.only(right: 40, top: 4),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.black12,
                                        ),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          nego[i]['message'],
                                          style: TextStyle(
                                              color: Config.textBlack,
                                              fontFamily: 'Airbnb'),
                                        ),
                                      );
                                    }
                                  })),
                          Container(
                            // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 8, 0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          constraints: BoxConstraints(
                                              minWidth: 200, maxWidth: 300),
                                          child: TextFormField(
                                              controller: pesan,
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              // controller: txEmail,
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    if (pesan.text.isEmpty) {
                                                      Config.alert(
                                                          0, 'Pesan kosong!');
                                                    } else {
                                                      createChat();
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.send,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                alignLabelWithHint: true,
                                                fillColor: Colors.black54,
                                                hintText: "Ketik Pesan",
                                                hintStyle: TextStyle(
                                                    // color: Config.textWhite,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16),
                                                border: InputBorder.none,
                                              )),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )),
                  FadeAnimation(
                    0.2,
                    Container(
                      height: 100,
                      child: Stack(children: <Widget>[
                        Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.fromLTRB(0, 16, 4, 8),
                                    child: RaisedButton(
                                      padding:
                                          EdgeInsets.only(top: 13, bottom: 13),
                                      color: Config.primary,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                new AlertDialog(
                                                  title: new Text(
                                                      'Apakah Anda Yakin?'),
                                                  content: new Text(
                                                      'Ingin membatalkan proses booking?'),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      child: new Text(
                                                        'Tidak',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Config.primary),
                                                      ),
                                                    ),
                                                    new FlatButton(
                                                      onPressed: () async {
                                                        SharedPreferences pref =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        await pref.setString(
                                                            'mapel', '0');
                                                        await pref.setString(
                                                            'tentor', '');
                                                        await pref.setString(
                                                            'hari', '');
                                                        await pref.setString(
                                                            'pertemuan', '');
                                                        Navigator.pushNamed(
                                                            context,
                                                            Routes.HOME,
                                                            arguments: '0');
                                                      },
                                                      child: new Text(
                                                        'Ya',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Config.primary),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Batal',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'AirbnbBold',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.fromLTRB(4, 16, 0, 8),
                                    child: RaisedButton(
                                      padding:
                                          EdgeInsets.only(top: 13, bottom: 13),
                                      color: Config.primary,
                                      onPressed: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        await pref.setString('mapel', '');
                                        await pref.setString('tentor', '');
                                        await pref.setString('hari', '');
                                        await pref.setString('pertemuan', '');
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                DialogConfirm(widget.param));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                )
                              ],
                            )),
                      ]),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
