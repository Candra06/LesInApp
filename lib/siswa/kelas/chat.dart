import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/fade_animation.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:lesin_app/siswa/kelas/dialogConfirm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NegoTarif extends StatefulWidget {
  final Map<String, dynamic> param;
  NegoTarif({this.param});
  @override
  _NegoTarifState createState() => _NegoTarifState();
}

class _NegoTarifState extends State<NegoTarif> {
  @override
  TextEditingController pesan = new TextEditingController();
  List nego = new List();
  void createChat() async {
    String token = await Config.getToken();
    String id = await Config.getID();
    var body = new Map<String, dynamic>();
    body['id_siswa'] = id;
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

  void getChat(String room) async {
    String token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'detailChat/$room',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print('object');
    }
  }

  void initState() {
    print(widget.param);
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
                    constraints: BoxConstraints(minHeight: 200, maxHeight: 445),
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                            constraints:
                                BoxConstraints(minHeight: 100, maxHeight: 380),
                            margin: EdgeInsets.fromLTRB(4, 8, 4, 8),
                            child: ListView.separated(
                                separatorBuilder: (context, int i) {
                                  return Container(
                                    color: Config.textWhite,
                                    width: displayWidth(context),
                                    height: 1,
                                  );
                                },
                                itemCount: 3,
                                itemBuilder: (context, int i) {
                                  if ((i % 2) == 0) {
                                    return Container(
                                      margin: EdgeInsets.only(left: 40, top: 4),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Config.secondary,
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Lorem Ipsum dolor sit amet Lorem Lorem Lorem Ipsum dolor',
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
                                        'Lorem Ipsum dolor sit amet Lorem Lorem Lorem Ipsum dolor',
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
                                                  createChat();
                                                  print('push');
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
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 13, bottom: 13),
                            color: Config.primary,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DialogConfirm(widget.param));
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
                ),
              ],
            )),
      ),
    );
  }
}
