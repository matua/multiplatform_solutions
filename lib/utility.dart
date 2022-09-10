import 'package:http/http.dart' as http;

Future<String?> getCorsHeader(String url) async {
  String? result = 'None';
  http.Response response = await http.get(
    Uri.parse(url),
  );
  if (response.statusCode == 200) {
    if (response.headers['access-control-allow-origin'] != null) {
      result = response.headers['access-control-allow-origin'];
    }
  }
  return result;
}
