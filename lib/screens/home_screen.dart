import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_udemy_examples/http_api_data/get_location_data_final.dart';
import 'package:flutter_udemy_examples/http_api_data/get_location_names.dart';
import 'package:flutter_udemy_examples/screens/login_ekrani.dart';
import 'package:flutter_udemy_examples/screens/map_screen.dart';
import 'login_ekrani.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../banner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_udemy_examples/http_api_data/get_location_images.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  LocationDataFinal? locationSuggestion;

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  Future<void> asyncInitState() async {
    await fecthlocationData();
  }

  Future fecthlocationData() async {
    var locations = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final double enlem = locations.latitude;
    final double boylam = locations.longitude;
    final url = Uri.parse(
        "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=coordinates%7Cpageimages%7Cdescription%7Cextracts&generator=geosearch&piprop=original&descprefersource=central&exlimit=20&exintro=1&explaintext=1&exsectionformat=plain&ggscoord=${enlem}%7C${boylam}&ggsradius=10000");
    print(url);
    final response = await http.get(url);
    //print(response.body);
    if (response.statusCode == 200) {
      locationSuggestion = await locationDataFinalFromJson(response.body);
      if (locationSuggestion != null) {
        setState(() {
          isLoading = false;
        });
      } else {
        print("null aq");
      }
    } else {
      print("null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                MyBanner(
                  // info: locationSuggestion!.query.pages[0]!.description,
                  locationName: locationSuggestion!.query.pages[0]!.title,
                  imagePath:
                      locationSuggestion!.query.pages[0]!.original.source,
                  context: context,
                ),
                MyBanner(
                  //info: locationSuggestion!.query.pages[1]!.description,
                  locationName: locationSuggestion!.query.pages[1]!.title,
                  imagePath:
                      locationSuggestion!.query.pages[1]!.original.source,
                  context: context,
                ),
                MyBanner(
                  //  info: locationSuggestion!.query.pages[2]!.description,
                  locationName: locationSuggestion!.query.pages[2]!.title,
                  imagePath:
                      locationSuggestion!.query.pages[2]!.original.source,
                  context: context,
                ),
                MyBanner(
                  //  info: locationSuggestion!.query.pages[3]!.description,
                  locationName: locationSuggestion!.query.pages[3]!.title,
                  imagePath:
                      locationSuggestion!.query.pages[3]!.original.source,
                  context: context,
                ),
                MyBanner(
                  //  info: locationSuggestion!.query.pages[4]!.description,
                  locationName: locationSuggestion!.query.pages[4]!.title,
                  imagePath:
                      locationSuggestion!.query.pages[4]!.original.source,
                  context: context,
                ),
              ],
            ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: RotatedBox(
        quarterTurns: 2,
        child: _buildExitButton(context),
      ),
      actions: [
        _buildOpenMapButton(),
        _buildCallEmergencyNumberButton(),
      ],
      titleSpacing: 25,

      shadowColor: Colors.white,
      elevation: 0.0,
      backgroundColor: Colors.blue[800],
      //titleSpacing: Padding(padding: EdgeInsets.fromLTRB(25.85.0, 0, 25.85.0, 0)),
      title: Text("Traveler Doctor"),
    );
  }

  Widget _buildCallEmergencyNumberButton() {
    return IconButton(
      disabledColor: Colors.red,
      color: Colors.red,
      icon: Icon(Icons.phone_enabled),
      tooltip: "Local emergency number",
      onPressed: null,
    );
  }

  Widget _buildOpenMapButton() {
    return IconButton(
      disabledColor: Colors.orangeAccent,
      color: Colors.limeAccent,
      icon: Icon(Icons.map_rounded),
      tooltip: "Map",
      enableFeedback: false,
      onPressed: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => MapScreen()))
      },
    );
  }
}

Widget _buildExitButton(BuildContext context) {
  return IconButton(
    onPressed: () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('KullaniciAdi', "");

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginEkrani()));
    },
    icon: Icon(
      Icons.exit_to_app,
      color: Colors.red,
    ),
    tooltip: "Exit",
  );
}


//https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages&list=&titles=Googleplex&VirtualPBX&Bridge%20School%20Benefit&formatversion=2&piprop=original