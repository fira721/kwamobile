import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:kwamobile/page/loginpage.dart';
import 'package:kwamobile/page/welcomepage.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Box? datalocal;

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  datalocal = await Hive.openBox('datalocal');
  runApp(const MyAppLogin());
}

class MyAppLogin extends StatelessWidget {
  const MyAppLogin({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, Orientation, DeviceType) {
      return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('id'), // Ganti dengan kode bahasa yang diinginkan
        ],
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        builder: EasyLoading.init(),
      );
    });
  }
}

class MyAppWelcome extends StatelessWidget {
  const MyAppWelcome({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, Orientation, DeviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          
        ),
        home: const WelcomePage(),
        builder: EasyLoading.init(),
      );
    });
  }
}
