import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_udemy_examples/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginEkrani extends StatefulWidget {
  @override
  LoginEkraniState createState() => LoginEkraniState();
}

class LoginEkraniState extends State<LoginEkrani> {
  var flp = FlutterLocalNotificationsPlugin();

  Future<void> kurulum() async {
    var androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosSettings = IOSInitializationSettings();
    var installingSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flp.initialize(
      installingSettings,
    );
  }

  Future notificationSelect({String? payLoad}) async {
    if (payLoad != null) {
      print("Payload: $payLoad");
    }
  }

  Future<void> notificationShow() async {
    var androidNotificationDetail = AndroidNotificationDetails(
      "Channel ID",
      "Channel Headline",
      "ChannelDescription",
      autoCancel: true,
      //icon: "Icons.commute_rounded",
      priority: Priority.high,
      importance: Importance.max,
    );

    var iosNotificationDetail = IOSNotificationDetails();

    var notificationDetails = NotificationDetails(
        android: androidNotificationDetail, iOS: iosNotificationDetail);
    await flp.show(0, "Başlık", "İçerik", notificationDetails,
        payload: "Payload İçerik");
  }

  final userName = "admin";
  final password = "admin";
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    kurulum();
    //checkLogin();
    //checkLogin();
  }

  /*Future<void> checkLogin() async {
    var sp = await SharedPreferences.getInstance();

    if (sp.getString('KullaniciAdi')!.isNotEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }*/

  Future girisKontrol(BuildContext context) async {
    var ka = usernameController.text;
    var sp = await SharedPreferences.getInstance();
    var s = passwordController.text;

    if (ka == "admin" && s == "admin") {
      sp.setString("KullaniciAdi", ka);
      sp.setString("Şifre", s);

      showSnackbar(
        context,
        message: "Giriş Yapıldı",
      );
    } else {
      usernameController.clear();
      passwordController.clear();
      showSnackbar(context, message: "Kullanici Adı veya Şifre Hatalı");
    }
  }

  void showSnackbar(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 100,
        backgroundColor: Colors.white,
        content: Container(
          alignment: Alignment.center,
          height: 15,
          child: Text(
            message ?? "",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Icon(
              Icons.commute_rounded,
              size: 150,
              color: Colors.white,
            ),
            Text(
              "Traveler Doctor",
              style: Theme.of(context).textTheme.headline1,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Kullanıcı Adı",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              obscureText: false,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Şifre",
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () => {
                FocusScope.of(context).unfocus(),
                girisKontrol(context),
                //notificationShow(),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
