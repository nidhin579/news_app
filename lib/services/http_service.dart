import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app_nidhin/constants/env/env.dart';

class HttpService {
  final Client _httpClient;

  HttpService({required Client httpClient}) : _httpClient = httpClient;

  Future get({
    required String endpoint,
    Map<String, dynamic>? params,
  }) async {
    final request = Uri.https(
      Env.baseUrl,
      endpoint,
      params,
    );
    final response = await _httpClient.get(
      request,
      headers: {'X-Api-Key': Env.apiKey},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get data');
    }
  }
}
