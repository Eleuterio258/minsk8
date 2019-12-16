// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:state_persistence/state_persistence.dart';
import './screens/home.dart';
import './screens/map.dart';
import "./screens/image_pinch.dart";
import "./screens/image_capture.dart";
import './screens/image.dart';
import './screens/showcase.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PersistedAppState(
      storage: JsonFileStorage(),
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Flutter Map Example',
        // theme: ThemeData(
        //   primarySwatch: mapBoxBlue,
        // ),
        home: HomeScreen(),
        routes: <String, WidgetBuilder>{
          '/map': (context) => MapScreen(),
          '/image_pinch': (context) => ImagePinchScreen(),
          '/image_capture': (context) => ImageCaptureScreen(),
          '/image': (context) => ImageScreen(),
          '/showcase': (context) => ShowcaseScreen(),
        },
        onGenerateRoute: (settings) {
          print(settings);
          return null;
        },
      ),
    );
  }
}

// Generated using Material Design Palette/Theme Generator
// http://mcg.mbitson.com/
// https://github.com/mbitson/mcg
// const int _bluePrimary = 0xFF395afa;
// const MaterialColor mapBoxBlue = MaterialColor(
//   _bluePrimary,
//   <int, Color>{
//     50: Color(0xFFE7EBFE),
//     100: Color(0xFFC4CEFE),
//     200: Color(0xFF9CADFD),
//     300: Color(0xFF748CFC),
//     400: Color(0xFF5773FB),
//     500: Color(_bluePrimary),
//     600: Color(0xFF3352F9),
//     700: Color(0xFF2C48F9),
//     800: Color(0xFF243FF8),
//     900: Color(0xFF172EF6),
//   },
// );
