import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Pages imports
import 'appContainer.dart';

void main()
{
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_) {
    runApp(myApp());
  });
}

MaterialApp myApp()
{
  return new MaterialApp(
      home: new AppContainer(),
      theme: ThemeData(
        brightness: Brightness.dark,

        primaryColor: Color.fromRGBO(30, 30, 30, 1),

        fontFamily: "OpenSans"

      ),
  );
}