import 'package:flutter/material.dart';
import 'package:horget/request_controller.dart';

class PolyPage extends StatefulWidget {
  const PolyPage({Key? key}) : super(key: key);

  @override
  State<PolyPage> createState() => _PolyPageState();
}

class _PolyPageState extends State<PolyPage> {
  final pickUpController = TextEditingController();
  final dropUpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Search Places"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration:const BoxDecoration(
                color: Colors.black54
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: pickUpController,
                    decoration: const InputDecoration(hintText: "Enter pick address"),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: dropUpController,
                    decoration: const InputDecoration(hintText: "Enter drop address"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void autoComplete(String placeAddress) async {
    if (placeAddress.length>1) {
      // String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeAddress&key=AIzaSyAJG7E_unlT9D1GsJR_ic0ISQFktIMZuE0";
      // var result = await RequestController.getRequest(autoCompleteUrl);
      // if (result == 'failed') {
      //   return;
      // }
      // print(result);
    }
  }


}

// class PolyPage extends StatefulWidget {
//   const PolyPage({Key? key}) : super(key: key);
//
//   @override
//   State<PolyPage> createState() => _PolyPageState();
// }
//
// class _PolyPageState extends State<PolyPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//   final CameraPosition _initialCameraPosition = const CameraPosition(
//     target: LatLng(28.3917104, 77.0458507),
//     zoom: 14.4778,
//   );
//   static const LatLng sourceLocation = LatLng(28.417496, 77.045833);
//   static const LatLng destination = LatLng(28.423541, 77.061513);
//   final List<LatLng> polylineCoordinates = [];
//
//   void _getPolyPoint() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'GoogleApiKey',
//       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(
//           LatLng(point.latitude, point.longitude),
//         );
//       });
//       setState(() {});
//     }
//   }
//
//   @override
//   void initState() {
//     _getPolyPoint();
//     getCurrentLocation();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//               mapType: MapType.normal,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               initialCameraPosition: _initialCameraPosition,
//               compassEnabled: true,
//               markers: {
//                 Marker(
//                   markerId: MarkerId('Rahman'),
//                   position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
//                 ),
//                 const Marker(
//                   markerId: MarkerId('Rahman'),
//                   position: sourceLocation,
//                 ),
//                 const Marker(
//                   markerId: MarkerId('Home'),
//                   position: destination,
//                 ),
//               },
//               polylines: {
//                 Polyline(
//                   polylineId: const PolylineId('route'),
//                   points: polylineCoordinates,
//                   color: Colors.blueAccent,
//                   width: 6,
//                 ),
//               },
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//     );
//   }
//
//   Position? currentLocation;
//   void getCurrentLocation() async {
//     final location = await Geolocator.getCurrentPosition().then((location) {
//       currentLocation = location;
//     });
//     GoogleMapController googleMapController = await _controller.future;
//     location.onLocationChanged.listen(
//       (newDoc) {
//         currentLocation = newDoc;
//         googleMapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               zoom: 14.4776,
//               target: LatLng(
//                 newDoc.latitude!,
//                 newDoc.longitude!,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//     setState(() {});
//   }
// }
