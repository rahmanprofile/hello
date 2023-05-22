import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horget/controller/db/assistant_method.dart';
import 'package:horget/controller/search_screen.dart';
import 'package:horget/view/profile_page.dart';
import '../controller/authentication/signin.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //................. Google Map API ...........................................

  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;
  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(28.4112046,77.0409179),
    zoom: 14.4776,
  );

  final List<Marker> _marker = <Marker>[
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(20.42796133580664, 80.885749655962),
      infoWindow: InfoWindow(title: "My Position"),
    ),
  ];

  Future getUserCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng latLongPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(
      target: latLongPosition,
      zoom: 14.4776,
    );
    newGoogleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    String address =
        await AssistantMethod.searchCoardinatesAdress(position, context);
    print("This is your address => $address");
    return position;
  }

  MapType _currentMapType = MapType.normal;
  void currentMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
      : MapType.hybrid;
    });
  }

  @override
  void initState() {
    getUserCurrentLocation();
    super.initState();
  }

  //.................................. Google Map API .........................................

  final _auth = FirebaseAuth.instance;
  Future signOut() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signOut();
      setState(() {
        _isLoading = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
        );
      });
    } on FirebaseException catch (e) {
      print('Exception => ${e.message.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  double bottomPadding = 40;
  bool _isLoading = false;
  final _pickController = TextEditingController();
  final _dropController = TextEditingController();
  final system = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.grey[200]);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(system);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GoogleMap(
                mapType: _currentMapType,
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set<Marker>.of(_marker),
                initialCameraPosition: _cameraPosition,
                padding: EdgeInsets.only(bottom: bottomPadding, top: 25),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  getUserCurrentLocation();
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: const Border(
                top: BorderSide(color: Colors.black54),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -35.0,
                  left: 20.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // Search  place
                Positioned(
                  top: 50.0,
                  left: 10,
                  child: Container(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width * 0.96,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: _pickController,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                        style: const TextStyle(
                          fontFamily: "Product Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Search destination",
                          hintStyle: TextStyle(
                            fontFamily: "Product Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(CupertinoIcons.search,
                              size: 18, color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                // Text View
                Positioned(
                  top: 120.0,
                  left: 10,
                  child: Container(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width * 0.96,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Home Address",
                        style: const TextStyle(
                          fontFamily: "Product Sans",
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                // Text view
                Positioned(
                  top: 190.0,
                  left: 10,
                  child: InkWell(
                    onTap: () {
                      currentMapType();
                      print("Tapp");
                    },
                    child: Container(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width * 0.96,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Your drop location',
                          style: TextStyle(
                            fontFamily: "Product Sans",
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(
                "Location Address => ${value.latitude.toString()} , ${value.longitude.toString()}");
            _marker.add(
              Marker(
                markerId: const MarkerId("Rahman"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(
                  title: "Current Location",
                ),
              ),
            );
            CameraPosition cameraPosition = CameraPosition(
              zoom: 14.4776,
              target: LatLng(value.latitude, value.longitude),
            );
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(cameraPosition),
            );
            setState(() {});
          }).onError((error, stackTrace) {
            print("Error Name => ${error.toString()}");
          });
        },
        backgroundColor: Colors.red,
        child: Icon(CupertinoIcons.location_north),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),*/
