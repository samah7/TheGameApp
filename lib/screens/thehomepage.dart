import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart'; 
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart'; 
import '../Ressources/Ressources.dart';
import '../controller/function.dart';
import '../controller/user_controller.dart';
//import 'dart:io'; 


class TheHomePage extends StatefulWidget {
  TheHomePage({Key key}) : super(key: key);

  @override
  _TheHomePageState createState() => _TheHomePageState();
} 



class _TheHomePageState extends State<TheHomePage> { 
  //File _image; 
  //Image _image; 
  String urlavatar = ''; 
  bool loadPrs = false; 
  UserController db = UserController();
  
  initState(){
    loadHeroPic();
    
     final player = AudioCache();
     if(firstOpen)
     player.play('audio/notif.mp3');
     firstOpen = false;
     
    super.initState();
  }

  loadHeroPic ()async{
    String val;
    if (UserController.user.pictureName == null || UserController.user.pictureName == '')
    val = await db.getPicture(); 
    else val = UserController.user.pictureName;
    setState(() {
      if (val!=null && val!= '')
      urlavatar = val;     
      else urlavatar = 'assets/images/imageprofile.png';
    });
  }
  _imgFromGirl() async{
      String urlavatar1 =  'assets/imageavatar/heroine.jpg'; 
      setState(() {
        urlavatar = urlavatar1; 
      });
      Navigator.of(context).pop();
      await db.addPicture(urlavatar);
  } 
   _imgFromBoy() async{
      String urlavatar2 = 'assets/imageavatar/hero.jpg';   
      setState(() {
          urlavatar = urlavatar2; 
      });
      Navigator.of(context).pop();
      await db.addPicture(urlavatar);
  } 
   //function to choose what we need to do add by camera or bay gallery 

