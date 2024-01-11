import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kwamobile/page/registersukses.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

class KonfirmasiRegister extends StatefulWidget {
  final String nik;
  final String norek;
  final String nohp;
  final String username;
  final String password;

  const KonfirmasiRegister(
      {super.key,
      required this.nik,
      required this.norek,
      required this.nohp,
      required this.username,
      required this.password});

  @override
  State<KonfirmasiRegister> createState() => _KonfirmasiRegisterPageState();
}

class _KonfirmasiRegisterPageState extends State<KonfirmasiRegister> {
  @override
  List<Map<String, dynamic>> responseData = [];
  var nasabahCode = '';
  var nasabahName = '';

  Future<void> get_dataCif(String norek) async {
    String apiUrl = 'http://ksp-warnaartha.co.id/kwamobile/get_data.php';
    String code = norek;
    String token = 'a3402327bd7823c778cee59533a2ceb5';
    final response =
        await http.get(Uri.parse('$apiUrl?code=$code&token=$token'));

    if (response.statusCode == 200) {
      setState(() {
        try {
          responseData =
              List<Map<String, dynamic>>.from(json.decode(response.body));
          nasabahCode = responseData[0]["nasabah_code"];
          nasabahName = responseData[0]["nasabah_name"];

          print(nasabahCode + 'ini' + nasabahName);
        } catch (e) {
          print('get data cif error salah isi paling');
        }
      });
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
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

  bool validasirequest = false;

  Future<void> validasiNik(String cif_, String nik_) async {
    // Ganti URL API dengan URL yang sesuai
    final apiUrl = 'http://ksp-warnaartha.co.id/kwamobile/get_checkdata.php';

    // Ganti api_key, cif, dan nik sesuai kebutuhan
    final apiKey = 'a3402327bd7823c778cee59533a2ceb5';
    final cif = cif_;
    final nik = nik_;

    final response = await http.get(
      Uri.parse('$apiUrl?api_key=$apiKey&cif=$cif&nik=$nik'),
    );

    if (response.statusCode == 200) {
      // Parsing respons JSON
      final responseData = json.decode(response.body);

      // Melakukan sesuatu dengan data yang diterima
      if (responseData['status'] == 'success') {
        validasirequest = true;
        print('Data ditemukan: ${responseData['message']}');
      } else {
        print('Data tidak ditemukan: ${responseData['message']}');
      }
    } else {
      // Menangani kesalahan jika respons tidak berhasil (status code bukan 200 OK)
      print('Error: ${response.statusCode}');
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> registerAccount(
    String code,
    String name,
    String nik,
    String noHp,
    String username,
    String password,
    String token,
    String isFirstTime,
    String idHp,
  ) async {
    final String apiUrl =
        "http://ksp-warnaartha.co.id/kwamobile/post_registeruser.php";
    final String apiKey = "a3402327bd7823c778cee59533a2ceb5";

    final Dio dio = Dio();

    final FormData formData = FormData.fromMap({
      "api_key":
          'a3402327bd7823c778cee59533a2ceb5', // Add the API key to the FormData
      "code": code,
      "name": name,
      "nik": nik,
      "no_hp": noHp,
      "username": username,
      "password": password,
      "token": token,
      "is_firsttime": isFirstTime,
      "id_hp": idHp,
    });

    try {
      final Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        print("ok");
      } else {
        print("");
      }
    } catch (e) {
      print("");
    }
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
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pastikan data yang telah di isi benar :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Username                        : ${widget.username}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Password                         : ${widget.password}',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'No. Anggota/tabungan  : ${widget.norek}',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'Nik                                    : ${widget.nik}',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'No.HP                              : ${widget.nohp}',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 3.5.h,
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
                                try {
                                  EasyLoading.show();

                                  var datalocal =
                                      await Hive.openBox('datalocal');
                                  String idhp = 'no id';
                                  String username = calculateMD5(
                                      'Pinh27@))*${widget.username}');
                                  String password = calculateMD5(
                                      'Pinh27@))*${widget.password}');
                                  String norek = widget.norek;
                                  String nik = widget.nik;
                                  String nohp = widget.nohp;
                                  String token = calculateMD5(username +
                                      password +
                                      'Kspkwa@))*Bidexh27@))*Kspksph27@))*');
                                  await get_dataCif(norek);

                                  await validasiNik(nasabahCode, nik);

                                  if (validasirequest == true) {
                                    try {
                                      await registerAccount(
                                          nasabahCode.toString(),
                                          nasabahName.toString(),
                                          nik.toString(),
                                          nohp.toString(),
                                          username.toString(),
                                          password.toString(),
                                          token.toString(),
                                          '1',
                                          idhp.toString());
                                      await Hive.initFlutter();
                                      var datalocal =
                                          await Hive.openBox('datalocal');

                                      datalocal.put('idhp', idhp.toString());
                                      datalocal.put(
                                          'cif', nasabahCode.toString());
                                      datalocal.put('token', token.toString());

                                      EasyLoading.dismiss();

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterSukses()),
                                          (route) => false);
                                    } catch (e) {
                                      EasyLoading.showError(
                                          ' INI ERROR ${e.toString()}');
                                      EasyLoading.dismiss();
                                    }
                                  } else {
                                    EasyLoading.showError(
                                        'Data No Rekening tabugnan atau nik tidak sesuai');
                                    EasyLoading.dismiss();
                                  }
                                } catch (e) {}
                              },
                              child: Text(
                                'Daftar',
                                style: TextStyle(color: Colors.white),
                              ),
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
