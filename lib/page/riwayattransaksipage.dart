import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

class Transaction {
  final String nominal;
  final String paketke;
  final String total;
  final String transDate;

  Transaction(this.nominal, this.paketke, this.total, this.transDate);

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      json['nominal'],
      json['paketke'],
      json['total'],
      json['trans_date'],
    );
  }
}

class RiwayatTransaksiPage extends StatefulWidget {
  const RiwayatTransaksiPage({super.key});

  @override
  State<RiwayatTransaksiPage> createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  @override
  void initState() {
    getdata();
    super.initState();
  }

  bool munculregister = true;
  String token = '';
  void getdata() async {
    await Hive.initFlutter();
    var datalocal = await Hive.openBox('datalocal');

    try {
      token = datalocal.get('token');
    } catch (e) {
      munculregister = false;
      print(e);
    }

    if (token == null) {
      munculregister = false;

      setState(() {});
    }
    setState(() {});

    print(token);
  }

  final String apiUrl =
      'http://ksp-warnaartha.co.id/kwamobile/get_transaksidata.php?token=1&tabungan_code=005.111.0000651&start_date=2023-12-20 00:00:00&end_date=2024-01-02 23:00:00';

  Future<List<Transaction>> fetchTransactions() async {
    final response = await Dio().get(apiUrl);

    if (response.statusCode == 200) {
      List<Transaction> transactions = [];
      for (var transaction in response.data) {
        transactions.add(Transaction.fromJson(transaction));
      }
      return transactions;
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  String formatCurrency(String input) {
    // Hapus karakter selain angka dan titik
    String cleanString = input.replaceAll(RegExp(r'[^0-9.]'), '');

    // Konversi ke double
    double amount = double.parse(cleanString);

    // Format sebagai mata uang dengan pemisah ribuan tanda titik
    String formattedString = 'Rp. ${amount.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)}.',
        )}';

    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('KWA Mobile'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.5.h,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
            child: Text(
              'Riwayat Transaksi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text('data'),
          SizedBox(
            height: 1.5.h,
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchTransactions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Transaction>? transactions = snapshot.data;
                  return ListView.builder(
                    itemCount: transactions!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${transactions[index].transDate}'),
                        subtitle:
                            Text('Paket Ke: ${transactions[index].paketke}\n'
                                'Total: ${transactions[index].total}\n'),
                        trailing: Text(
                          formatCurrency(transactions[index].nominal),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
