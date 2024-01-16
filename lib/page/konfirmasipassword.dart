import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class KonfirmasiPassword extends StatefulWidget {
  const KonfirmasiPassword({super.key});

  @override
  State<KonfirmasiPassword> createState() => _KonfirmasiPasswordState();
}

class _KonfirmasiPasswordState extends State<KonfirmasiPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pergantian Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 90.sp,
            ),
            Text(
              'Pergantian Password Anda Berhasil',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text('Anda sudah bisa login menggunakan password baru.'),
            SizedBox(
              height: 3.h,
            ),
            ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text(
                  'Kembali',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        )),
      ),
    );
  }
}
