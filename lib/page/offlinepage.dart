import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(children: [
        SizedBox(
          height: 30.h,
        ),
        Center(
          child: Container(
            width: 70.w,
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  size: 30.sp,
                  Icons.error_outline_outlined,
                  color: Colors.orange,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Error tidak terkoneksi ke internet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  icon: Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Keluar',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
