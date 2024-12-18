import 'package:auto_route/annotations.dart';
import 'package:demofirst/theme/colors.dart';
import 'package:demofirst/theme/themes.dart';
import 'package:flutter/material.dart';


@RoutePage()
class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String amount;

  const DetailScreen({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        title: Text('Item Details', style: themeData().primaryTextTheme.headlineMedium,),
        backgroundColor: appbarColor
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InteractiveViewer(
              panEnabled: true,
              minScale: 0.1,
              maxScale: 1.5,
              child: Image.network(imageUrl),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: themeData().primaryTextTheme.headlineSmall,
            ),
            SizedBox(height: 10),
            Text(
              amount,
              style: themeData().primaryTextTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
