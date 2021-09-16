import 'package:flutter/material.dart';
import 'screens/detail_screen.dart';

class MyBanner extends StatelessWidget {
  final String locationName;
  final String imagePath;
  final BuildContext context;

  MyBanner(
      {required this.locationName,
      required this.imagePath,
      required this.context})
      : super();

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    var ekranYukseligi = ekranBilgisi.size.height;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(locationName, imagePath),
        ),
      ),
      child: SizedBox(
        height: ekranYukseligi / 5.85,
        child: Card(
          elevation: 100,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: Colors.grey[400],
                  image: DecorationImage(
                    scale: 4.0,
                    fit: BoxFit.fitWidth,
                    image: AssetImage(imagePath),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locationName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    DateTime.now().toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
