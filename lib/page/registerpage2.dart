import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:kwamobile/page/konfirmasiregister.dart';
import 'package:sizer/sizer.dart';

class RegisterPage2 extends StatefulWidget {
  final String norek;
  final String nik;
  final String nohp;
  const RegisterPage2(
      {super.key, required this.nik, required this.norek, required this.nohp});

  @override
  State<RegisterPage2> createState() => _RegisterPageState2();
}

class _RegisterPageState2 extends State<RegisterPage2> {
  @override
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = false;

  

  bool containsNumber(String input) {
    // Mengecek apakah terdapat angka dalam string menggunakan regex
    return RegExp(r'\d').hasMatch(input);
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
                  // height: 40.h,
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buatlah Username dan Password akun anda :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Username :',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r'\s')), // Mengabaikan spasi
                          ],
                          controller: username,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(), // Set border here
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'Password :',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        TextFormField(
                          obscureText: _isObscure2,

                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r'\s')), // Mengabaikan spasi
                          ],
                          controller: password,
                          // obscureText: true,
                          // maxLength: 10,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
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
                                String username_ = username.text;
                                String password_ = password.text;

                                String nik = widget.nik;
                                String nohp = widget.nohp;
                                String norek = widget.norek;

                                bool containsNumberUser =
                                    containsNumber(username_);
                                bool containsNumberPass =
                                    containsNumber(password_);

                                if (containsNumberUser == true &&
                                    containsNumberPass == true) {
                                  if (username_.length >= 8 &&
                                      password_.length >= 8) {
                                    String pesanerror = '';
                                    if (username_.isEmpty ||
                                        password_.isEmpty) {
                                      pesanerror = 'ada data yang belum di isi';
                                    }

                                    if (pesanerror == '') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  KonfirmasiRegister(
                                                    username: username_,
                                                    password: password_,
                                                    norek: norek,
                                                    nohp: nohp,
                                                    nik: nik,
                                                  )));
                                    } else {
                                      EasyLoading.showError(pesanerror);
                                    }
                                  } else {
                                    EasyLoading.showInfo(
                                        'Minimal Panjang username dan password 8 huruf dan kombinasi angka s');
                                  }
                                } else {
                                  EasyLoading.showInfo(
                                      'Minimal Panjang username dan password 8 huruf dan kombinasi angka');
                                }
                              },
                              child: Text('Selanjutnya',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                            ),
                          ],
                        )
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
