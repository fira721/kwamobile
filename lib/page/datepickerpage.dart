import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kwamobile/page/riwayattransaksipage.dart';
import 'package:sizer/sizer.dart';

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
  void initState() {
    formatdateawal();
    super.initState();
  }

  String Tanggal1 = '';
  String Tanggal2 = '';

  void formatdateawal() {
    setState(() {
      Tanggal1 = DateFormat('yyyy-MM-dd').format(_selectedDate);
      Tanggal2 = DateFormat('yyyy-MM-dd').format(_selectedDate2);
    });
  }

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    // Calculate the date 31 days ago
    DateTime thirtyOneDaysAgo = DateTime.now().subtract(Duration(days: 31));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      helpText: 'Pilih Tanggal Awal',
      firstDate: thirtyOneDaysAgo,
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
        _selectedDate2 = _selectedDate;
        Tanggal1 = formattedDate;
        String formattedDate2 = DateFormat('yyyy-MM-dd').format(_selectedDate2);
        Tanggal2 = formattedDate2;
        print(formattedDate);
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    DateTime sevendaysplus = _selectedDate.add(Duration(days: 6));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate2,
      helpText: 'Pilih Tanggal Akhir',
      firstDate: _selectedDate,
      lastDate: sevendaysplus,
    );

    if (picked != null && picked != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate2);
        Tanggal2 = formattedDate;
        print(formattedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pilih Tanggal',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(
                'Cek Transaksi Rekening : ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '${widget.nomorrekening}',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(children: [
            Text(
              'Dari Tanggal       :    ',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              Tanggal1.toString(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              width: 5.w,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  _selectDate(context);
                  print(_selectedDate);
                },
                child: Text(
                  'Pilih Tanggal',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ))
          ]),
          Row(children: [
            Text(
              'Sampai Tanggal :    ',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              Tanggal2.toString(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              width: 5.w,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  _selectDate2(context);
                  print(_selectedDate);
                },
                child: Text(
                  'Pilih Tanggal',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )),
          ]),
          Container(
            alignment: Alignment.centerLeft,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RiwayatTransaksiPage(
                                startdate: Tanggal1,
                                enddate: Tanggal2,
                                norek: widget.nomorrekening,
                                token: widget.token)));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    'Cek Transaksi',
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                'Periode mutasi yang dapat dipilih 7 hari',
                style: TextStyle(color: Colors.grey[600], fontSize: 11),
              ),
              Text(
                'Mutasi rekening maksimum 31 hari yang lalu',
                style: TextStyle(color: Colors.grey[600], fontSize: 11),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
