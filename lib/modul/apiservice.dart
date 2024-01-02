import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Map<String, dynamic>>> getData(
      String nasabahCode, String token) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/get_norek.php?nasabah_code=$nasabahCode&token=$token'),
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the data
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.cast<Map<String, dynamic>>();
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
