import 'package:flutter/material.dart';
import 'package:lesin_app/auth/editProfil.dart';
import 'package:lesin_app/auth/login.dart';
import 'package:lesin_app/auth/register.dart';
import 'package:lesin_app/auth/splash.dart';
import 'package:lesin_app/siswa/home/home.dart';
import 'package:lesin_app/siswa/kelas/absensi.dart';
import 'package:lesin_app/siswa/kelas/bookingKelas.dart';
import 'package:lesin_app/siswa/kelas/detailKelas.dart';
import 'package:lesin_app/siswa/kelas/jadwalKelas.dart';
import 'package:lesin_app/siswa/kelas/chat.dart';
import 'package:lesin_app/siswa/pembayaran/listPembayaran.dart';
import 'package:lesin_app/siswa/pembayaran/logPembayaran.dart';
import 'package:lesin_app/siswa/tentor/listTentor.dart';
import 'package:lesin_app/siswa/tentor/detailTentor.dart';
import 'package:lesin_app/tentor/home/home.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String LUPA_SANDI = '/lupa_sandi';
  static const String RESET_SANDI = '/reset_sandi';
  static const String HOME = '/home';
  static const String HOME_TENTOR = '/home_tentor';
  static const String UPDATE_PROFIL = '/updateProfil';
  static const String BOOKING_KELAS = '/booking_kelas';
  static const String LIST_TENTOR = '/list_tentor';
  static const String DETAIL_KELAS = '/detail_kelas';
  static const String DETAIL_TENTOR = '/detail_tentor';
  static const String ABSENSI = '/absensi';
  static const String PILIH_JADWAL = '/pilih_jadwal';
  static const String NEGO_TARIF = '/nego_tarif';
  static const String LIST_PEMBAYARAN = '/list_pembayaran';
  static const String LOG_PEMBAYARAN = '/log_pembayaran';
  static const String EDIT_PROFIL = '/edit_profil';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return PageTransition(
            child: LoginPage(), type: PageTransitionType.leftToRight);
      case REGISTER:
        return PageTransition(
            child: RegisterPage(), type: PageTransitionType.rightToLeft);
      case EDIT_PROFIL:
        return PageTransition(
            child: EditProfil(), type: PageTransitionType.rightToLeft);
      case LIST_PEMBAYARAN:
        return PageTransition(
            child: ListPembayaran(), type: PageTransitionType.rightToLeft);
      case LOG_PEMBAYARAN:
        return PageTransition(
            child: LogPembayaran(idKelas: settings.arguments,), type: PageTransitionType.rightToLeft);
      case HOME:
        return PageTransition(
            child: Home(
              indexPage: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case HOME_TENTOR:
        return PageTransition(
            child: HomeTentor(
              indexPage: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case BOOKING_KELAS:
        return PageTransition(
            child: BookingKelasPage(), type: PageTransitionType.fade);
      case LIST_TENTOR:
        return PageTransition(
            child: ListTentor(
              idDataMengajar: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case DETAIL_KELAS:
        return PageTransition(
            child: DetailKelas(
              idKelas: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case ABSENSI:
        return PageTransition(
            child: AbsensiPage(
              idKelas: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case DETAIL_TENTOR:
        return PageTransition(
            child: DetailTentor(
             param: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case PILIH_JADWAL:
        return PageTransition(
            child: JadwalKelas(
              param: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case NEGO_TARIF:
        return PageTransition(
            child: NegoTarif(param: settings.arguments,), type: PageTransitionType.rightToLeft);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Page ${settings.name} not defined'),
                  ),
                ));
    }
  }
}
