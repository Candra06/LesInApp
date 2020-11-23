import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';

class NegoTarif extends StatefulWidget {
  @override
  _NegoTarifState createState() => _NegoTarifState();
}

class _NegoTarifState extends State<NegoTarif> {
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
                              width: 80.0,
                              height: 80.0,
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
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text('Febi Karina',
                                style: TextStyle(
                                    fontFamily: 'AirbnbMedium',
                                    color: Config.textBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            child: Text('Febi',
                                style: TextStyle(
                                  fontFamily: 'AirbnbMedium',
                                  color: Config.textGrey,
                                  fontSize: 16,
                                )),
                          ),
                          Container(
                            child: Text('08983368286',
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
                      constraints: BoxConstraints(minWidth: 70, maxWidth: 110),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Rating : 5/5',
                        style: TextStyle(
                            color: Config.primary, fontFamily: 'Airbnb'),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            style: TextStyle(color: Colors.black54),
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            // controller: txEmail,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              fillColor: Colors.black54,
                              hintText: "Jumlah Pertemuan",
                              hintStyle: TextStyle(
                                  // color: Config.textWhite,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16),
                              border: InputBorder.none,
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Stack(children: [
                    Positioned(
                      bottom: 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          color: Config.primary,
                          onPressed: () {
                            // Navigator.pushNamed(context, Routes.HOMEPAGE,
                            //     arguments: 0.toString());
                            Navigator.pushNamed(context, Routes.ABSENSI,
                                arguments: 0.toString());
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
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
                    ),
                  ]),
                ),
              ],
            )),
      ),
    );
  }
}
