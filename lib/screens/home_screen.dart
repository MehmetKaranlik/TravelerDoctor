import 'package:flutter/material.dart';
import 'package:flutter_udemy_examples/http_api_data/get_location_names.dart';
import 'package:flutter_udemy_examples/screens/login_ekrani.dart';
import 'package:flutter_udemy_examples/model/travel_country_model.dart';
import 'package:flutter_udemy_examples/screens/map_screen.dart';
import 'login_ekrani.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../banner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<TravelCountryModel> listLocation = [
    TravelCountryModel("", "assets/mount_fuji.jpg", "historyExplanation")
  ];

  bool isLoading = true;
  late String data;

  @override
  void initState() {
    super.initState();
    asyncInitState();
  }

  Future fecthlocationData() async {
    var locations = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      //timeLimit: Duration(seconds: 15),
      //forceAndroidLocationManager: true,
    );

    final double enlem = locations.latitude;
    final double boylam = locations.longitude;
    print('enlem ' + enlem.toString());
    print('boylam ' + boylam.toString());
    var url = Uri.parse(
        "https://en.wikipedia.org/w/api.php?action=query&format=json&list=geosearch&gscoord=${enlem}%7C${boylam}&gsradius=10000&gslimit=100");

    var answer = await http.get(url);
    //Map response = json.decode(answer.body);

    print("$answer");
    setState(() {
      isLoading = false;
    });
    return LocationInformation.fromJson(jsonDecode(answer.body));
  }

  Future<void> asyncInitState() async {
    fecthlocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: FutureBuilder(
        future: asyncInitState(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return MyBanner(
                  locationName: LocationInformation().query.geosearch[0].title,
                  imagePath: listLocation[0].listImagePath,
                  context: context,
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
