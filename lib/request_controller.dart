import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class RequestController {
  void getRequest(String url) async {
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 'failed') {
      return;
    }
    if (response.statusCode == 'OK') {

    }
  }
}