import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kwamobile/modul/apiservice.dart';
import 'package:kwamobile/page/datepickerpage.dart';
import 'package:kwamobile/page/riwayattransaksipage.dart';

class ListPage extends StatefulWidget {
  final String nasabahCode;
  final String token;

  ListPage({required this.nasabahCode, required this.token});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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

  ApiService apiService = ApiService('http://ksp-warnaartha.co.id/kwamobile');

  late Future<List<Map<String, dynamic>>> data;

  String getCodeLabel(String productCode) {
    switch (productCode) {
      case '111':
        return 'Angsuran Kredit';
      case '116':
        return 'Tabungan Paket';
      case '119':
        return 'Tabungan Hari Raya';
      default:
        return 'Default Label'; // Change this to your default label
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
    data = apiService.getData(widget.nasabahCode, widget.token);
  }

  @override
  String codeLabel = '';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(
          'Pilih Tabungan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Display the data in a ListView
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    // Use a switch statement to determine the label based on product_code
                    leading: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape
                            .circle, // Membuat leading menjadi bentuk bulat
                        color: Colors
                            .lightGreen[50], // Atur warna sesuai kebutuhan
                      ),
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[300],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DatePickerDate(
                                        nomorrekening: item['code'],
                                        token: '',
                                      )));
                        },
                        child: Text(
                          'Cek Transaksi',
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        )),
                    title: Text(
                      '${getCodeLabel(item['product_code'].toString())}',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Rekening : ${item['code']}',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text('Nominal Setor : Rp. ${item['nominal']}',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    // You can customize the ListTile as needed
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
