import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kwamobile/page/registerpage.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
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
    );
  }
}
