import 'package:flutter/material.dart';

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
        Center(
          child: Text(
            'Error Koneksi Internet Gagal',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
