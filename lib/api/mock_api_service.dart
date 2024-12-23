import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MockApiService {
  final String baseUrl;

  MockApiService(this.baseUrl);

  Future<Map<String, dynamic>> signup(String email, String password) async {
    try {
      final String response =
          await rootBundle.loadString('assets/mock/signup.json');
      print('Mock data loaded successfully, $response');
      final Map<String, dynamic> data = json.decode(response);
      print(data);
      return data;
    } catch (error) {
      throw Exception('Failed to load mock signup data');
    }
  }
}
