import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_udemy_examples/screens/home_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//AIzaSyD5LpGGAoh1dvIwHIdWZTsFTG2waTfPUWk

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> mapControl = Completer();
  var startingPosition;
  Future getStartingPosition() async {
    Position positions = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 15),
    );

    final double enlem = positions.latitude;
    final double boylam = positions.longitude;
    print('enlem ' + enlem.toString());
    print('boylam ' + boylam.toString());

    return startingPosition =
        CameraPosition(target: LatLng(enlem, boylam), zoom: 8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: RotatedBox(
            quarterTurns: 1,
            child: _buildExitButton(context),
          ),
        ),
        body: FutureBuilder(
          future: getStartingPosition(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return MapBuilder(
                  mapControl: mapControl, startingPosition: startingPosition);
            }
          },
        ));
  }
}

class MapBuilder extends StatelessWidget {
  const MapBuilder({
    Key? key,
    required this.mapControl,
    required this.startingPosition,
  }) : super(key: key);

  final Completer<GoogleMapController> mapControl;
  final startingPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapControl.complete(controller);
        },
        initialCameraPosition: startingPosition,
      ),
    );
  }
}

Widget _buildExitButton(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.expand_more_outlined),
    onPressed: () async {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    },
  );
}
