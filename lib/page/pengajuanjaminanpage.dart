import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kwamobile/page/konfirmasipengajuan.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PengajuanLoanJaminan extends StatefulWidget {
  PengajuanLoanJaminan(
      {super.key,
      required this.jenispinjaman,
      required this.jaminan,
      required this.nama});

  final String jenispinjaman;
  final bool jaminan;
  final String nama;

  @override
  State<PengajuanLoanJaminan> createState() => _PengajuanLoanJaminanState();
}

class _PengajuanLoanJaminanState extends State<PengajuanLoanJaminan> {
  Future<void> postPengajuanData(


      String apiToken,
      String nama,
      String cif,
      String jenisPinjaman,
      int nominal,
      String tujuan,
      String jenisJaminan,
      String keteranganJaminan,
      String pekerjaan,
      String nohp,
      String cabang,
      String keterangan) async {
    final String apiUrl =
        'http://ksp-warnaartha.co.id/kwamobile/post_pengajuan.php'; // Update the URL with your actual API endpoint

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'api_token': apiToken,
          'nama': nama,
          'cif': cif,
          'jenis_pinjaman': jenisPinjaman,
          'nominal': nominal.toString(),
          'tujuan': tujuan,
          'jenis_jaminan': jenisJaminan,
          'keterangan_jaminan': keteranganJaminan,
          'pekerjaan': pekerjaan,
          'nohp': nohp,
          'cabang': cabang,
          'keterangan': keterangan, // New parameter
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => KonfirmasiPengajuan()));
      } else {
        EasyLoading.showError('Error : Semua data harus di isi');
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
       EasyLoading.showError('Error : Semua data harus di isi');
      print('Error: $error');
    }
  }

  double _value = 0.0;

  String valuejaminan = 'Sertifikat Tanah/Bangunan';

  List listjaminan = [
    "Sertifikat Tanah/Bangunan",
    "BPKB",
    "Tabungan",
  ];

  String valuetujuan = 'Konsumtif';

  List listtujuan = [
    "Konsumtif",
    "Biaya Pendidikan",
    "Biaya Kesehatan",
    "Biaya Renovasi",
    "Pembelian Barang",
  ];

  TextEditingController keteranganJaminan = TextEditingController();
  TextEditingController pekerjaan = TextEditingController();
  TextEditingController nohp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(
          widget.jenispinjaman,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              SizedBox(
                height: 2.h,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilih Nominal yang kamu inginkan',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp),
                  )),
              SizedBox(
                height: 1.h,
              ),
              Container(
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
                child: Column(children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  if (_value != 1000.0)
                    Text(
                      'Rp. ${_value.toInt().toString()} Juta',
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  else
                    Text(
                      '1 Miliar',
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  Container(
                      child: SfSlider(
                    min: 1,
                    max: 1000,
                    value: _value,
                    interval: 20,
                    numberFormat: NumberFormat('\$'),
                    showTicks: false,
                    showLabels: false,
                    enableTooltip: false,
                    inactiveColor: Colors.white,
                    minorTicksPerInterval: 1,
                    activeColor: Colors.yellow,
                    onChanged: (dynamic value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ))
                ]),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tujuan Pinjaman :'),
                      DropdownButton<String>(
                        hint: Text("Select Your Friends"),
                        value: valuetujuan,
                        items: listtujuan.map((value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            valuetujuan = value!;
                          });
                        },
                      ),
                      if (widget.jaminan == true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Jaminan :'),
                            DropdownButton<String>(
                              hint: Text("Select Your Friends"),
                              value: valuejaminan,
                              items: listjaminan.map((value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  valuejaminan = value!;
                                });
                              },
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text('Keterangan jaminan :'),
                            TextFormField(
                              controller: keteranganJaminan,
                              decoration: InputDecoration(
                                fillColor: Colors.green,
                                focusColor: Colors.green,
                                border: OutlineInputBorder(), // Set border here
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text('Pekerjaan/Usaha :'),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextFormField(
                        controller: pekerjaan,
                        decoration: InputDecoration(
                          fillColor: Colors.green,
                          focusColor: Colors.green,
                          border: OutlineInputBorder(), // Set border here
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text('Nomor Handphone :'),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextFormField(
                        controller: nohp,
                        decoration: InputDecoration(
                          fillColor: Colors.green,
                          focusColor: Colors.green,
                          border: OutlineInputBorder(), // Set border here
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            // await postPengajuanData(
                            //     "a3402327bd7823c778cee59533a2ceb5",
                            //     "John Doe",
                            //     "12345",
                            //     'KWA',
                            //     10000,
                            //     "Business",
                            //     "Gold",
                            //     "Description of Jaminan",
                            //     "Engineer",
                            //     "1234567890",
                            //     "Cabang");
                            EasyLoading.show();

                            await Hive.initFlutter();
                            var datalocal = await Hive.openBox('datalocal');
                            String cif = datalocal.get('cif');

                            String cabang = cif;

                            // Mengambil tiga huruf pertama
                            String kodecabang = cif.substring(0, 3);

                            await postPengajuanData(
                                "a3402327bd7823c778cee59533a2ceb5",
                                widget.nama,
                                cif,
                                widget.jenispinjaman,
                                _value.toInt(),
                                valuetujuan,
                                valuejaminan,
                                keteranganJaminan.text,
                                pekerjaan.text,
                                nohp.text,
                                kodecabang,
                                "-");
                                EasyLoading.dismiss();
                          },
                          child: Text(
                            'Kirim Pengajuan',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
