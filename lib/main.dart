import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //declarar clase notificadora
  late FlutterLocalNotificationsPlugin _fnp;

  @override
  void initState() {
    super.initState();
    var ais = const AndroidInitializationSettings('face_icon');
    var iis = const IOSInitializationSettings();
    var iss = InitializationSettings(android: ais, iOS: iis);
    _fnp = FlutterLocalNotificationsPlugin();
    _fnp.initialize(iss, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String? payload) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Notificacion"),
              content: Text(payload!),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'App Notification Sample',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNotification();
        },
        tooltip: 'Notify',
        child: const Icon(Icons.message_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future showNotification() async {
    int identi = Random().nextInt(16);
    //print('Show notification id: $identi');
    var ands = const AndroidNotificationDetails("channelId-0", "channelName",
        channelDescription: "Test Class",
        playSound: true,
        importance: Importance.high,
        priority: Priority.max);
    var inds = const IOSNotificationDetails(presentSound: true);
    var nd = NotificationDetails(android: ands, iOS: inds);
    _fnp.show(identi, "Notification", "Hello World!", nd,
        payload: "Hello World!");
  }
}
