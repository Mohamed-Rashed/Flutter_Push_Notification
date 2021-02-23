import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterpush/push_notification.dart';
import 'package:overlay_support/overlay_support.dart';


final FlutterLocalNotificationsPlugin fLNP = FlutterLocalNotificationsPlugin();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var initSettingsAndroid = AndroidInitializationSettings("app_icon");
  var initSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async {},
  );
  var initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );
  await fLNP.initialize(
    initSettings,
    // ignore: missing_return
    onSelectNotification: (String payload) {
      if (payload != null) {
        debugPrint(payload);
      }
    },
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) => OverlaySupport(
        child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
      )
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  @override
  Widget build(BuildContext context) {
    final PushNotificationService _service = PushNotificationService(_fcm);
    _service.initialize(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text("hellllllllllllo"),
        ),
      ),
    );
  }
}
