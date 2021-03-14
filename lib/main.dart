import 'package:flutter/material.dart';
import 'package:http_login_app/pages/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 22.0, color: Colors.redAccent),
            headline2: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: Colors.redAccent),
            bodyText1: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.blueAccent)),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   // title: Text("Login Page"),
      // ),
      body: LoginPage(),
    );
  }
}
