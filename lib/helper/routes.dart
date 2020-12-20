import 'package:flutter/material.dart';
import 'package:lesin_app/auth/editProfil.dart';
import 'package:lesin_app/auth/login.dart';
import 'package:lesin_app/auth/lupaSandi.dart';
import 'package:lesin_app/auth/register.dart';
import 'package:lesin_app/auth/resetPassword.dart';
import 'package:lesin_app/auth/splash.dart';
import 'package:lesin_app/siswa/chat/detailChat.dart';
import 'package:lesin_app/siswa/chat/listRoom.dart';
import 'package:lesin_app/siswa/home/home.dart';
import 'package:lesin_app/siswa/kelas/absensi.dart';
import 'package:lesin_app/siswa/kelas/bookingKelas.dart';
import 'package:lesin_app/siswa/kelas/detailKelas.dart';
import 'package:lesin_app/siswa/kelas/jadwalKelas.dart';
import 'package:lesin_app/siswa/kelas/chat.dart';
import 'package:lesin_app/siswa/kelas/kelasTentor.dart';
import 'package:lesin_app/siswa/modul/addModul.dart';
import 'package:lesin_app/siswa/modul/listModul.dart';
import 'package:lesin_app/siswa/pembayaran/listPembayaran.dart';
import 'package:lesin_app/siswa/pembayaran/logPembayaran.dart';
import 'package:lesin_app/siswa/tentor/listTentor.dart';
import 'package:lesin_app/siswa/tentor/detailTentor.dart';
import 'package:lesin_app/tentor/chat/detailChat.dart';
import 'package:lesin_app/tentor/chat/listRoom.dart';
import 'package:lesin_app/tentor/home/dompet.dart';
import 'package:lesin_app/tentor/home/home.dart';
import 'package:lesin_app/tentor/profile/dataDiri.dart';
import 'package:lesin_app/tentor/profile/dataMengajar.dart';
import 'package:lesin_app/tentor/profile/dataPrestasi.dart';
import 'package:lesin_app/tentor/profile/editProfile.dart';
import 'package:lesin_app/tentor/profile/riwayatPendidikan.dart';
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
  static const String DETAIL_KELAS_TENTOR = '/detail_kelas_tentor';
  static const String DETAIL_TENTOR = '/detail_tentor';
  static const String ABSENSI = '/absensi';
  static const String PILIH_JADWAL = '/pilih_jadwal';
  static const String NEGO_TARIF = '/nego_tarif';
  static const String LIST_PEMBAYARAN = '/list_pembayaran';
  static const String LOG_PEMBAYARAN = '/log_pembayaran';
  static const String EDIT_PROFIL = '/edit_profil';
  static const String LIST_CHAT_SISWA = '/chat_siswa';
  static const String LIST_CHAT_TENTOR = '/chat_tentor';
  static const String LIST_MODUL = '/list_modul';
  static const String ADD_MODUL = '/add_modul';
  static const String EDIT_PROFIL_TENTOR = '/edit_profil_tentor';
  static const String EDIT_DATA_DIRI = '/edit_data_diri';
  static const String DATA_MENGAJAR = '/data_mengajar';
  static const String RIWAYAT_PENDIDIKAN = '/riwayat_pendidikan';
  static const String DATA_PRESTASI = '/data_prestasi';
  static const String DETAIL_CHAT_TENTOR = '/detail_chat_tentor';
  static const String DETAIL_CHAT_SISWA = '/detail_chat_siswa';
  static const String DOMPET = '/dompet';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return PageTransition(
            child: LoginPage(), type: PageTransitionType.leftToRight);
      case LUPA_SANDI:
        return PageTransition(
            child: LupaSandi(), type: PageTransitionType.bottomToTop);
      case RESET_SANDI:
        return PageTransition(
            child: ResetPassword(idUser: settings.arguments,), type: PageTransitionType.bottomToTop);
      case REGISTER:
        return PageTransition(
            child: RegisterPage(), type: PageTransitionType.rightToLeft);
      case EDIT_PROFIL:
        return PageTransition(
            child: EditProfil(), type: PageTransitionType.rightToLeft);
      case DOMPET:
        return PageTransition(
            child: DompetTentor(), type: PageTransitionType.rightToLeft);
      case EDIT_PROFIL_TENTOR:
        return PageTransition(
            child: EditProfileTentor(), type: PageTransitionType.fade);
      case EDIT_DATA_DIRI:
        return PageTransition(
            child: DataDiri(), type: PageTransitionType.fade);
      case RIWAYAT_PENDIDIKAN:
        return PageTransition(
            child: RiwayatPendidikan(), type: PageTransitionType.fade);
      case DATA_PRESTASI:
        return PageTransition(
            child: DataPrestasi(), type: PageTransitionType.fade);
      case DATA_MENGAJAR:
        return PageTransition(
            child: DataMengajar(), type: PageTransitionType.fade);
      case LIST_PEMBAYARAN:
        return PageTransition(
            child: ListPembayaran(), type: PageTransitionType.rightToLeft);
      case LOG_PEMBAYARAN:
        return PageTransition(
            child: LogPembayaran(
              idKelas: settings.arguments,
            ),
            type: PageTransitionType.fade);
      case LIST_MODUL:
        return PageTransition(
            child: ListModul(
              idKelas: settings.arguments,
            ),
            type: PageTransitionType.fade);
      case ADD_MODUL:
        return PageTransition(
            child: TambahModul(
              idKelas: settings.arguments,
            ),
            type: PageTransitionType.fade);
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
      case DETAIL_KELAS_TENTOR:
        return PageTransition(
            child: DetailKelasTentor(
              idKelas: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case DETAIL_CHAT_TENTOR:
        return PageTransition(
            child: DetailChatTentor(
              idRoom: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case DETAIL_CHAT_SISWA:
        return PageTransition(
            child: DetailChatSiswa(
              idRoom: settings.arguments,
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
            child: NegoTarif(
              param: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft);
      case LIST_CHAT_SISWA:
        return PageTransition(
            child: ListRoomChat(), type: PageTransitionType.topToBottom);
      case LIST_CHAT_TENTOR:
        return PageTransition(
            child: ListRoomChatTentor(), type: PageTransitionType.topToBottom);
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
