import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kwamobile/page/registerpage2.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool dataAkun = false;

  Future<Map<String, dynamic>> getUserData(String nik, String tokenApi,
      String nik_, String nohp_, String norek_) async {
    final String apiUrl =
        "http://ksp-warnaartha.co.id/kwamobile/get_checkuserdata.php";

    try {
      final response =
          await http.get(Uri.parse('$apiUrl?nik=$nik&token_api=$tokenApi'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success' && data['message'] == 'data:ada') {
          print('ada');
          dataAkun = true;
          // Proses data jika ditemukan
          EasyLoading.showInfo(
              duration: Duration(seconds: 10),
              dismissOnTap: true,
              'Data nik ini sudah terdaftar, hubungi kolektor kami atau kunjungi kantor KSP Warna Artha, untuk aktivasi akun kembali, info lebih lanjut hubungi (021) 5315 7264');
          return {'success': true, 'data': data};
        } else {
          dataAkun = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterPage2(
                        nik: nik_,
                        nohp: nohp_,
                        norek: norek_,
                      )));
          print('tidak ada');
          // Handle situasi jika status tidak sesuai atau pesan tidak sesuai
          return {'success': false, 'data': data};
        }
      } else {
        dataAkun = false;
        print('error');
        // Handle jika responsenya bukan 200 OK
        return {
          'success': false,
          'data': {
            'status': 'error',
            'message': 'HTTP Error ${response.statusCode}'
          }
        };
      }
    } catch (e) {
      // Handle jika terjadi kesalahan lainnya
      return {
        'success': false,
        'data': {'status': 'error', 'message': '$e'}
      };
    }
  }

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
                  // height: 51.5.h,
                  padding: EdgeInsets.all(15),
                  child: Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomor rekening di KSP Warna Artha :',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          TextFormField(
                            maxLength: 15,
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
                            maxLength: 16,
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
                          Text(
                            'No Hp minimal 10 angka dan diawali dengan angka 0',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            height: 1.2.h,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Kembali',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  String norek_ = norek.text;
                                  String nik_ = nik.text;
                                  String nohp_ = nohp.text;

                                  String pesanerror = '';
                                  if (norek_.isEmpty ||
                                      nik_.isEmpty ||
                                      nohp_.isEmpty) {
                                    pesanerror = 'ada data yang belum di isi';
                                  }
                                  // await getUserData(
                                  //     nik_, 'a3402327bd7823c778cee59533a2ceb5');

                                  if (nohp_.length >= 10) {
                                    print('ok');
                                  } else {
                                    pesanerror = 'no hp';
                                  }

                                  if (nik_.length == 16) {
                                    print('ok');
                                  } else {
                                    pesanerror = 'nik';
                                  }

                                  if (norek_.length == 15) {
                                    print('ok');
                                  } else {
                                    pesanerror = 'norek';
                                  }

                                  if (pesanerror == '') {
                                    await getUserData(
                                        nik_,
                                        'a3402327bd7823c778cee59533a2ceb5',
                                        nik_,
                                        nohp_,
                                        norek_);
                                    print('data ok');
                                  } else {
                                    EasyLoading.showError(
                                        'ada data yang belum sesuai');
                                  }
                                },
                                child: Text(
                                  'Selanjutnya',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                              ),
                            ],
                          ),
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
