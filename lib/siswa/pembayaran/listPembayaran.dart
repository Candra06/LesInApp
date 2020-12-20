import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPembayaran extends StatefulWidget {
  @override
  _ListPembayaranState createState() => _ListPembayaranState();
}

class _ListPembayaranState extends State<ListPembayaran> {
  List pembayaran = new List();
  bool load = true;
  String nama = '';
  void getList() async {
    setState(() {
      load = true;
    });
    nama = await Config.getNama();
    String token = await Config.getToken();
    http.Response req = await http.get(Config.ipServerAPI + 'listPembayaran',
        headers: {'Authorization': 'Bearer $token'});

    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      setState(() {
        load = false;
        pembayaran = data['data'];
      });
    } else {
      Config.alert(0, 'Gagal mendapatkan data');
    }
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (pembayaran.isEmpty) {
      return Container(
        child: Center(
          child: Container(
            child: Text(
              'Data Pembayaran Kosong',
              style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 18),
            ),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: pembayaran.isEmpty ? 0 : pembayaran.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                // Navigator.pushNamed(context, Routes.DETAIL_TENTOR,
                //     arguments: 0.toString());
              },
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
                                  pembayaran[i]['keterangan'],
                                  // dataPenyakit[index]["nama_penyakit"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.primary),
                                ),
                                Container(
                                    child: Text(
                                  nama,
                                  style: TextStyle(
                                      fontFamily: 'Airbnb',
                                      color: Config.primary),
                                )),
                                Container(
                                    child: Text(
                                  'Rp. '+Config.formatuang(pembayaran[i]['jumlah_bayar']),
                                  style: TextStyle(
                                      fontFamily: 'Airbnb',
                                      color: Config.primary),
                                )),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  Config.formattanggal(pembayaran[i]
                                          ['tanggal_bayar']
                                      .toString()
                                      .replaceAll('00:00:00', '')),
                                  // dataPenyakit[index]["nama_penyakit"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'AirbnbMedium',
                                      color: Config.textGrey),
                                ),
                                Container(
                                    child: Text(
                                  '23.12',
                                  style: TextStyle(
                                      fontFamily: 'Airbnb',
                                      color: Config.textGrey),
                                )),
                                Container(
                                    child: Text(
                                  pembayaran[i]['status'],
                                  style: TextStyle(
                                      fontFamily: 'Airbnb',
                                      color: Config.primary),
                                )),
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
          'Pembayaran',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: item(),
      ),
    );
  }
}