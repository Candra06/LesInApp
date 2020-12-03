import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lesin_app/helper/config.dart';
import 'package:lesin_app/siswa/home/dashboard.dart';
import 'package:lesin_app/siswa/home/kelas.dart';
import 'package:lesin_app/siswa/home/profile.dart';
import 'package:lesin_app/tentor/home/dashboard.dart';
import 'package:lesin_app/tentor/home/kelas.dart';
import 'package:lesin_app/tentor/home/profile.dart';

class HomeTentor extends StatefulWidget {
  final String indexPage;
  HomeTentor({this.indexPage});
  @override
  _HomeTentorState createState() => _HomeTentorState();
}

class _HomeTentorState extends State<HomeTentor> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda yakin?'),
            content: new Text('Ingin keluar dari aplikasi ini.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Tidak'),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text('Iya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void page() {
    setState(() {
      currentIndex = int.parse(widget.indexPage);
    });
  }

  int currentIndex = 0, lasttab = 0;

  void incrementTab(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    page();
    super.initState();
  }

  final List<Widget> screens = [
    DashboardTentorPage(),
    KelasTentorSide(),
    SideProfileTentor(),
  ];
  Widget currentScreen = DashboardPage();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: Config.primary,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: new Text(
                    'Beranda',
                    style: TextStyle(fontFamily: 'AirbnbMedium'),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), title: new Text('Kelas', style: TextStyle(fontFamily: 'AirbnbMedium'),)),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  title: new Text('Profil', style: TextStyle(fontFamily: 'AirbnbMedium'),))
            ],
            onTap: (index) {
              setState(() {
                lasttab = currentIndex;
                currentIndex = index;
                currentScreen = screens[index];
              });
            },
          )),
    );
  }
}
