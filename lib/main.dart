import 'dart:ui';
import 'screens/createYourchallenge.dart';
import 'screens/dailyTask.dart';
import 'screens/getChallenge.dart';
import 'screens/leaderboardadmin.dart';
import 'screens/login_register.dart';
import 'screens/calendar.dart';
import 'screens/ownerScreenPage.dart';
import 'screens/thehomepage.dart';
import 'screens/timer_screen.dart';
import 'screens/userLeaderBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Ressources/Ressources.dart';
import 'controller/timer_notification.dart';
import 'controller/user_controller.dart';

var pgHome;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*   Workmanager.initialize( 
        
        // The top level function, aka callbackDispatcher 
        callbackDispatcher, 
        
        // If enabled it will post a notification whenever 
        // the task is running. Handy for debugging tasks 
        isInDebugMode: true
    ); 
    // Periodic task registration 
    Workmanager.registerPeriodicTask( 
      "2", 
        
      //This is the value that will be 
      // returned in the callbackDispatcher 
      "simplePeriodicTask", 
        
      // When no frequency is provided 
      // the default 15 minutes is set. 
      // Minimum frequency is 15 min. 
      // Android will automatically change 
      // your frequency to 15 min 
      // if you have configured a lower frequency. 
      frequency: Duration(minutes: 1), 
    ); */

  var db = UserController();
  final prefs = await SharedPreferences.getInstance();
  //   await db.logOut();
  var t = prefs.getBool(shared_firstOpen);
  firstOpen = t == null;

  if (prefs.containsKey(shared_token) &&
      prefs.getString(shared_token) != null &&
      prefs.getString(shared_token) != '') {
    var v = await db.readUserInfo();
    if (UserController.user.role == 'owner')
      pgHome = OwnerScreen();
    else
      pgHome = TheHomePage();
    token = UserController.user.token;
  } else
    pgHome = LoginRegisterScreen(
      login: true,
    );

  runApp(new MyApp(home: pgHome));
  TimerNotif r = new TimerNotif(3600);
  prefs.setBool(shared_firstOpen, false);
}

class MyApp extends StatelessWidget {
  final home;

  const MyApp({Key key, this.home}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'My Mission',
        home: home,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //this is what you want
          accentColor: Colors.grey[300],
          accentColorBrightness: Brightness.light,
        ),
        routes: {
          '/home': (BuildContext context) => TheHomePage(),
          '/login': (BuildContext context) => LoginRegisterScreen(
                login: true,
              ),
          '/timer': (BuildContext context) => TimerScreen(),
          '/getCha': (BuildContext context) => GetCha(),
          '/calendar': (BuildContext context) => Calendar(),
          '/createCha': (BuildContext context) => yourChallenge(),
          '/dailyTask': (BuildContext context) => dailyTask(),
          '/leaderAdm': (BuildContext context) => LeaderBoardAdmin(),
          '/leaderUser': (BuildContext context) => LeaderBoard(),
        });
  }
}
