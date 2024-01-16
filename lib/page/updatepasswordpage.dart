import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:kwamobile/page/konfirmasipassword.dart';
import 'package:sizer/sizer.dart';
import 'package:crypto/crypto.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  String statuss = '';
  Future<void> checkData(String token, String password) async {
    final response = await http.post(
      Uri.parse('http://ksp-warnaartha.co.id/kwamobile/get_checkpassword.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'password': password}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      statuss = data['status'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  String calculateMD5(String input) {
    // Convert the input string to bytes
    List<int> inputBytes = utf8.encode(input);

    // Create an MD5 hash
    Digest md5Hash = md5.convert(inputBytes);

    // Convert the hash to a hex string
    String md5HashString = md5Hash.toString();

    return md5HashString;
  }

  Future<void> updatePassword(
      String code, String token, String passwordBaru) async {
    final apiUrl =
        'http://ksp-warnaartha.co.id/kwamobile/gantipassword.php'; // Sesuaikan dengan URL API Anda

    final response = await http.get(
      Uri.parse('$apiUrl?code=$code&token=$token&passwordbaru=$passwordBaru'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => KonfirmasiPassword()),
          (Route<dynamic> route) => false,
        );
        print('Password berhasil diperbarui.');
      } else {
        EasyLoading.showInfo('Password lama dan baru tidak bisa sama');
        print('Gagal memperbarui password. ${data['message']}');
      }
    } else {
      print('Gagal terhubung ke server. Status code: ${response.statusCode}');
    }
  }

  Future<void> updatepassword(
      String username_baru, String password_baru) async {
    await Hive.initFlutter();
    var datalocal = await Hive.openBox('datalocal');
    String token = datalocal.get('token');
    String cif = datalocal.get('cif');
    final String apiUrl =
        'http://alamat_api_anda/updateUserCredentials'; // Ganti dengan alamat API Anda

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestData = {
      'usernamebaru': username_baru,
      'passwordbaru': password_baru,
      'token': token,
      'code': cif,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        print('Berhasil: ${response.body}');
      } else {
        print('Gagal: ${response.statusCode}');
        print('Pesan: ${response.body}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  TextEditingController password1_ = TextEditingController();
  TextEditingController password2_ = TextEditingController();
  TextEditingController passwordlama_ = TextEditingController();
  bool _isObscure1 = false;
  bool _isObscure2 = false;

  bool containsNumber(String input) {
    // Mengecek apakah terdapat angka dalam string menggunakan regex
    return RegExp(r'\d').hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Ganti Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(children: [
                SizedBox(
                  height: 1.h,
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
                          'Ganti password :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Password lama :',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        TextFormField(
                          obscureText: _isObscure1,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp(r'\s')), // Mengabaikan spasi
                          ],
                          controller: passwordlama_,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure1
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure1 = !_isObscure1;
                                  });
                                }),
                            border: OutlineInputBorder(), // Set border here
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Password baru :',
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
                          controller: password1_,
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
                          height: 1.5.h,
                        ),
                        Text(
                          'Masukan kembali password Baru :',
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
                          controller: password2_,
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
                                EasyLoading.show();
                                await Hive.initFlutter();
                                var datalocal = await Hive.openBox('datalocal');
                                String token = datalocal.get('token');
                                String cif = datalocal.get('cif');

                                String pwlama = calculateMD5(
                                    'Pinh27@))*' + passwordlama_.text);

                                print(pwlama);

                                await checkData(token, pwlama);
                                print(statuss);

                                String pw = calculateMD5(
                                    'Pinh27@))*' + password1_.text);

                                bool containsNumberPass1 =
                                    containsNumber(password1_.text);
                                bool containsNumberPass =
                                    containsNumber(password2_.text);

                                if (containsNumberPass == true &&
                                    containsNumberPass1 == true) {
                                  if (password1_.text == password2_.text) {
                                    if (statuss == "Data exists") {
                                      await updatePassword(cif, token, pw);
                                    } else {
                                      EasyLoading.showInfo(
                                          'Password lama anda salah');
                                    }
                                  } else {
                                    EasyLoading.showInfo(
                                        'Password baru tidak sama coba lagi');
                                  }
                                } else {
                                  EasyLoading.showInfo(
                                      'Password baru anda harus berisi angka');
                                }
                                EasyLoading.dismiss();
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
