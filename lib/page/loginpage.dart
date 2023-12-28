import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kwamobile/page/homepage.dart';
import 'package:kwamobile/page/registerpage.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  String token = '';
  bool loginok = false;

  bool munculregister = true;

  String calculateMD5(String input) {
    // Convert the input string to bytes
    List<int> inputBytes = utf8.encode(input);

    // Create an MD5 hash
    Digest md5Hash = md5.convert(inputBytes);

    // Convert the hash to a hex string
    String md5HashString = md5Hash.toString();

    return md5HashString;
  }

  void getdata() async {
    EasyLoading.show();
    await Hive.initFlutter();
    var datalocal = await Hive.openBox('datalocal');
    // String id = datalocal.get('idhp');
    // String cif = datalocal.get('cif')\
    try {
      token = datalocal.get('token');
    } catch (e) {
      munculregister = false;
      print(e);
    }

    if (token == null) {
      munculregister = false;

      setState(() {});
    }
    setState(() {});
    EasyLoading.dismiss();
    print(token);
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    EasyLoading.show();
    final String apiUrl =
        'http://ksp-warnaartha.co.id/kwamobile/post_loginuser.php'; // Ganti URL sesuai dengan lokasi Anda

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'username': calculateMD5(usernameController.text),
        'password': calculateMD5(passwordController.text),
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        String name = responseData['user']['name'];

        // Login berhasil
        loginok = true;
        print('Login berhasil. Data pengguna: ${responseData['user']['id']}');
        EasyLoading.dismiss();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      name: name,
                    )),
            (route) => false);
      } else {
        // Login gagal
        EasyLoading.showError(
            'Login gagal error :  ${responseData['message']} ');
        print('Login gagal. Pesan: ${responseData['message']}');
      }
    } else {
      EasyLoading.showError('Login gagal error :  ${response.statusCode} ');
      // Gagal melakukan permintaan ke server
      print(
          'Gagal melakukan permintaan ke server. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assets/image/logo_koperasi.png',
                    fit: BoxFit.fill,
                    width: 100.0, // Atur lebar gambar
                    height: 100.0, //
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Text(
                    'Selamat Datang di',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    'KWA Mobile',
                    style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                  SizedBox(
                    height: 8.h,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // const SizedBox(width: 20.0, height: 100.0),
                        const Text(
                          'Dapatkan',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        const SizedBox(width: 20.0, height: 100.0),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 27.0,
                            // fontWeight: FontWeight.bold,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText('Pinjaman Konsumtif',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              RotateAnimatedText('Tabungan Paket',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              RotateAnimatedText('Kredit Kendaraan',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              RotateAnimatedText('Tabungan Hari Raya',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              RotateAnimatedText('Pinjaman Karyawan',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              RotateAnimatedText('Tabungan Umroh',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (munculregister == true)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username :',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true, // dont forget
                                border: OutlineInputBorder(), // Set border here
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Password :',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              // maxLength: 10,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true, // dont forget
                                border: OutlineInputBorder(), // Set border here
                              ),
                            ),
                            SizedBox(
                              height: 1.2.h,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                loginUser();
                              },
                              child: Text('Masuk'),
                              style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  textStyle: TextStyle(
                                    // Atur ukuran teks di sini
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp,
                                  ),
                                  // Atur warna latar belakang di sini
                                  backgroundColor: Colors.white,
                                  // Atur warna teks (opsional)
                                  foregroundColor: Colors.green),
                            ),
                          ]),
                    ),
                  if (munculregister == false)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text('Daftar'),
                      style: ElevatedButton.styleFrom(
                          elevation: 8,
                          textStyle: TextStyle(
                            // Atur ukuran teks di sini
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                          // Atur warna latar belakang di sini
                          backgroundColor: Colors.white,
                          // Atur warna teks (opsional)
                          foregroundColor: Colors.green),
                    ),
                ]),
          ),
        ],
      ),
    );
  }
}
