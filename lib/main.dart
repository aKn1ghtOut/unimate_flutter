import 'package:flutter/material.dart';

//Pages imports
import 'appContainer.dart';

void main()
{
  runApp(myApp());
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