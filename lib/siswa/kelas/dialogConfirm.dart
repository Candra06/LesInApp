import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:http/http.dart' as http;
import 'package:lesin_app/helper/routes.dart';

class DialogConfirm extends StatefulWidget {
  Map<String, dynamic> data;
  DialogConfirm(this.data);
  @override
  _DialogConfirmState createState() => _DialogConfirmState(this.data);
}

class _DialogConfirmState extends State<DialogConfirm>
    with TickerProviderStateMixin {
  Map<String, dynamic> data;
  _DialogConfirmState(this.data);
  TextEditingController txtHarga = new TextEditingController();
  TextEditingController txtTglMulai = new TextEditingController();
  DateTime tglMulai;

  void addKelas() async {
    String siswa = await Config.getID();
    String token = await Config.getToken();
    Config.loading(context);
    var body = new Map<String, dynamic>();
    body['tentor'] = widget.data['tentor'];
    body['siswa'] = siswa;
    body['jumlah_pertemuan'] = widget.data['pertemuan'];
    body['hari'] = widget.data['hari'];
    body['tanggal'] = txtTglMulai.text;
    body['mapel'] = widget.data['mapel'];
    body['tarif'] = txtHarga.text;
    String deal =
        (int.parse(txtHarga.text) * int.parse(widget.data['pertemuan']))
            .toString();
    body['harga_deal'] = deal;
    print(body);
    http.Response req = await http.post(Config.ipServerAPI + 'tambahKelas',
        body: body, headers: {'Authorization': 'Bearer $token'});

    if (req.statusCode == 200) {
      Navigator.pop(context);
      Config.alert(1, 'Berhasil menambahkan kelas');
      Navigator.pushNamed(context, Routes.HOME, arguments: '1');
    } else {
      print(req.body);
      Config.alert(0, 'Gagal menambahkan kelas');
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    print(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(top: 8),
          height: 290,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            decoration: new BoxDecoration(
              color: Config.textWhite,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Konfirmasi Pemesanan',
                  style: TextStyle(fontFamily: 'AirbnbBold', fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                formInputType(txtHarga, 'Harga Deal', TextInputType.number),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              style: TextStyle(color: Colors.black54),
                              obscureText: false,
                              controller: txtTglMulai,
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.date_range),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      currentDate: DateTime.now(),
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2022),
                                    ).then((date) {
                                      tglMulai = date;
                                      String tanggal = tglMulai
                                          .toString()
                                          .replaceAll("00:00:00.000", "");
                                      print(tanggal);
                                      print(Config.formattanggal(
                                          tanggal.toString()));
                                      txtTglMulai.text = Config.formattanggal(
                                          tglMulai
                                              .toString()
                                              .replaceAll("00:00:00.000", ""));
                                    });
                                  },
                                ),
                                alignLabelWithHint: true,
                                fillColor: Colors.black54,
                                hintText: "Tanggal Mulai",
                                hintStyle: TextStyle(
                                    // color: Config.textWhite,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16),
                                border: InputBorder.none,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            if (txtHarga.text.isEmpty) {
                              Config.alert(0, 'Harap memasukkan harga deal');
                            } else if (txtTglMulai.text.isEmpty) {
                              Config.alert(0, 'Harap memasukkan harga deal');
                            } else {
                              addKelas();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Booking',
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
            ),
          ),
        ));
  }
}
