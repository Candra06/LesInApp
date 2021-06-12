import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lesin_app/helper/appConfig.dart';
import 'package:lesin_app/helper/routes.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(AppConfig(appName: "BelajardiRumah", flavorName: "dev", initialRoute: Routes.SPLASH, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var initialRoute = AppConfig.of(context).initialRoute;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: initialRoute,
      title: 'BelajardiRumah',
    );
  }

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }
}
