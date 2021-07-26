import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/helper/input.dart';
import 'package:http/http.dart' as http;
import 'package:lesin_app/helper/size.dart';

class DialogTF extends StatefulWidget {
  final String idKelas;
  final String harga;
  DialogTF({this.idKelas, this.harga});
  @override
  _DialogTFState createState() => _DialogTFState();
}

class _DialogTFState extends State<DialogTF> with TickerProviderStateMixin {
  TextEditingController txtKeterangan = new TextEditingController();
  TextEditingController txtTglMulai = new TextEditingController();
  TextEditingController txtJumlah = new TextEditingController();
  TextEditingController txtRekening = new TextEditingController();
  DateTime tglMulai;
  String fileName = '';
  Future<File> foto;
  String base64Image;
  File tmpFile;
  List<String> _rekening = new List();
  Future<File> file;

  List<String> listRekening = new List();
  List<String> idRekening = new List();
  String getRekening = '';

  void getDataRekening() async {
    String token = await Config.getToken();
    http.Response req = await http.get(Uri.parse(Config.ipServerAPI + 'rekening'), headers: {'Authorization': 'Bearer $token'});
    print(req.body);
    if (req.statusCode == 200) {
      var data = json.decode(req.body);
      List<String> val = new List();
      List<String> idMpl = new List();
      List<String> rek = new List();
      List tmp = data['data'];
      for (var i = 0; i < tmp.length; i++) {
        val.add(tmp[i]['nama_rekening'] + '(' + tmp[i]['bank'] + ')');
        idMpl.add(tmp[i]['id'].toString());
        rek.add(tmp[i]['nomor_rekening'].toString());
      }
      setState(() {
        _rekening = rek;

        listRekening = val;
        idRekening = idMpl;
      });
    } else {
      setState(() {
        Config.alert(0, 'Gagal memuat data');
      });
    }
  }

  getImage(context) async {
    final picker = ImagePicker();
    PickedFile pickedFile;
    final imgSrc = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pilih sumber gambar"),
        actions: <Widget>[
          MaterialButton(
            child: Text("Kamera"),
            onPressed: () async {
              Navigator.pop(context, ImageSource.camera);
              // foto = picker.getImage(source: ImageSource.camera);
              pickedFile = await picker.getImage(source: ImageSource.camera);

              print('fotonya ' + pickedFile.path);
              print(foto);
            },
            // onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          MaterialButton(
              child: Text("Galeri"),
              onPressed: () async {
                Navigator.pop(context, ImageSource.gallery);
                pickedFile = await picker.getImage(source: ImageSource.gallery);

                setState(() {
                  // foto = picker.getImage(source: ImageSource.gallery);
                  fileName = pickedFile.path.toString();
                  tmpFile = File(pickedFile.path);
                });
              })
        ],
      ),
    );
  }

  Widget showImage() {
    // tmpFile = snapshot.data;
    String name = fileName.split("/").last;

    if (fileName == null) {
      return Container(
        margin: EdgeInsets.only(top: 5, left: 8),
        child: Column(
          children: <Widget>[Text('Pilih bukti transfer')],
        ),
      );
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 5, left: 8),
          alignment: Alignment.center,
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ));
    }
  }

  void simpanLaporan() async {
    Config.loading(context);
    String token = '';
    var tmp = await Config.getToken();
    setState(() {
      token = tmp;
    });
    Map<String, String> headers = {'Authorization': 'Bearer $token', 'Accept': 'application/json'};
    print(tmpFile.path.toString());

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse(Config.ipServerAPI + 'pembayaran'),
    );
    imageUploadRequest.files.add(await http.MultipartFile.fromPath('bukti_tf', tmpFile.path));
    imageUploadRequest.headers.addAll(headers);
    imageUploadRequest.fields['id_kelas'] = widget.idKelas;
    imageUploadRequest.fields['harga_deal'] = widget.harga;
    imageUploadRequest.fields['keterangan'] = txtKeterangan.text;
    imageUploadRequest.fields['tanggal_bayar'] = txtTglMulai.text;
    imageUploadRequest.fields['jumlah_bayar'] = txtJumlah.text;
    imageUploadRequest.fields['id_rekening'] = getRekening;
    var res = await imageUploadRequest.send();
    var conf = res.reasonPhrase;
    print("resnya " + conf.toString());
    print(res.statusCode);
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
    print(widget.idKelas);
    getDataRekening();
    super.initState();
  }

  Widget _customPopupItemBuilderExample(BuildContext context, dynamic item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item),
        subtitle: Text(_rekening[listRekening.indexOf(item)]),
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
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[Config.primary, Config.secondary, Config.darkPrimary])),
        ),
        title: Text(
          'Form Transfer',
          style: TextStyle(fontFamily: 'AirbnbMedium'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(top: 8),
                width: displayWidth(context),
                height: 50,
                child: DropdownSearch(
                  mode: Mode.DIALOG,
                  searchBoxController: txtRekening,
                  showSearchBox: true,
                  showSelectedItem: true,
                  items: listRekening == null ? ['Pilih Rekening'] : listRekening,
                  label: "Rekening Tujuan",
                  hint: "Pilih Rekening Tujuan",
                  popupItemBuilder: _customPopupItemBuilderExample,

                  popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (value) {
                    setState(() {
                      // nmMpl = value;
                      getRekening = idRekening[listRekening.indexOf(value)];
                      print(getRekening);
                    });
                  },
                  // selectedItem: ,
                )),
            formInput(txtKeterangan, 'Keterangan'),
            formInputType(txtJumlah, 'Jumlah Transfer', TextInputType.number),
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
                                  String tanggal = tglMulai.toString().replaceAll("00:00:00.000", "");
                                  print(tanggal);
                                  print(Config.formattanggal(tanggal.toString()));
                                  txtTglMulai.text = Config.formattanggal(tglMulai.toString().replaceAll("00:00:00.000", ""));
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
                          style: TextStyle(color: Config.primary, fontSize: 14, fontFamily: 'AirbnbMedium'),
                        ),
                      ),
                    )
                  ],
                )),
            showImage(),
            Container(
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
                  } else if (getRekening == '') {
                    Config.alert(0, 'Harap memasukkan harga deal');
                  } else {
                    simpanLaporan();
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white, fontFamily: 'AirbnbBold', fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
