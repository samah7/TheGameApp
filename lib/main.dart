import 'dart:ui';

import 'package:chronometer/screens/began.dart';
import 'package:intl/intl.dart';

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

import 'package:flutter_local_notifications/flutter_local_notifications.dart'; 
//import 'package:workmanager/workmanager.dart'; 

var pgHome;

void main() async{
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
    final prefs =  await SharedPreferences.getInstance();
  //   await db.logOut();
  var t = prefs.getBool(shared_firstOpen);
  firstOpen = t==null;

     if(prefs.containsKey(shared_token)&& 
        prefs.getString(shared_token)!=null && 
        prefs.getString(shared_token)!='')
     {      
       var v = await db.readUserInfo();
       if(UserController.user.role=='owner')
        pgHome = OwnerScreen();
       else pgHome = TheHomePage();
       token = UserController.user.token;
     }
     else pgHome = LoginRegisterScreen(login: true,);

      runApp(new MyApp(home:pgHome));
     TimerNotif r= new TimerNotif(3600);
     prefs.setBool(shared_firstOpen, false);
}

  /*FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void callbackDispatcher() { 
  Workmanager.executeTask((task, inputData) { 
      
    // initialise the plugin of flutterlocalnotifications. 
      
    // app_icon needs to be a added as a drawable 
    // resource to the Android head project. 
    var android = new AndroidInitializationSettings('logo'); 
    var IOS = new IOSInitializationSettings(); 
      
    // initialise settings for both Android and iOS device. 
    var settings = new InitializationSettings(android: android, iOS: IOS); 
    flutterLocalNotificationsPlugin.initialize(settings); 
    //showNotificationWithDefaultSound(flip); 

     var h = DateFormat.H().format(DateTime.now());
    
      if((h=='20' || h=='08') )
      {
         //notified = true;
        _showNotificationWithSound('notif');
      }
    
    return Future.value(true); 
  }); 
} 
*/
/*
  Future _showNotificationWithSound(sound, {txtMsg=''}) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      sound:  RawResourceAndroidNotificationSound(sound),
      playSound: true,
      icon: "logo",
      largeIcon: DrawableResourceAndroidBitmap('logo'),
     // ledColor: Colors.red,
      ledOffMs: 500,
      ledOnMs: 1000,
      color : Colors.white,
      importance: Importance.max,
      priority: Priority.high);
  var iOSPlatformChannelSpecifics =  new IOSNotificationDetails(sound: "notif");
  var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  
  
  await flutterLocalNotificationsPlugin.show(
    0,
    txtMsg==''?
     'التوثيق اليومي' :
     '! أحسنت',
     txtMsg==''?
     'وثق يومك' :
     txtMsg,    
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}*/


class MyApp extends StatelessWidget {
  final home;

  const MyApp({Key key, this.home}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Mission',
      home:  home,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      /*   
        brightness: Brightness.light,

        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[50],
        primaryColorBrightness: Brightness.light,
      */

        //this is what you want
        accentColor: Colors.grey[300],
        accentColorBrightness: Brightness.light,
      ),
      routes: {
        '/home'       : (BuildContext context) => TheHomePage(),
        '/login'      : (BuildContext context) => LoginRegisterScreen(login: true,),
        '/timer'      : (BuildContext context) => TimerScreen(),
        '/getCha'     : (BuildContext context) => GetCha(),
        '/calendar'   : (BuildContext context) => Calendar(),
        '/createCha'  : (BuildContext context) => yourChallenge(),
        '/dailyTask'  : (BuildContext context) => dailyTask(),
        '/leaderAdm'  : (BuildContext context) => LeaderBoardAdmin(),
        '/leaderUser' : (BuildContext context) => LeaderBoard(),
      }
    );
  }
}
