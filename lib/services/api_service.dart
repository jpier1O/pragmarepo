import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/breed.dart';

class ApiService {
  final String _baseUrl = 'https://api.thecatapi.com/v1/breeds';
  final String _apiKey = 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr';

  Future<List<Breed>> fetchBreeds() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Breed.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las razas de gatos');
    }
  }
}
