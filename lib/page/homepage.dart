import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kwamobile/page/listpage.dart';
import 'package:kwamobile/page/listpengaturan.dart';
import 'package:kwamobile/page/pengajuanpage.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

final List<String> imgList = [
  'lib/assets/image/slide1.png',
  'lib/assets/image/slide2.png',
  'lib/assets/image/slide3.png',
  'lib/assets/image/slide4.png',
];

// final List<String> imgList = [
//   'lib/assets/image/slide1.png',
//   'lib/assets/image/slide1.png',
//   'lib/assets/image/slide1.png',
//   'lib/assets/image/slide1.png',
//   'http://ksp-warnaartha.co.id/kwamobile/slide2.png',
//   'http://ksp-warnaartha.co.id/kwamobile/slide3.png',
//   'http://ksp-warnaartha.co.id/kwamobile/slide4.png',
// ];

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.name});
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      helpText: 'tes',
      firstDate: DateTime(2024),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
        print(formattedDate);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  // late List<String> imgList;

  // late List<Widget> imageSliders;

  String token = '';
  String cif = '';
  void getdata() async {
    EasyLoading.show();
    await Hive.initFlutter();
    var datalocal = await Hive.openBox('datalocal');
    // String id = datalocal.get('idhp');
    token = '';
    cif = datalocal.get('cif');
    token = datalocal.get('token');
    print(token);
    print(cif);
    EasyLoading.dismiss();
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   colors: [
                              //     Color.fromARGB(200, 0, 0, 0),
                              //     Color.fromARGB(0, 0, 0, 0)
                              //   ],
                              //   begin: Alignment.bottomCenter,
                              //   end: Alignment.topCenter,
                              // ),
                              ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(224, 253, 230, 1),
      // appBar: AppBar(
      //   title: Text('Judul'),
      // ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          SizedBox(
            height: 2.5.h,
          ),
          Container(
            alignment: Alignment.centerRight,
            width: 100.w,
            height: 5.h,
            // color: Colors.green,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'lib/assets/image/logo_koperasi.png',
                  fit: BoxFit.fill,
                  // width: 5.0.w, // Atur lebar gambar
                  height: 3.h, //
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  'KWA Mobile',
                  style: TextStyle(
                    color: Color(0xFF50B94C),
                    fontSize: 20,
                    fontFamily: 'Segoe UI',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 10.h,
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
            padding: EdgeInsets.all(8),
            child: Column(children: [
              Row(
                children: [
                  Container(
                    width: 13.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Ganti warna sesuai kebutuhan
                    ),
                    child: Icon(Icons.person, color: Colors.green, size: 25.sp),
                    // Isi kontainer Anda di sini
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: Colors.yellow,
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
          if (imageSliders.isEmpty)
            // You might want to show a loading indicator or handle this case
            CircularProgressIndicator()
          else
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 15.h,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
            ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPage(
                        nasabahCode: cif,
                        token:
                            'a3402327bd7823c778cee59533a2ceb5', // ini token khusus
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(children: [
                    Text(
                      'Cek Transaksi',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                          fontSize: 12.sp),
                    )
                  ]),
                  width: 55.w,
                  height: 6.7.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.green, // Ganti warna sesuai kebutuhan
                        width: 3.0, // Ganti ketebalan sesuai kebutuhan
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PengajuanOnline(
                                name: widget.name,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(children: [
                    Text(
                      'Pengajuan Online',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                          fontSize: 12.sp),
                    )
                  ]),
                  width: 55.w,
                  height: 6.7.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.green, // Ganti warna sesuai kebutuhan
                        width: 3.0, // Ganti ketebalan sesuai kebutuhan
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListPengaturan()));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(children: [
                    Text(
                      'Pengaturan',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                          fontSize: 12.sp),
                    )
                  ]),
                  width: 55.w,
                  height: 6.7.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.green, // Ganti warna sesuai kebutuhan
                        width: 3.0, // Ganti ketebalan sesuai kebutuhan
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
