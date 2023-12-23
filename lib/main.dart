import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kwamobile/page/loginpage.dart';
import 'package:kwamobile/page/welcomepage.dart';
import 'package:sizer/sizer.dart';

void main() {
  int satu = 0;
  if (satu == 1) {
    runApp(const MyAppLogin());
  } else {
    runApp(const MyAppWelcome());
  }
}


class MyAppLogin extends StatelessWidget {
  const MyAppLogin({super.key});

  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    return Sizer(builder: (context, Orientation, DeviceType) {
      return MaterialApp(
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
        ),
        home: const WelcomePage(),
        builder: EasyLoading.init(),
      );
    });
  }
}
