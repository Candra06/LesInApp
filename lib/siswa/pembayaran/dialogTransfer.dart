import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:http/http.dart' as http;
import 'package:lesin_app/helper/routes.dart';

class DialogTransfer extends StatefulWidget {
  final String idKelas;
  final String harga;
  DialogTransfer({this.idKelas, this.harga});
  @override
  _DialogTransferState createState() => _DialogTransferState();
}

class _DialogTransferState extends State<DialogTransfer>
    with TickerProviderStateMixin {
  TextEditingController txtKeterangan = new TextEditingController();
  TextEditingController txtTglMulai = new TextEditingController();
  TextEditingController txtJumlah = new TextEditingController();
  DateTime tglMulai;
  String fileName = '';
  Future<File> foto;
  String base64Image;
  File tmpFile;
  Future<File> file;

  getImage(context) async {
    final imgSrc = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Pilih sumber gambar"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Kamera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                  // onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Galeri"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imgSrc != null) {
      setState(() {
        foto = ImagePicker.pickImage(source: imgSrc);
        String image = foto.toString();
        print('fotonya ' + image);
        print(foto);
      });
    }
  }

  Widget showImage() {
    return Container(
      child: FutureBuilder<File>(
        future: foto,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            tmpFile = snapshot.data;
            fileName = tmpFile.path.split("/").last;
            base64Image = base64Encode(snapshot.data.readAsBytesSync());
            return Column(
              children: [
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 200,
                //   child: Image.file(snapshot.data, fit: BoxFit.contain),
                // ),
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      fileName,
                      maxLines: 3,
                    )),
              ],
            );
            // return Container(
            //   margin: EdgeInsets.all(8),
            //   child: Image.file(snapshot.data, fit: BoxFit.fill),
            // );
          } else if (snapshot.error != null) {
            return const Text(
              'Error saat memilih foto!',
              textAlign: TextAlign.center,
            );
          } else {
            return Column(
              children: <Widget>[Text('Pilih bukti transfer')],
            );
          }
        },
      ),
    );
  }

  void simpanLaporan() async {
    Config.loading(context);
    String token = await Config.getToken();
    Map<String, String> headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json'
    };
    print(tmpFile.path);
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse(Config.ipServerAPI + 'pembayaran'),
    );
    imageUploadRequest.files
        .add(await http.MultipartFile.fromPath('bukti_tf', tmpFile.path));
    imageUploadRequest.headers.addAll(headers);
    imageUploadRequest.fields['id_kelas'] = widget.idKelas;
    imageUploadRequest.fields['harga_deal'] = widget.harga;
    imageUploadRequest.fields['tanggal_bayar'] = txtTglMulai.text;
    imageUploadRequest.fields['keterangan'] = txtKeterangan.text;
    imageUploadRequest.fields['jumlah_bayar'] = txtJumlah.text;
    var res = await imageUploadRequest.send();
    var conf = res.reasonPhrase;
    print("resnya" + conf.toString());

    if (res.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      // success(context);
      Config.alert(1, 'Berhasil menambahkan bukti transfer');
    } else {
      Navigator.pop(context);
      Config.alert(2, 'Gagal menambahkan data');
    }
  }

  @override
  void initState() {
    print(widget.harga);
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
          constraints: BoxConstraints(minHeight: 300, maxHeight: 440),
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
                  'Unggah Bukti Pembayaran',
                  style: TextStyle(fontFamily: 'AirbnbBold', fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                formInput(txtKeterangan, 'Keterangan'),
                formInput(txtJumlah, 'Jumlah Transfer'),
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
                                      firstDate: DateTime(1970),
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
                                hintText: "Tanggal Transfer",
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
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: RaisedButton(
                            color: Config.textWhite,
                            onPressed: () {
                              getImage(context);
                            },
                            child: Text(
                              'Pilih Gambar',
                              style: TextStyle(
                                  color: Config.primary,
                                  fontSize: 14,
                                  fontFamily: 'AirbnbMedium'),
                            ),
                          ),
                        )
                      ],
                    )),
                showImage(),
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
                            if (txtKeterangan.text.isEmpty) {
                              Config.alert(0, 'Harap memasukkan Keterangan');
                            } else if (txtTglMulai.text.isEmpty) {
                              Config.alert(0, 'Harap memasukkan harga deal');
                            } else {
                              simpanLaporan();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Unggah',
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
