import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kwamobile/page/konfirmasipengajuan.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PengajuanLoanJaminan extends StatefulWidget {
  const PengajuanLoanJaminan(
      {super.key, required this.jenispinjaman, required this.jaminan});

  final String jenispinjaman;
  final bool jaminan;
  @override
  State<PengajuanLoanJaminan> createState() => _PengajuanLoanJaminanState();
}

class _PengajuanLoanJaminanState extends State<PengajuanLoanJaminan> {
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        KonfirmasiPengajuan()));
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
