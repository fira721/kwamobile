import 'package:flutter/material.dart';
import 'package:kwamobile/page/pengajuanjaminanpage.dart';
import 'package:kwamobile/page/pengajuankaryawan.dart';
import 'package:sizer/sizer.dart';

class PengajuanOnline extends StatefulWidget {
  const PengajuanOnline({super.key});

  @override
  State<PengajuanOnline> createState() => _PengajuanOnlineState();
}

class _PengajuanOnlineState extends State<PengajuanOnline> {
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PengajuanLoanJaminan(
                                    jenispinjaman: 'Pinjaman MultiGuna',
                                    jaminan: true,
                                  )));
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PengajuanKaryawan(
                                    jenispinjaman: 'Pinjaman Karyawan',
                                    jaminan: false,
                                  )));
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
                  Container(
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
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
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
                ],
              ),
            ),
          ],
        ));
  }
}
