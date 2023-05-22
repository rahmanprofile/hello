import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RequestAssistant {

  static Future<dynamic> getRequest(url) async {
    Response response = await http.get(Uri.parse(url));
    try{
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        return data;
      } else {
        return "Failed : Data fetching failed";
      }
    }catch (e) {
      print("Exception => ${e.runtimeType.toString()}");
    }
  }


}