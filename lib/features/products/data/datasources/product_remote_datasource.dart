import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductRemoteDataSource {
  Future<List<dynamic>> fetchProductJson() async {
    final res = await http.get(Uri.parse('https://dummyjson.com/products'));
    final json = jsonDecode(res.body);
    return json['products'];
  }
}
