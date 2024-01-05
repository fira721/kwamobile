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
  final String code;

  Transaction(
      this.nominal, this.paketke, this.total, this.transDate, this.code);

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(json['nominal'], json['paketke'], json['total'],
        json['trans_date'], json['code']);
  }
}

class RiwayatTransaksiPage extends StatefulWidget {
  const RiwayatTransaksiPage(
      {super.key,
      required this.startdate,
      required this.enddate,
      required this.norek,
      required this.token});

  final String startdate;
  final String enddate;
  final String norek;
  final String token;

  @override
  State<RiwayatTransaksiPage> createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  @override
  Future<List<Transaction>> fetchTransactions() async {
    final String apiUrl =
        'http://ksp-warnaartha.co.id/kwamobile/get_transaksidata.php?token=${widget.token}&tabungan_code=${widget.norek}&start_date=${widget.startdate} 00:00:00&end_date=${widget.enddate} 23:00:00';

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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'KWA Mobile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Container(
          color: Colors.white,
          child: Column(
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
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'No Rekening : ${widget.norek}',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                'Periode : ${widget.startdate} - ${widget.enddate}',
                style: TextStyle(fontSize: 11),
              ),
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
                          // Add 1 to index because index is zero-based
                          int sequentialNumber = index + 1;
                          return ListTile(
                            title: Text('${transactions[index].transDate}'),

                            subtitle: Text(
                              'Paket Ke       : ${transactions[index].paketke}\n'
                              'Total             : ${transactions[index].total}\n'
                              'Id Transaksi : ${transactions[index].code}\n',
                              style: TextStyle(fontSize: 10),
                            ),
                            trailing: Text(
                              formatCurrency(transactions[index].nominal),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                            // Display the sequential number
                            leading: Text('$sequentialNumber'),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
