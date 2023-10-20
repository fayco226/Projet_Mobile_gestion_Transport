import 'package:flutter/material.dart';
import 'package:apptravel/Screens/Welcome/welcome_screen.dart';
import 'package:apptravel/constants.dart';
import 'package:apptravel/begin/GeneratedFrame2Widget.dart';
import 'package:apptravel/body/home.dart';
import 'package:apptravel/body/bouton.dart';
import 'package:apptravel/database/database.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool response = false;

  @override
  void initState() {
    super.initState();
    cheickResponce();
    print(response);
  }

  void cheickResponce() async {
    final responceConnection = await connection();
    if (responceConnection == true) {
      setState(() {
        response = true;
      });
    }
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: response ? HomePage() : const WelcomeScreen(),
    );
  }
}
