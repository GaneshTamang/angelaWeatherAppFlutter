// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http_pubspec;

class NetworkHelper {
  NetworkHelper({required this.url});
  String url;

  // !currently no data type determined determines only after getting data so future
  Future getDataFromAPi() async {
    http_pubspec.Response getRes = await http_pubspec.get(
      Uri.parse(url),
    );
    if (getRes.statusCode == 200) {
      var decodedBodyData = jsonDecode(getRes.body);

      return decodedBodyData;
    } else {
      print(getRes.statusCode);
    
    }
  }
}
