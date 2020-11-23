import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';

class ListPembayaran extends StatefulWidget {
  @override
  _ListPembayaranState createState() => _ListPembayaranState();
}

class _ListPembayaranState extends State<ListPembayaran> {
  Widget item(index) {
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
                          'DP 50%',
                          // dataPenyakit[index]["nama_penyakit"],
                          style: TextStyle(
                              fontSize: 14, fontFamily: 'AirbnbMedium', color: Config.primary),
                        ),
                        Container(
                            child: Text(
                          'Febri Karina',
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.primary),
                        )),
                        Container(
                            child: Text(
                          'Rp. 135.000',
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.primary),
                        )),
                      ],
                    )),
                    Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '23 Desember 2020',
                          // dataPenyakit[index]["nama_penyakit"],
                          style: TextStyle(
                              fontSize: 14, fontFamily: 'AirbnbMedium', color: Config.textGrey),
                        ),
                        Container(
                            child: Text(
                          '23.12',
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.textGrey),
                        )),
                        Container(
                            child: Text(
                          'Belum Dibayar',
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.primary),
                        )),
                      ],
                    )),
              ],
            )),
      ),
    );
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
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int i) {
          return item(i);
        }),
      ),
    );
  }
}
