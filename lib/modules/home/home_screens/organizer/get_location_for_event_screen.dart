import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationForEventScreen extends StatefulWidget {
  const LocationForEventScreen({Key key}) : super(key: key);

  @override
  _LocationForEventScreenState createState() => _LocationForEventScreenState();
}
final Set<Marker> _markers = {};
class _LocationForEventScreenState extends State<LocationForEventScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Location",style: TextStyle(color: Colors.white),),
      ),
      body: Stack(
        children: [
           GoogleMap(
            initialCameraPosition:  const CameraPosition(
              target: const LatLng(30.722636, 31.036705),
              zoom: 8
            ),
             compassEnabled: true,
             tiltGesturesEnabled: false,
             onTap: (latlang){
               if(_markers.length>=1)
               {
                 _markers.clear();
               }

               _onAddMarkerButtonPressed(latlang);
             },
             myLocationEnabled: true,
             myLocationButtonEnabled: true,
             markers: _markers,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom:30.0),
              child: MaterialButton(onPressed: (){
                if(_markers.length>0) {
                  print(_markers.first.position.latitude.toString() + " " +
                      _markers.first.position.longitude.toString());
                  Navigator.pop(context, _markers.first.position);
                }
                else{}
              },color: Colors.deepOrange,
              elevation: 30,
              child: const Text("Submit The Location",style:  TextStyle(color: Colors.white),),),
            ),
          )
        ],
      ),
    );

  }
  void _onAddMarkerButtonPressed(LatLng latlang) {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("1"),
        position: latlang,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
