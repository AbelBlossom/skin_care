import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/bloc/bot.dart';
import 'package:skin_care/bloc/navigator.dart';
import 'package:skin_care/screens/home.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Bot(),
          ),
          Provider(
            create: (_) => NavigatorBloc(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xf1f1f1f1),
        primaryColor: Color(0xff3090c7),
      ),
      home: SkinCare(),
    );
  }
}
