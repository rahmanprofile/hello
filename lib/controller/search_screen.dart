import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horget/controller/constant.dart';
import 'package:horget/controller/db/assistant.dart';
import 'package:horget/model/place_prediction.dart';
import 'package:provider/provider.dart';
import 'data_handler/app_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final pickUpController = TextEditingController();
  final dropUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final placeAddress =
        Provider.of<AppData>(context).pickUpLocation?.placeName ?? "";
    pickUpController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 0.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      const Center(
                        child: Text(
                          "Set drop off",
                          style: TextStyle(
                              fontFamily: "Product Sans",
                              fontSize: 16,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(CupertinoIcons.car_detailed,
                          size: 30, color: Colors.white),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: TextFormField(
                              controller: pickUpController,
                              onChanged: (val) {
                                findPlace(val);
                              },
                              decoration: InputDecoration(
                                hintText: "Pickup location",
                                border: InputBorder.none,
                                fillColor: Colors.grey[400],
                                filled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(CupertinoIcons.arrow_branch,
                          size: 30, color: Colors.white),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: TextFormField(
                              controller: dropUpController,
                              decoration: InputDecoration(
                                  hintText: "Drop location",
                                  border: InputBorder.none,
                                  fillColor: Colors.grey[400],
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps:googleapis.com/api/place/autocomplete/json?input=$placeName&key=$apiKey&sessiontoken=1234567890";
      var response = await RequestAssistant.getRequest(autoCompleteUrl);
      if (response == "failed") {
        return;
      }
      if (response['status'] == "OK") {
        var prediction = response['prediction'];
        var placeList = (prediction as List)
            .map((e) => PlacePrediction.fromJson(e))
            .toList();
      }
    }
  }
}
