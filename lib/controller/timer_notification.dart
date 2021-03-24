import 'dart:async';

import 'package:chronometer/Ressources/Ressources.dart';
import 'package:chronometer/controller/user_controller.dart';
import 'package:chronometer/screens/calendar.dart';
import 'package:chronometer/screens/dailyTask.dart';
import 'package:chronometer/screens/thehomepage.dart';
import 'package:chronometer/screens/timer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class TimerNotif with WidgetsBindingObserver {
 int dur;
 
  AppLifecycleState _notification;

  TimerNotif.runTimer(){   
    WidgetsBinding.instance.addObserver(this);
    countDownTimer();
  }
  
  
  countDownTimer() async {  
    UserController db = UserController();
      for (int x = durGlobal.inSeconds; x >= 0; x--) {
        await Future.delayed(Duration(seconds: 1)).then((_) {
            // timerCount -= 1;
            durGlobal = Duration(seconds:x);
        });
      }
    
    var  val= (durInitGlobal.inSeconds - durGlobal.inSeconds)/(valueCpl*60);
    if (val>=1)// && duration.inSeconds==0)
    {
      //nbCblG += (durInitGlobal.inMinutes - durGlobal.inMinutes)~/valueCpl;
      durInitGlobal = durGlobal;
      await db.saveCpsl(nbCblG);

      if(durGlobal.inSeconds == 0)
      {
        isRunningInBack = false; 
        TimerNotif.timerEnd();
      } 
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {    
      _notification = state;
  }

  TimerNotif.timerEnd(){    
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('logo'); 
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotificationTimer);
    WidgetsBinding.instance.addObserver(this);     
    
      _showNotificationWithSound('capsuleend', txtMsg:'أحسنت لقد أنهيت كبسولاتك');
    
  }
  
    TimerNotif(this.dur){    
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('logo'); 
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:onSelectNotification);
    WidgetsBinding.instance.addObserver(this);
    
         /*  onSelectNotification: (String payload) async {
                                  await Navigator.of(cxt_context).pushNamed('/calendar');
                                 });*/
    
  
   /* if (first)
      _showNotificationWithSound();

    else*/ {
      var h = DateFormat.H().format(DateTime.now());
      if((h=='20' /*|| h=='08'*/)&& (!firstOpen) && (!notified) )
      {
         notified = true;
        _showNotificationWithSound('notif');
      }
      var timer = Timer.periodic(Duration(seconds: dur), (Timer t){
       h = DateFormat.H().format(DateTime.now());
    /*  var min = DateTime.now().minute;
      int dif=1;
      if(UserController.user.lastDatePoint!=null && DateTime.parse(UserController.user.lastDatePoint)!=null)
      dif = DateTime.now().difference(DateTime.parse(UserController.user.lastDatePoint)).inDays;

      bool notYet =UserController.user.lastDatePoint==null && (dif>=1);*/
      
      if((h=='20'/* || h=='08'*/) && !notified )
      {
         notified = true;
        _showNotificationWithSound('notif');
      }
     });
     
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
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

  /*if(dur>0)
  await flutterLocalNotificationsPlugin.schedule(
    0,
    'التوثيق اليومي',
    'وثق يومك',
    dur,
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );*/
}

  
  
   Future onSelectNotification(String payload) async {
    //convert payload json to notification model object
    try{
    /*await Navigator.push(
        cxt_contextTawrhik,// it`s null!
        new MaterialPageRoute(
            builder: (context) => dailyTask()));*/
            
        }
            catch(e){print(e.toString());}
    }



   
   Future onSelectNotificationTimer(String payload) async {
    //convert payload json to notification model object
    try{

    await Navigator.push(
        cxt_contextTimer,// it`s null!
        new MaterialPageRoute(
            builder: (context) => TimerScreen()),
            
            );
        }

            catch(e){print(e.toString());}
    }
  

}