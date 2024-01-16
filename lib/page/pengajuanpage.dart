import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kwamobile/page/pengajuanguru.dart';
import 'package:kwamobile/page/pengajuanjaminanpage.dart';
import 'package:kwamobile/page/pengajuankaryawan.dart';
import 'package:kwamobile/page/pengajuankendaraan.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class PengajuanOnline extends StatefulWidget {
  const PengajuanOnline({super.key, required this.name});

  final String name;

  @override
  State<PengajuanOnline> createState() => _PengajuanOnlineState();
}

class _PengajuanOnlineState extends State<PengajuanOnline> {
  Future<String> checkDataPengajuan() async {
    await Hive.initFlutter();
    var datalocal = await Hive.openBox('datalocal');
    String cif = await datalocal.get('cif');
    // Ganti URL dengan URL API Anda
    String apiUrl =
        "http://ksp-warnaartha.co.id/kwamobile/get_checkpengajuan.php";

    // Ganti dengan parameter yang sesuai
    Map<String, String> queryParams = {
      'token': "a3402327bd7823c778cee59533a2ceb5",
      'cif': cif,
    };

    // Gabungkan URL dengan parameter
    Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);
    try {
      // Lakukan permintaan HTTP GET
      final response = await http.get(uri);

      // Periksa status kode respons
      if (response.statusCode == 200) {
        // Ubah respons JSON menjadi map
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Ambil nilai dari kunci "message"
        String message = jsonResponse['message'];

        return message;
      } else {
        return "Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (error) {
      return "Error: $error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pengajuan Online',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () async {
                      EasyLoading.show();
                      String result = await checkDataPengajuan();

                      print(result);

                      if (result == "Data ada") {
                        EasyLoading.showInfo(
                            'Kamu bisa mengajukan kembali setelah 1 bulan sejak pengajuan terakhir');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PengajuanLoanJaminan(
                                      nama: widget.name,
                                      jenispinjaman: 'Pinjaman MultiGuna',
                                      jaminan: true,
                                    )));
                      }
                      EasyLoading.dismiss();
                    },
                    child: Container(
                      width: 75.w,
                      height: 12.h,
                      decoration: ShapeDecoration(
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                          color: Color(0xFF50B94C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 13.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .white, // Ganti warna sesuai kebutuhan
                                  ),
                                  child: Container(
                                    color: Color(0xFF50B94C),
                                    child: Image.asset(
                                      'lib/assets/image/kwa.png',
                                      fit: BoxFit.contain,

                                      // width: 5.0.w, // Atur lebar gambar
                                      height: 3.h, //
                                    ),
                                  ),
                                  // Isi kontainer Anda di sini
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pinjaman Multiguna',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Segoe UI',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () async {
                      EasyLoading.show();
                      String result = await checkDataPengajuan();

                      print(result);

                      if (result == "Data ada") {
                        EasyLoading.showInfo(
                            'Kamu bisa mengajukan kembali setelah 1 bulan sejak pengajuan terakhir');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PengajuanKaryawan(
                                      jenispinjaman: 'Pinjaman Karyawan',
                                      name: widget.name,
                                      jaminan: false,
                                    )));
                      }
                    },
                    child: Container(
                      width: 75.w,
                      height: 12.h,
                      decoration: ShapeDecoration(
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                          color: Color(0xFF50B94C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 13.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .white, // Ganti warna sesuai kebutuhan
                                  ),
                                  child: Container(
                                    color: Color(0xFF50B94C),
                                    child: Image.asset(
                                      'lib/assets/image/kkw.png',
                                      fit: BoxFit.contain,

                                      // width: 5.0.w, // Atur lebar gambar
                                      height: 3.h, //
                                    ),
                                  ),
                                  // Isi kontainer Anda di sini
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pinjaman Karyawan',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Segoe UI',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () async {
                      EasyLoading.show();
                      String result = await checkDataPengajuan();

                      print(result);

                      if (result == "Data ada") {
                        EasyLoading.showInfo(
                            'Kamu bisa mengajukan kembali setelah 1 bulan sejak pengajuan terakhir');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PengajuanGuru(
                                      jenispinjaman: 'Pinjaman Guru',
                                      name: widget.name,
                                      jaminan: false,
                                    )));
                      }
                    },
                    child: Container(
                      width: 75.w,
                      height: 12.h,
                      decoration: ShapeDecoration(
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                          color: Color(0xFF50B94C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 13.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .white, // Ganti warna sesuai kebutuhan
                                  ),
                                  child: Container(
                                    color: Color(0xFF50B94C),
                                    child: Image.asset(
                                      'lib/assets/image/guru.png',
                                      fit: BoxFit.contain,

                                      // width: 5.0.w, // Atur lebar gambar
                                      height: 3.h, //
                                    ),
                                  ),
                                  // Isi kontainer Anda di sini
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pinjaman Guru',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Segoe UI',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () async {
                      EasyLoading.show();
                      String result = await checkDataPengajuan();

                      print(result);

                      if (result == "Data ada") {
                        EasyLoading.showInfo(
                            'Kamu bisa mengajukan kembali setelah 1 bulan sejak pengajuan terakhir');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PengajuanKendaraan(
                                      jenispinjaman: 'Kredit Kendaraan Motor',
                                      name: widget.name,
                                      jaminan: false,
                                    )));
                      }
                    },
                    child: Container(
                      width: 75.w,
                      height: 12.h,
                      decoration: ShapeDecoration(
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                          color: Color(0xFF50B94C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 13.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .white, // Ganti warna sesuai kebutuhan
                                  ),
                                  child: Container(
                                    color: Color(0xFF50B94C),
                                    child: Image.asset(
                                      'lib/assets/image/kkb.png',
                                      fit: BoxFit.contain,

                                      // width: 5.0.w, // Atur lebar gambar
                                      height: 3.h, //
                                    ),
                                  ),
                                  // Isi kontainer Anda di sini
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kredit Kendaraan',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Segoe UI',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
