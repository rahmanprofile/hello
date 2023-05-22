import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CabsPage extends StatefulWidget {
  const CabsPage({Key? key}) : super(key: key);

  @override
  State<CabsPage> createState() => _CabsPageState();
}

class _CabsPageState extends State<CabsPage> {
  final List<Marker> _marker = <Marker>[
    const Marker(markerId: MarkerId("1"),
    position: LatLng(28.628151 , 77.367783),
      infoWindow: InfoWindow(
        title: "Position"
      ),
    ),
  ];
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _initialPosition = const CameraPosition(
      target: LatLng(28.628151 , 77.367783),
    zoom: 14.4776,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Your Cabs"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GoogleMap(
                mapType: MapType.normal,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                markers: Set<Marker>.of(_marker),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: _initialPosition,
                onMapCreated: (GoogleMapController controller ) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
           Container(
             height: MediaQuery.of(context).size.height*0.60,
             width: double.infinity,
             decoration: BoxDecoration(
               color: Colors.grey[200],
               border: const Border(
                 top: BorderSide(
                   color: Colors.black54
                 )
               )
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Padding(
                   padding: EdgeInsets.only(left: 12.0,top: 10),
                   child: Text("All located cabs",style: TextStyle(fontFamily: "Product Sans",fontSize: 17,),),
                 ),
                 ListTile(
                   onTap: (){},
                   title: Text("XI Cabs"),
                   subtitle: Text("Maruti Suzuki"),
                   trailing: Icon(CupertinoIcons.chevron_forward,size: 18),
                   leading: Container(
                     height: 45,
                     width: 45,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white
                     ),
                   ),
                 ),
                 ListTile(
                   onTap: (){},
                   title: Text("XB Cabs"),
                   subtitle: Text("Waganor Suzuki"),
                   trailing: Icon(CupertinoIcons.chevron_forward,size: 18),
                   leading: Container(
                     height: 45,
                     width: 45,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white
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

