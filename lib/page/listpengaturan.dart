import 'package:flutter/material.dart';
import 'package:kwamobile/page/updatepasswordpage.dart';
import 'package:sizer/sizer.dart';

class ListPengaturan extends StatefulWidget {
  const ListPengaturan({super.key});

  @override
  State<ListPengaturan> createState() => _ListPengaturanState();
}

class _ListPengaturanState extends State<ListPengaturan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 5.h,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePasswordPage()));
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Text(
                  'Ganti Password',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              height: 3.h,
            ),
          ]),
        ),
      ),
    );
  }
}
