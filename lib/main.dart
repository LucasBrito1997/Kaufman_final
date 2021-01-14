import 'package:flutter/material.dart';
import 'package:oroscopio/camera_page.dart';
import 'package:oroscopio/info_page.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(MyApp());

ThemeData buildTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    hintColor: Colors.green,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black, fontSize: 24.0),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "Oroscópio APP",
      home: MyHomePage(
        title: "Oroscopio App",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
          child: Form(
              child: Column(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF00C853), Color(0xFFB9F6CA)]),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  child: Text('Aplicativo',
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontStyle: FontStyle.italic)),
                ),
                Align(
                  child: Text('Oroscópio',
                      style: TextStyle(
                          fontSize: 60.0,
                          color: Colors.white,
                          fontStyle: FontStyle.italic)),
                ),
              ],
            )),
        Container(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Home(
                                  channel: IOWebSocketChannel.connect(
                                      'ws://192.168.4.1:8888'),
                                )));
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(80.0))),
                    padding: const EdgeInsets.only(
                        top: 10, left: 140, right: 140, bottom: 10),
                    child: const Text(
                      'Câmera',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
              ],
            )),
        Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Info()));
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(80.0))),
                    padding: const EdgeInsets.only(
                        top: 10, left: 120, right: 120, bottom: 10),
                    child: const Text(
                      'Informações',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ))
      ]))), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
