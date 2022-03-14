import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>?> listTypeCarApi () async {
  try {
    final http.Response result = await http.get(
      Uri.parse('https://fn-fe-evaluacion-personal.azurewebsites.net/api/auto/modelo'),
      headers: {
        "Content-Type": "application/json"
      }
    );

    if(result.statusCode == 200){
      return json.decode(result.body);
    }
  } catch (_) {}
  return null;
}