import 'Utils/ApplicationUtils.dart';
import 'package:flutter/material.dart';
import 'UI/login_page.dart';
import 'UI/home_page.dart';
import 'exotelSDK/ExotelSDKClient.dart';
import 'UI/call_page.dart';
import 'callStates/connected.dart';
import 'callStates/ringing.dart';
import 'callStates/dtmf_page.dart';
import 'callStates/incoming.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Service/PushNotificationService.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();//TBD
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var mApplicationUtil =  ApplicationUtils.getInstance(context);
    ExotelSDKClient exotelSDKClient = ExotelSDKClient.getInstance();
    exotelSDKClient.setExotelSDKCallback(mApplicationUtil);
    exotelSDKClient.registerMethodHandler();
    //TBD
    PushNotificationService pushNotificationService = PushNotificationService.getInstance();
    pushNotificationService.initialize();
    //
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(),
        '/call': (context) => CallPage(),
        '/ringing': (context) => Ringing(),
        '/connected': (context) => Connected(),
        '/incoming': (context) => Incoming(),
        '/dtmf': (context) => DtmfPage(),
      },
      debugShowCheckedModeBanner: false,
      title: ' Exotel Sample App',
      theme: ThemeData(
        // Your theme data
      ),
      home: FutureBuilder<bool>(
        future: ExotelSDKClient.getInstance().loginstatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading spinner while waiting for future to complete
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              ExotelSDKClient.requestPermissions(); // Request permissions at app launch
              return (snapshot.data ?? false) ? const HomePage() : LoginPage(
                onLoggedin: (userId, password, accountSid, hostname) {
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                    arguments: {'userId': userId, 'password': password, 'accountSid': accountSid, 'hostname': hostname },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
