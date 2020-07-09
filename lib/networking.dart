import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper{

  Future<dynamic> getData(String url) async {
    http.Response response;
    response = await http.get(url);
    return jsonDecode(response.body);
  }
}