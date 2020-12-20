import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/routes.dart';
import 'package:lesin_app/helper/size.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailChatSiswa extends StatefulWidget {
  final String idRoom;
  DetailChatSiswa({this.idRoom});
  @override
  _DetailChatSiswaState createState() => _DetailChatSiswaState();
}

class _DetailChatSiswaState extends State<DetailChatSiswa> {
  String idTentor = '', idAkun = '';
  TextEditingController pesan = new TextEditingController();
  List chat = new List();
  bool load = true;
  void getInfo() async {
    var tmpNama = await Config.getIDAkun();
    setState(() {
      idAkun = tmpNama;
    });
    print('akun $idAkun');
  }

  void createChat() async {
    String token = await Config.getToken();
    String tmpId = await Config.getIDAkun();
    String idSiswa = await Config.getID();
    var body = new Map<String, dynamic>();
    body['id_siswa'] = idSiswa;
    body['id_tentor'] = idTentor;
    body['message'] = pesan.text;
    body['created_by'] = tmpId;
    print(body);
    http.Response req = await http.post(Config.ipServerAPI + 'createChat',
        body: body, headers: {'Authorization': 'Bearer $token'});
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      String room = data['room'].toString();
      getChat(room);
      setState(() {
        pesan.text = '';
      });
    } else {
      print(req.body);
    }
  }

  void getChat(String room) async {
    setState(() {
      load = true;
    });
    String tmpId = await Config.getIDAkun();
    String token = await Config.getToken();
    http.Response res = await http.get(Config.ipServerAPI + 'detailChat/$room',
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        load = false;
        idAkun = tmpId;
        idTentor = data['data'][0]['id_tentor'].toString();
        chat = data['data'];
      });
    } else {
      print('object');
    }
  }

  Widget item() {
    if (load) {
      return Config.newloader('Memuat data');
    } else if (chat.isEmpty) {
      return Center(
        child: Container(
          child: Text(
            'Chat tidak tersedia',
            style: TextStyle(fontFamily: 'AirbnbMedium', fontSize: 16),
          ),
        ),
      );
    } else {
      return ListView.separated(
          separatorBuilder: (context, int i) {
            return Container(
              color: Config.textWhite,
              width: displayWidth(context),
              height: 1,
            );
          },
          itemCount: chat.length,
          itemBuilder: (context, int i) {
            
            if (chat[i]['created_by'].toString() == idAkun.toString()) {
              return Container(
                constraints: BoxConstraints(minWidth: 75, maxWidth: 150),
                margin: EdgeInsets.only(left: 40, top: 4),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Config.secondary,
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  chat[i]['message'],
                  style:
                      TextStyle(color: Config.textWhite, fontFamily: 'Airbnb'),
                ),
              );
            } else {
              return Container(
                constraints: BoxConstraints(minWidth: 75, maxWidth: 150),
                // width: 50,
                margin: EdgeInsets.only(right: 40, top: 4),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black12,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  chat[i]['message'],
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(color: Config.textBlack, fontFamily: 'Airbnb'),
                ),
              );
            }
          });
    }
  }

  @override
  void initState() {
    getChat(widget.idRoom);
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, Routes.LIST_CHAT_SISWA);
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
            'Detail Chat',
            style: TextStyle(fontFamily: 'AirbnbMedium'),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(
              top: 8,
            ),
            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: Stack(
              children: <Widget>[
                Container(
                    constraints: BoxConstraints(
                        minHeight: 100, maxHeight: MediaQuery.of(context).size.height * 0.95),
                    margin: EdgeInsets.fromLTRB(4, 4, 4, 60),
                    child: item()),
                Stack(
                  children: [
                    Positioned(
                      bottom: 5,
                      left: 5,
                      right: 5,
                      child: Container(
                        // constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 8, 0),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 200,
                                      maxWidth: displayWidth(context)),
                                  child: TextFormField(
                                      controller: pesan,
                                      style: TextStyle(color: Colors.black54),
                                      obscureText: false,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            if (pesan.text.isEmpty) {
                                              Config.alert(0, 'Pesan kosong!');
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
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
