import 'package:chronometer/Ressources/Ressources.dart';
import 'package:chronometer/widgets/alert.dart';

import '../widgets/widgetText.dart';
import 'package:flutter/material.dart';
import'../controller/user_controller.dart';
import 'dart:async';

class yourChallenge extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return yourChallengestata();
  }

}
class yourChallengestata extends State<yourChallenge>{

  var containerkey=GlobalKey();
 String respnmsg='';
 UserController ch=new UserController();

  Image icon1 = Image.asset("assets/images/account.png", scale: 4,);
  Image icon2 = Image.asset("assets/images/goal.png", scale: 4,);
  Image icon3 = Image.asset("assets/images/inste.png", scale: 4,);
  ////declaration of strings of texts
  String txt1 = 'اسم البطل';
  String txt2 = 'الهدف ';
  String txt3 = 'حساب الانستغرام';
  ////delaration of text editing cntroller;
  TextEditingController heroname = TextEditingController();
  TextEditingController herogoal = TextEditingController();
  TextEditingController heroinstegram = TextEditingController();
  static const gold = Color(0xffF4C852);
  bool loadPrs=false;
/////decaration of colors
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
  return Scaffold(
   // backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar:true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(bottom: 20),
        icon: Image.asset('assets/images/back.png',scale: 5,),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
    body:SingleChildScrollView(child: Container(
        child:Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:size.height*.07),
                height: size.height*.24,
                width: size.width*.65,
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image:AssetImage('assets/images/map1.png'),
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(child: Stack(
                    children:[
                     Center(child:  Container(
                       alignment:Alignment.center,
                       margin:EdgeInsets.only(top: size.height*.036),
                       //  width: MediaQuery.of(context).size.width,
                       height: size.height*.54,
                       width:size.width*.83,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           shape:BoxShape.rectangle,
                           borderRadius: BorderRadius.circular(19),
                           boxShadow: [
                             BoxShadow(
                               color:Color(0x40000000),
                               blurRadius:10, // soften the shadow
                               spreadRadius:0.0, //extend the shadow
                               offset: Offset(0.0,3),
                             )
                           ]
                       ),


                       child: Column(
                         // mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Padding(padding:EdgeInsets.only(top:size.height*.04)),
                           //ابدا
                           Text('ابدأ',style:TextStyle( fontSize: size.width*.06,
                               fontFamily: fntAljazeera,
                               fontWeight: FontWeight.bold,
                               color: Color(0x59000000))),
                           ////تحدي جديد
                           Text('تحدي جديد',style:TextStyle(fontSize: size.width*.09,
                               fontWeight: FontWeight.bold,fontFamily: fntAljazeera)),
                           Padding(padding:EdgeInsets.only(top:size.height*.04)),
                           //اسم البطل
                           Container(
                               height: size.height*.06,
                               width: size.width*.70,
                               child:textfield(hinttext: txt1,herogoal:heroname,f:icon1) ),
                           Padding(padding:EdgeInsets.only(top:size.height*.02)),
                           //الهدف
                           Container(
                               height: size.height*.06,
                               width: size.width*.70,
                               child:textfield(hinttext: txt2,herogoal:herogoal,f:icon2) ),
                           Padding(padding:EdgeInsets.only(top:size.height*.02)),
                           //حساب الانستغرام
                           Container(
                               height: size.height*.06,
                               width: size.width*.70,
                               child:textfield(hinttext: txt3,herogoal:heroinstegram,f:icon3) ),

                         ],
                       ),

                     ) ,),
                    Center(
                      child: Container(
                          key: containerkey,
                          margin:  EdgeInsets.only(top:size.height*.54),
                          height:size.height*.07,
                          width:size.width*.40,

                          //alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            image:DecorationImage(
                              image:AssetImage(loadPrs?'assets/images/startc2.png':'assets/images/startc1.png'),
                              fit: BoxFit.fill,),

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
                              onTap: ()async{
                                setState(() {
                                  loadPrs=true;
                                });
                                
                                 Future.delayed(durPress,).then((onValue){
                                  setState(() {
                                    loadPrs=false;
                                    respnmsg='';
                                  });
                                });

                                if(heroname.text.isNotEmpty&&herogoal.text.isNotEmpty&&heroinstegram.text.isNotEmpty){
                                 bool response = await ch.createChallenge(heroname.text, heroinstegram.text, herogoal.text);
                                    if (response) {
                                      Navigator.of(context).pushNamed('/getCha');
                                      print('succses');
                                    }else{

                                      setState(() {
                                        respnmsg=ch.rsponseMsg;
                                      });
                                      print(respnmsg);
                                    }
                                  
                                }else{
                                  setState(() {
                                    respnmsg='الرجاء ملأ كل الحقول';
                                  });
                                  
                                  print (respnmsg);}
                                  
                                  Future.delayed(const Duration (seconds: 1)).then((onValue){
                                  setState(() {

                                    respnmsg='';
                                    });
                                  });
                              }
                              
                                  
                          )

                      ) ,
                    ),
                      (respnmsg).trim()==''?Text('') : alertMsg(context,respnmsg,containerkey, marge: -75),

                    ]
                ),),

                )
            ],
          ),
        )
    ),)
  );


  }
}