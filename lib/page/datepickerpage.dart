import 'package:flutter/material.dart';

class DatePickerDate extends StatefulWidget {
  const DatePickerDate(
      {super.key, required this.nomorrekening, required this.token});
  final String nomorrekening;
  final String token;

  @override
  State<DatePickerDate> createState() => _DatePickerDateState();
}

class _DatePickerDateState extends State<DatePickerDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Tanggal')),
      body: Column(children: []),
    );
  }
}
