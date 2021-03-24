import 'package:chronometer/Ressources/Ressources.dart';
import 'package:chronometer/widgets/alert.dart';
import 'package:flutter/cupertino.dart';
import '../controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../controller/function.dart';

class dailyTask extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return new dailyTaskstate();
  }
}
class  dailyTaskstate extends State<dailyTask>{
  var containerkey=GlobalKey();
  

  /////////////
  Image im2 = Image.asset("assets/images/exercise-1.png", scale: 4,);
  Image im3 = Image.asset("assets/images/pencil.png", scale: 4,);
  Image im4 = Image.asset("assets/images/exercise.png", scale: 4,);
  Image im5 = Image.asset("assets/images/aim.png", scale: 4,);
  Image im6 = Image.asset("assets/images/gift.png", scale: 4,);


  bool status  = UserController.user.task1;
  bool status2 = UserController.user.task2;
  bool status3 = UserController.user.task3;
  bool status4 = UserController.user.task4;
  bool status5 = UserController.user.task5;
  bool status6 = UserController.user.task6;
 // double h=70;
  double c=15;
  bool loadPrs=false;
  int point;
  String resmessage='';
  UserController nchallenge= new UserController();
  @override
  Widget build(BuildContext context) {
  var urlavatar=UserController.user.pictureName;
    if(urlavatar==null || urlavatar.trim()=='')
    urlavatar='';
    var size = MediaQuery.of(context).size;
    double h=size.height*.10;

    var fntelm=size.width*.036;
    if (fntelm>15)
    fntelm=15;

    var fntTitle=19.0;//size.height*.035;
    if (fntTitle>30)
    fntTitle=30;

  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(size.height*.15), // here the desired height
      child: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
           
        child: AppBar(
            leading: IconButton(
              // padding: EdgeInsets.only(top: 20),
              icon: Image.asset('assets/images/back.png',scale: 5,),
              onPressed: () {
               if(Navigator.of(context).canPop())
                  Navigator.of(context).pop();//('/calendar');               
                Navigator.of(context).pushNamed('/calendar');
              } 
            ),
            automaticallyImplyLeading: false,
            elevation: 9.0,
            backgroundColor: Colors.white70,
            centerTitle: true,
            flexibleSpace: Container(
                alignment: Alignment.center,
                //padding: EdgeInsets.only(top:size.height*.2),
                child:Container(
                  margin: EdgeInsets.only(top:fntTitle),
                    child: Text('مهام اليوم', textAlign: TextAlign.justify, style: TextStyle(fontSize: size.width*.10,color: Colors.black,fontFamily: fntAljazeera))),),
            //alignment: Alignment.centerRight,
            actions:
            //crossAxisAlignment: CrossAxisAlignment.end,
            [
              //padding: EdgeInsets.only(right:78,top: 50),),
              Container(
                margin: EdgeInsets.only(right: size.width*.03,top: size.height*.03),
                child:CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius:21,
                  child: urlavatar==''? Text(''):  
                     ClipOval( child:Image.asset(urlavatar,fit: BoxFit.cover,)),
                  ), )
              // Center(child:Text('مهام اليوم', textAlign: TextAlign.center, style: TextStyle(fontSize: 45,color: Colors.black),),),

            ],

            ////rounded corners
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(35),
              ),
            ),
           )),// shadowColor: Colors.black),
      ),
    ),
    body: SingleChildScrollView(
         child:Stack(
          children:[  Container(
           //height: MediaQuery.of(context).size.height,
           // width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top:  size.height*.033),
                child: Center(child:Column(
                children:<Widget> [
                Container(
                width: size.width*.83,
                    height:h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(c),
                      border: Border.all(
                          color: Colors.black
                      )  , ),
                  child: Row(children: [
                     ////switch
                     Container(
                       margin:EdgeInsets.only(left: 20),
                       child: FlutterSwitch(
                       activeColor: Colors.black,
                       inactiveColor: Colors.green,
                       width:56.0,
                       height: 29.0,
                       valueFontSize: 25.0,
                       toggleSize: 15.0,
                       value: status,
                       borderRadius: 30.0,
                       padding: 6.0,
                       showOnOff: false,
                       onToggle: (val) {
                         setState(() {
                           status = val;
                           
                            UserController.user.task1 = status;
                            nchallenge.saveTask(status, status2, status3, status4, status5, status6);
                         });
                       },
                     ),),
                    ////task

                    Expanded(

                      child:Container(
                        margin: EdgeInsets.only(right:10),
                        child:

                      Column(

                      crossAxisAlignment: CrossAxisAlignment.end,
                        children:[Text('النوم',textDirection: TextDirection.rtl ,style:TextStyle(fontSize: fntTitle,fontWeight: FontWeight.bold,fontFamily: fntAljazeera,)),
                          Container(margin: EdgeInsets.only(right:size.width*.03 ),
                            child: Text('2 نقطة',textDirection: TextDirection.rtl ,style:TextStyle(color:Color(0x80000000),fontSize: fntelm,height:0.5,fontFamily: fntAljazeera)),
                          )
                        ]),),),
                    ////icon
                    Container(
                      margin: EdgeInsets.only(right:20),
                        child:Image.asset('assets/images/sleeping.png',scale: 4,)),


                    ],),
                ),
                  Padding(padding: EdgeInsets.only(top: size.height*.013),),
                  Container(
                    width: size.width*.83,
                    height:h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(c),
                      border: Border.all(
                          color: Colors.black
                      )  , ),
                    child: Row(children: [
                      ////switch
                      Container(
                        margin:EdgeInsets.only(left: 20),
                        child: FlutterSwitch(
                          activeColor: Colors.black,
                          inactiveColor: Colors.green,
                          width:56.0,
                          height: 29.0,
                          valueFontSize: 25.0,
                          toggleSize: 15.0,
                          value: status2,
                          borderRadius: 30.0,
                          padding: 6.0,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              status2 = val;
                              
                              UserController.user.task2 = status2;
                              nchallenge.saveTask(status, status2, status3, status4, status5, status6);
                            });
                          },
                        ),),
                      ////task

                      Expanded(

                        child:Container(
                          margin: EdgeInsets.only(right:10),
                          child:

                          Column(

                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:[Text('الصلاة/التأمل',textDirection: TextDirection.rtl ,style:TextStyle(fontSize: fntTitle,fontWeight: FontWeight.bold,fontFamily: fntAljazeera,)),
                                Container(margin: EdgeInsets.only(right:size.width*.03 ),
                                  child: Text('2 نقطة',textDirection: TextDirection.rtl ,style:TextStyle( color:Color(0x80000000),fontSize: fntelm,height:0.5,fontFamily: fntAljazeera)),
                                )
                              ]),),),
                      ////icon
                         Container(
                          margin: EdgeInsets.only(right:20),
                          child:Image.asset('assets/images/exercise-1.png',scale: 4,)),


                    ],),
                  ),
                  Padding(padding: EdgeInsets.only(top: size.height*.013),),
                  Container(
                    width: size.width*.83,
                    height:h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(c),
                      border: Border.all(
                          color: Colors.black
                      )  , ),
                    child: Row(children: [
                      ////switch
                      Container(
                        margin:EdgeInsets.only(left: 20),
                        child: FlutterSwitch(
                          activeColor: Colors.black,
                          inactiveColor: Colors.green,
                          width:56.0,
                          height: 29.0,
                          valueFontSize: 25.0,
                          toggleSize: 15.0,
                          value: status3,
                          borderRadius: 30.0,
                          padding: 6.0,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              status3 = val;
                              UserController.user.task3 = status3;
                              nchallenge.saveTask(status, status2, status3, status4, status5, status6);
                            });
                          },
                        ),),
                      ////task

                      Expanded(

                        child:Container(
                          margin: EdgeInsets.only(right:20),
                          child:

                          Column(

                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:[Text('التعلم',textDirection: TextDirection.rtl ,style:TextStyle(fontSize: fntTitle,fontWeight: FontWeight.bold,fontFamily: fntAljazeera,)),
                                Container(margin: EdgeInsets.only(right:size.width*.021 ),
                                  child: Text('2 نقطة',textDirection: TextDirection.rtl ,style:TextStyle(color:Color(0x80000000),fontSize: fntelm,height:0.5,fontFamily: fntAljazeera)),
                                )
                              ]),),),
                      ////icon
                      Container(
                          margin: EdgeInsets.only(right:20),
                          child:Image.asset('assets/images/pencil.png',scale: 4,)),


                    ],),
                  ),
                  Padding(padding: EdgeInsets.only(top: size.height*.013),),
                  Container(
                    width: size.width*.83,
                    height:h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(c),
                      border: Border.all(
                          color: Colors.black
                      )  , ),
                    child: Row(children: [
                      ////switch
                      Container(
                        margin:EdgeInsets.only(left: 20),
                        child: FlutterSwitch(
                          activeColor: Colors.black,
                          inactiveColor: Colors.green,
                          width:56.0,
                          height: 29.0,
                          valueFontSize: 25.0,
                          toggleSize: 15.0,
                          value: status4,
                          borderRadius: 30.0,
                          padding: 6.0,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              status4 = val;
                              UserController.user.task4 = status4;
                              nchallenge.saveTask(status, status2, status3, status4, status5, status6);
                            });
                          },
                        ),),
                      ////task

                      Expanded(

                        child:Container(
                          margin: EdgeInsets.only(right:15),
                          child:

                          Column(

                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:[Text('الرياضة',textDirection: TextDirection.rtl ,style:TextStyle(fontSize: fntTitle,fontWeight: FontWeight.bold,fontFamily: fntAljazeera,)),
                                Container(margin: EdgeInsets.only(right:size.width*.03 ),
                                child:                                 Text('1 نقطة',textDirection: TextDirection.rtl ,style:TextStyle(color:Color(0x80000000),fontSize: fntelm,height:0.5,fontFamily: fntAljazeera)),
                                    )
                              ]),),),
                      ////icon
                      Container(
                          margin: EdgeInsets.only(right:20),
                          child:Image.asset('assets/images/exercise.png',scale: 4,)),


                    ],),
                  ),
                  Padding(padding: EdgeInsets.only(top: size.height*.013),),
                  Container(
                    width: size.width*.83,
                    height:h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(c),
                      border: Border.all(
                          color: Colors.black
                      )  , ),
                    child: Row(children: [
                      ////switch
                      Container(
                        margin:EdgeInsets.only(left: 20),
                        child: FlutterSwitch(
                          activeColor: Colors.black,
                          inactiveColor: Colors.green,
                          width:56.0,
                          height: 29.0,
                          valueFontSize: 25.0,
                          toggleSize: 15.0,
                          value: status5,
                          borderRadius: 30.0,
                          padding: 6.0,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              status5 = val;                              
                              UserController.user.task5 = status5;
                              nchallenge.saveTask(status, status2, status3, status4, status5, status6);
                            });
                          },
                        ),),
                      ////task

                      Expanded(

                        child:Container(
                          margin: EdgeInsets.only(right:10),
                          child:

                          Column(

                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:[Text('الهدف',textDirection: TextDirection.rtl ,style:TextStyle(fontSize: fntTitle,fontWeight: FontWeight.bold,fontFamily: fntAljazeera,)),
                               Container( margin: EdgeInsets.only(right:size.width*.03),
                                   child: Text('2  نقطة',textDirection: TextDirection.rtl ,style:TextStyle(color:Color(0x80000000),fontSize: fntelm,height:0.5,fontFamily: fntAljazeera)),)
                              ]),),),
                      ////icon
                      Container(
                          margin: EdgeInsets.only(right:20),
                          child:Image.asset('assets/images/aim.png',scale: 4,)),


                    ],),
                  ),
                  Padding(padding: EdgeInsets.only(top: size.height*.013),),
                  Container(
                    width: size.width*.83,
                    height:h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(c),
                      border: Border.all(
                          color: Colors.black
                      )  , ),
                    child: Row(children: [
                      ////switch
                      Container(
                        margin:EdgeInsets.only(left: 20),
                        child: FlutterSwitch(
                          activeColor: Colors.black,
                          inactiveColor: Colors.green,
                          width:56.0,
                          height: 29.0,
                          valueFontSize: 25.0,
                          toggleSize: 15.0,
                          value: status6,
                          borderRadius: 30.0,
                          padding: 6.0,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              status6 = val;
                              UserController.user.task6 = status6;
                              nchallenge.saveTask(status, status2, status3, status4, status5, status6);
                            });
                          },
                        ),),
                      ////task

                      Expanded(

                        child:Container(
                          margin: EdgeInsets.only(right:10),
                          child:

                          Column(

                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:[Text('المكافأة',textDirection: TextDirection.rtl ,style:TextStyle(fontSize: fntTitle,fontWeight: FontWeight.bold,fontFamily: fntAljazeera,)),
                               Container(
                                 margin: EdgeInsets.only(right:size.width*.03),
                                   child:  Text('1  نقطة',textDirection: TextDirection.rtl ,style:TextStyle(color:Color(0x80000000),fontSize: fntelm,height:0.5,fontFamily: fntAljazeera)),)
                              ]),),),
                      ////icon
                      Container(
                          margin: EdgeInsets.only(right:20),
                          child:Image.asset('assets/images/gift.png',scale: 4,)),


                    ],),
                  ),
                  Padding(padding: EdgeInsets.only(top:size.height*.02),),
                  Container(
                    key: containerkey,
                    // margin: EdgeInsets.only(right: 300,top: 0),
                      height:size.height*.07,
                      width:size.width*.40,
                      //alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        image:DecorationImage(
                          image:AssetImage(loadPrs?'assets/images/finish2.png':'assets/images/finish1.png'),
                          fit: BoxFit.cover,),
                      ),
                      //margin: EdgeInsets.only(left: 15),
                      child:InkWell(
                          splashColor: Colors.transparent,
                          highlightColor:Colors.transparent ,
                          onTapCancel: (){
                            setState(() {
                              loadPrs=true;
                            });
                          },
                          onLongPress: (){setState(() {
                            loadPrs=false;
                          });},
                          onTapDown: (val){setState(() {
                            loadPrs=true;
                          });},
                          onTap:()async{
                            setState(()  {
                              loadPrs=true;
                            });

                              Future.delayed(durPress,).then((onValue){
                                setState(() {
                                  loadPrs=false;
                                });
                              });

                              point=sumpoint(status,status2,status3,status4,status5,status6);
                              if (point==0){
                                resmessage='قم باءدخال نقاطك لهذا اليوم';
                              }else{
                                await nchallenge.addDaypoint(point);

                                  setState(() {
                                  resmessage=nchallenge.rsponseMsg;

                                   /* status  = true;
                                    status2 = true;
                                    status3 = true;
                                    status4 = true;
                                    status5 = true;
                                    status6 = true;*/
                                  });

                              }

                              Future.delayed(Duration(seconds: 1)).then((onValue){
                                setState(() {
                                  //loadPrs=false;
                                  resmessage='';



                                });
                              });
                          })

                  ),

                ]))),
             (resmessage).trim()==''?Text('') :
             alertMsg(context,resmessage,containerkey, marge: 142), 
         ] ),
          ));



  }






  }


