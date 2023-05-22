import 'package:geolocator/geolocator.dart';
import 'package:horget/controller/data_handler/app_data.dart';
import 'package:horget/controller/db/assistant.dart';
import 'package:horget/model/address_model.dart';
import 'package:provider/provider.dart';
import '../injections.dart';

class AssistantMethod {

  static Future<String> searchCoardinatesAdress(Position position, context) async {
    String placeAddress = '';
    String st1, st2, st3, st4 = '';
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyAJG7E_unlT9D1GsJR_ic0ISQFktIMZuE0";
    var response = await RequestAssistant.getRequest(url);

    if (response.statusCode != "failed") {

      st1 = response['results'][0]['address_components'][0]['long_name'];
      st2 = response['results'][0]['address_components'][4]['long_name'];
      st3 = response['results'][0]['address_components'][5]['long_name'];
      st4 = response['results'][0]['address_components'][6]['long_name'];
      placeAddress = "$st1 ,$st2 ,$st3 ,$st4";

      AddressModel userPickedAddress = AddressModel();
      userPickedAddress.latitude = position.latitude;
      userPickedAddress.longitude = position.longitude;
      userPickedAddress.placeName = placeAddress;


      Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickedAddress);

    }
    return placeAddress;
  }


}