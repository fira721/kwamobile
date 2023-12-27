import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kwamobile/page/registerpage2.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController norek = TextEditingController();
    TextEditingController nik = TextEditingController();
    TextEditingController nohp = TextEditingController();

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
                  height: 50.h,
                  padding: EdgeInsets.all(15),
                  child: Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomor Anggota/rekening tabungan :',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: norek,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(), // Set border here
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Text(
                            'Nomor NIK :',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: nik,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(), // Set border here
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Text(
                            'Nomor handphone :',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: nohp,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(), // Set border here
                            ),
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Kembali'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String norek_ = norek.text;
                                  String nik_ = nik.text;
                                  String nohp_ = nohp.text;

                                  String pesanerror = '';
                                  if (norek_.isEmpty ||
                                      nik_.isEmpty ||
                                      nohp_.isEmpty) {
                                    pesanerror = 'ada data yang belum di isi';
                                  }

                                  if (pesanerror == '') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RegisterPage2(
                                                  nik: nik_,
                                                  nohp: nohp_,
                                                  norek: norek_,
                                                )));
                                  } else {
                                    EasyLoading.showError(pesanerror);
                                  }
                                },
                                child: Text('Selanjutnya'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
