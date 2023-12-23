import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

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
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
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
                  height: 36.h,
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
                        Text(
                          'Username                        : ${widget.username}',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'Password                        : ${widget.password}',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'No. Anggota/tabungan : ${widget.norek}',
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
                              child: Text('Kembali'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String deviceModel = '';

                                try {
                                  deviceModel =
                                      await DeviceInformation.deviceModel;

                                  // imeiNo =
                                  //     await DeviceInformation.deviceIMEINumber;
                                  // modelName =
                                  //     await DeviceInformation.deviceModel;
                                  // manufacturer = await DeviceInformation
                                  //     .deviceManufacturer;
                                  // apiLevel = await DeviceInformation.apiLevel;
                                  // deviceName =
                                  //     await DeviceInformation.deviceName;
                                  // productName =
                                  //     await DeviceInformation.productName;
                                  // cpuType = await DeviceInformation.cpuName;
                                  // hardware = await DeviceInformation.hardware;
                                } on PlatformException {
                                  deviceModel =
                                      'Failed to get platform version.';
                                }

                                print(deviceModel);
                              },
                              child: Text('Daftar'),
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
