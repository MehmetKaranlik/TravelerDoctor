import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String locationNameDetailScreen;
  final String locationImagePathDetailScreen;
  final String? locationHistoryExplanation;
  @override
  _DetailScreenState createState() => _DetailScreenState();
  DetailScreen(
      this.locationNameDetailScreen, this.locationImagePathDetailScreen,
      {this.locationHistoryExplanation});
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                  child: Image.network(widget.locationImagePathDetailScreen)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 10, 3, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.locationNameDetailScreen.toString(),
                          style: TextStyle(
                              fontSize: 25,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    widget.locationNameDetailScreen.toString(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
