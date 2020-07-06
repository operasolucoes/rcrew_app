import 'package:flutter/material.dart';
import 'mobileui.dart' if (dart.library.html) 'webui.dart' as multiPlatform;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'R-Crow',
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home:  multiPlatform.TestPlugin(),
      debugShowCheckedModeBanner: false,
    );
  }
}

