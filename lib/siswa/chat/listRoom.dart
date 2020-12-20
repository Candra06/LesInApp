import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lesin_app/helper/routes.dart';

class ListRoomChat extends StatefulWidget {
  @override
  _ListRoomChatState createState() => _ListRoomChatState();
}

class _ListRoomChatState extends State<ListRoomChat> {
  List room = new List();
  bool load = true;
  String nama = '';
  void getList() async {
    setState(() {
      load = true;
    });
    nama = await Config.getNama();
    String token = await Config.getToken();
    http.Response req = await http.get(Config.ipServerAPI + 'listRoom',
        headers: {'Authorization': 'Bearer $token'});
    // print(req.body);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        load = false;
        print(data['data']);
        room = data['data'];
      });
    } else {
      print(req.body);
      Config.alert(0, 'Gagal mendapatkan data');
    }
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (room.isEmpty) {
      return Container(
        child: Center(
          child: Container(
            child: Text(
              'Data Chat Kosong',
              style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 18),
            ),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: room.isEmpty ? 0 : room.length,
          itemBuilder: (BuildContext context, int i) {
            var tgl = room[i]['created_at'].toString().split(' ');
            var tanggal = tgl[0];
            var jam = tgl[1];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.DETAIL_CHAT_SISWA,
                    arguments: room[i]['id_room'].toString());
              },
              // child: Container(),
              child: Card(
                child: Container(
                    margin: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  room[i]['nama'],
                                  // dataPenyakit[index]["nama_penyakit"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                                Container(
                                    child: Text(
                                  room[i]['message'],
                                  style: TextStyle(
                                    fontFamily: 'Airbnb',
                                  ),
                                )),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  tanggal,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.textGrey),
                                ),
                                Container(
                                    child: Text(
                                  jam,
                                  style: TextStyle(
                                      fontFamily: 'Airbnb',
                                      color: Config.textGrey),
                                )),
                                // Container(
                                //     child: Text(
                                //   room[i]['status'],
                                //   style: TextStyle(
                                //       fontFamily: 'Airbnb',
                                //       color: Config.primary),
                                // )),
                              ],
                            )),
                      ],
                    )),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.HOME, arguments: '0');
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
            'Chat',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: item(),
        ),
      ),
    );
  }
}
