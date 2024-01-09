import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kwamobile/page/registerpage.dart';
import 'package:sizer/sizer.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  @override
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.yellow;
    }
    return Colors.green;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(children: [
        SizedBox(
          height: 15.h,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(16),
            width: 65.w,
            child: Column(children: [
              Text(
                'Informasi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                  'Aplikasi ini hanya untuk Anggota yang sudah terdaftar di KSP Warna Artha, dan memiliki Rekening tabungan/pinjaman yang aktif'),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Row(
              //     children: [
              //       Checkbox(
              //         checkColor: Colors.white,
              //         // fillColor: MaterialStatePropertyAll(Colors.green),
              //         activeColor: Colors.green,
              //         value: isChecked1,

              //         onChanged: (bool? value) {
              //           setState(() {
              //             isChecked1 = value!;
              //             print(isChecked1);
              //           });
              //         },
              //       ),
              //       Text(
              //         'Saya sudah terdaftar di \n KSP Warna Artha',
              //         style: TextStyle(fontSize: 11),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 1.h,
              // ),
              // Row(
              //   children: [
              //     Checkbox(
              //       checkColor: Colors.white,
              //       // fillColor: MaterialStatePropertyAll(Colors.green),
              //       activeColor: Colors.green,
              //       value: isChecked2,
              //       onChanged: (bool? value) {
              //         setState(() {
              //           isChecked2 = value!;
              //           print(isChecked2);
              //         });
              //       },
              //     ),
              //     Text(
              //       'Saya sudah memiliki rekening \n aktif di KSP Warna Artha',
              //       style: TextStyle(fontSize: 11),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      child: Text(
                        'Kembali',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      )),
                  SizedBox(
                    width: 2.w,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
    
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                    
                      },
                      child: Text(
                        'Selanjutnya',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ))
                ],
              )
            ]),
          ),
        )
      ]),
    );
  }
}