    void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(MdiIcons.genderMale), 
                      title: new Text(''),
                      onTap: _imgFromBoy,
                       
                      ), 
                      new ListTile(
                    leading: new Icon(MdiIcons.genderFemale), 
                    title: new Text(''),
                    onTap:  _imgFromGirl,
                  ),
                ],
              ),
            ),
          );
        });
  } 

  @override 
    Widget build(BuildContext context) { 
      cxt_contextTawrhik = context;
      String nameHero = UserController.user.name?? 'اسم البطل'; 
      var H = MediaQuery.of(context).size.height;
      var W = MediaQuery.of(context).size.width;

      var topVide    = H * 0.098;

      var brHeroName = H * 0.053; 
      var afHeroName = H * 0.077;
      var btwElem    = W * 0.1;
      var arElem     = H * 0.027;

      var afRow      = H * 0.1;
      //var bhdElem    = W * .07;

      var hAvatar    =  W * 0.42;
      var hElem      =  H * 0.13;
      var wElem      =  W * 0.2;

      var hBtn       =  H * 0.073;
      var wBtn       =  W * 0.4;
      var fntTitle   =  H * 0.06;//w * 0.12;// W * 0.067;//H * 0.12;//
      if(fntTitle>49)
      fntTitle = 49;
      var fntElem    =  H * 0.03;//w * 0.057;// W * 0.032;//H * 0.057
      if (fntElem>22)
      fntElem = 22;
      var hContHero  =  H * 0.063;

      return Scaffold(
     /* appBar: AppBar( 
         leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Color(0xff000000)), 
                   onPressed: () {}), 
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(''),
      ), */

      
       
  body: ListView( 
    padding: EdgeInsets.only(top:12 ), 
    scrollDirection: Axis.vertical, 
    children: <Widget>[ 
     /* IconButton(
        padding:EdgeInsets.only(left:10, top:2 ), 
        icon: Align(alignment: Alignment.bottomLeft, child: Image.asset('assets/images/back.png',scale: 5,)), 
        onPressed: () {}),*/
      Padding(padding: EdgeInsets.only(top: topVide -12)),
      Align( 
        alignment: Alignment.center, 
        child: Container(
                  height: hAvatar, width: hAvatar,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 75, 
                          backgroundColor: Colors.transparent,  
                          child:urlavatar==''? Text(''):  //urlavatar == ''?
                          ClipOval(
                              child: Image.asset( urlavatar, 
                              fit: BoxFit.cover,),), 
                        ),
                        Positioned(bottom: 2.0, right:2.0 ,child: Container(
                          height: 43, width: 43,
                          child: IconButton(icon: Icon(Icons.add_a_photo, color: Colors.black),
                        color: Color(0xffFFFFFF), 
                        iconSize: 32.0,                           
                                    onPressed: (){
                                        _showPicker(context); 
                                    }, 
                          
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent, 
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ))
                      ],
                    ),
                ),
      ), 
   
     SizedBox(height: brHeroName), 
     Container(
       height: hContHero,
       child: Text(  nameHero, 
              textAlign: TextAlign.center,  
              style: new TextStyle(
                          fontSize: fntTitle, 
                          color: Color(0xff000000), 
                          fontWeight: FontWeight.bold, 
                          fontFamily: fntAljazeera,
                          height: 1,
                          ), 
              ),
     ),  
          SizedBox(height: afHeroName), 
          Container(
            width: W,
           // padding: EdgeInsets.only(right:bhdElem,left:bhdElem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[   
                Column( 
                  children: <Widget>[ 
                      GestureDetector(
                          onTap: () {
                          print('ce ceci est un essaie'); 
                          if(UserController.user.role!='admin')
                            Navigator.of(context).pushNamed('/leaderUser');
                          else Navigator.of(context).pushNamed('/leaderAdm');
                          }, 
                          child: Container( 
                                    height: hElem, 
                                    width: wElem,  
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/leaderboard.png'), 
                                          fit: BoxFit.contain,  
                                        ), 
                                      ),  
                          ), 
                      ), 
                      Padding(padding: EdgeInsets.only(top:arElem)), 
                      Text('المتصدرين', 
                        textAlign: TextAlign.center,  
                        style: new TextStyle(
                                      fontSize: fntElem, 
                                      fontFamily: fntAljazeera,
                                      color: Color(0xff000000), 
                                      fontWeight: FontWeight.bold, 
                                      height: 1
                                      ),                     
                      ),              
                  ], 
                ), 
                SizedBox(width: btwElem),  
                Column( 
                  children: <Widget>[ 
                      GestureDetector(
                          onTap: () {
                                       print('ce ceci est un essaie'); 
                                       Navigator.of(context).pushNamed('/calendar');
                                  }, 
                          child: Container(
                            height: hElem, 
                            width: wElem,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/chanllenges.png'), 
                                fit: BoxFit.contain,  
                              ), 
                            ),  
                          ), 
                      ),
                      Padding(padding: EdgeInsets.only(top:arElem)),
                      Text('التحدي', 
                        textAlign: TextAlign.center,  
                        style: new TextStyle(
                                      fontSize: fntElem, 
                                      fontFamily: fntAljazeera,
                                      color: Color(0xff000000), 
                                      fontWeight: FontWeight.bold, 
                                      height: 1
                                      ),            
                      )                
                  ], 
                ), 
                SizedBox(width: btwElem), 
                Column( 
                    children: <Widget>[ 
                        GestureDetector(
                            onTap: () {
                                Navigator.of(context).pushNamed('/timer');
                            }, 
                            child: Container( 
                              height: hElem, 
                              width: wElem,  
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/capsule.png'), 
                                    fit: BoxFit.contain,  
                                  ), 
                              ),  
                            ), 
                        ),  
                        Padding(padding: EdgeInsets.only(top:arElem)),
                        Text('الكبسولات', 
                          textAlign: TextAlign.center,  
                          style: new  TextStyle(
                                          fontSize: fntElem, 
                                          fontFamily: fntAljazeera,
                                          color: Color(0xff000000), 
                                          fontWeight: FontWeight.bold, 
                                          height: 1
                                      ),                       
                        )  
                 
                    ], 
                ),  
              ], 
            ),
          ), 
          SizedBox(height: afRow),  
          Container( 
              //width: MeiaQuery.of(context).size.width, 
              height: hBtn, 
              width: wBtn, 
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(loadPrs? 'assets/images/exitpressed.png': 'assets/images/exitnopressed.png'), 
                  fit: BoxFit.contain,  
                ), 
              ), 
              child: InkWell( 
                      splashColor: Colors.transparent, 
                      highlightColor: Colors.transparent, 
                      onTapCancel: (){
                          setState((){
                            loadPrs = true; 
                          }); 
                      }, 
                      onLongPress: (){
                          setState((){
                            loadPrs = false; 
                          }); 
                      }, 
                      onTapDown: (val){
                          setState((){
                            loadPrs = true; 
                          }); 
                      }, 
                      onTap: (){
                        Future.delayed(durPress, () => "2").then((onValue){
                          setState(() {
                            loadPrs = false; 
                          }); 
                        }); 
                            fctExit(context);
                      },                   
                    ), 
          ), 
          SizedBox(height: afRow), 
    ], 
  )

 
      );  
    } 
} 
