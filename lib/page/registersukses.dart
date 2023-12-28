import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kwamobile/page/loginpage.dart';
import 'package:sizer/sizer.dart';

class RegisterSukses extends StatefulWidget {
  const RegisterSukses({super.key});

  @override
  State<RegisterSukses> createState() => _RegisterSuksesState();
}

class _RegisterSuksesState extends State<RegisterSukses> {
  @override
  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    await Hive.initFlutter();
    var datalocal = await Hive.openBox('datalocal');
    String id = datalocal.get('idhp');
    String cif = datalocal.get('cif');
    String token = datalocal.get('token');
    print(id + cif + token);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Daftar',
                  style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Text(
                    'Hanya bisa mendaftar bagi yang sudah menjadi anggota KSP Warna Artha',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  alignment: Alignment.topLeft,
                  width: 90.w,
                  height: 36.h,
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pendaftaran sudah berhasil anda sudah bisa menggunakan KWA Mobile',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            child: Text('Login')),
                      ]),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
