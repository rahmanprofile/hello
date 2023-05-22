
import 'package:flutter/cupertino.dart';
import 'package:horget/model/address_model.dart';

class AppData extends ChangeNotifier {

  AddressModel? pickUpLocation;
  void updatePickUpLocationAddress(AddressModel pickUpLocation) async {

    //pickUpLocation = pickUpAddress;
    notifyListeners();

  }



}