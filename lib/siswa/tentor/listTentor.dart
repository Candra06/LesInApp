import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';

class ListTentor extends StatefulWidget {
  final String idDataMengajar;
  ListTentor({this.idDataMengajar});
  @override
  _ListTentorState createState() => _ListTentorState();
}

class _ListTentorState extends State<ListTentor> {
  Widget item(index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.DETAIL_TENTOR,
            arguments: 0.toString());
      },
      child: Card(
        child: Container(
            margin: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/icons/graduate.png')),
                    )),
                Container(
                    constraints: BoxConstraints(minWidth: 150, maxWidth: 300),
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Febri Karina',
                          // dataPenyakit[index]["nama_penyakit"],
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'AirbnbMedium'),
                        ),
                        Container(
                            child: Text(
                          '@febri',
                          style: TextStyle(
                              fontFamily: 'Airbnb', color: Config.textGrey),
                        )),
                        Container(
                            child: Text(
                          'Rating 5/5',
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
          'Pilih Tentor',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int i) {
            return item(i);
          },
        ),
      ),
    );
  }
}
