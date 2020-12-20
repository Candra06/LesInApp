import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DompetTentor extends StatefulWidget {
  @override
  _DompetTentorState createState() => _DompetTentorState();
}

class _DompetTentorState extends State<DompetTentor> {
  String saldo = '';
  List log = new List();
  bool load = true;
  void getSaldo() async {
    setState(() {
      load = true;
    });
    String token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'saldo',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        saldo = data['data']['saldo']['saldo_dompet'].toString();
        log = data['data']['log'];
        load = false;
      });
    } else {
      setState(() {
        saldo = 0.toString();
        load = false;
      });
    }
  }

  @override
  void initState() {
    getSaldo();
    super.initState();
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (log.isEmpty) {
      return Center(
          child: Container(
        child: Text(
          'Tidak ada riwayat transaksi',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ));
    } else {
      return ListView.builder(
          itemCount: log.length,
          itemBuilder: (BuildContext context, int i) {
            var tgl = log[i]['created_at'].toString().split(' ');
            // print(log[i]['created_at']);
            
            var tanggal = tgl[0];
            var jam = tgl[1].toString();

            return Card(
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            log[i]['jenis'],
                            style: TextStyle(
                                fontFamily: 'AirbnbMedium',
                                color: Config.primary),
                          ),
                          Text(
                            Config.formattanggal(tanggal.toString()),
                            style: TextStyle(
                                fontFamily: 'AirbnbReguler',
                                color: Config.textGrey),
                          ),
                          Text(
                             jam.toString(),
                            style: TextStyle(
                                fontFamily: 'AirbnbReguler',
                                color: Config.textGrey),
                          ),
                          Text(
                            log[i]['keterangan'],
                            style: TextStyle(
                              fontFamily: 'Airbnb',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rp. ' + log[i]['jumlah_saldo'].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: 'AirbnbBold',
                            fontSize: 16,
                            color: Config.secondary),
                      )
                    ],
                  )),
            );
          });
    }
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
          'Dompet',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Column(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saldo saya : ',
                      style: TextStyle(fontFamily: 'AirbnbMedium'),
                    ),
                    Text(
                      saldo == '' ? 'Rp. 0' : 'Rp. $saldo',
                      style: TextStyle(
                          fontFamily: 'AirbnbMedium', color: Config.primary),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                'Riwayat Transaksi : ',
                style: TextStyle(fontFamily: 'AirbnbMedium'),
              ),
            ),
            Container(
                constraints: BoxConstraints(minHeight: 200, maxHeight: 300),
                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: item()),
          ],
        ),
      ),
    );
  }
}
