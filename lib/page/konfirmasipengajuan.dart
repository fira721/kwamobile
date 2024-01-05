import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class KonfirmasiPengajuan extends StatefulWidget {
  const KonfirmasiPengajuan({super.key});

  @override
  State<KonfirmasiPengajuan> createState() => _KonfirmasiPengajuanState();
}

class _KonfirmasiPengajuanState extends State<KonfirmasiPengajuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengajuan Sukses',
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
              'Pengajuan Terkirim',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
                'Pengajuan anda telah kami terima, Seles kami akan segera menghubungi anda.')
          ],
        )),
      ),
    );
  }
}
