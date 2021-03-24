
import '../controller/function.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';

import '../Ressources/Ressources.dart';


class TimerScreenHelp extends StatelessWidget{   
  var vIcon = 'assets/images/auto1.png';
 
  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    double hCircle =  MediaQuery.of(context).size.width*0.7;
    double fntChrono = W *0.097;
    double arAuto =MediaQuery.of(context).size.height*0.01;

    return Scaffold(
        body:  Stack(
          children: <Widget>[            
            Container(padding: EdgeInsets.only(top:95),
                  height:MediaQuery.of(context).size.height, 
                  width:MediaQuery.of(context).size.width,//320,
                  ////container contnent
                  child:SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                            //  margin: EdgeInsets.only(top:20),
                              height: 30,
                              child: Stack(
                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(left : 8.0),
                                    child: IconButton(icon:Image.asset('assets/images/back.png',scale: 5,), onPressed: ()=>Navigator.of(context).pop(),)
                                  ),
                                   Container(                                       
                                       child: Center(
                                         child: Text( 'الكبسولة هي وحدة زمنية مدتها 25 دقيقة', 
                                            style:TextStyle(fontSize: 12, fontFamily: fntAljazeera, 
                                                 //  height: 0.5,
                                                 ),
                                            textAlign: TextAlign.center,
                                          ),
                                       ),
                                     
                                   )
                                ],
                              ),
                            ),
                            
                            Center(
                              child: Column(
                                children: <Widget>[    
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    margin: EdgeInsets.only(top:0),
                                    width:hCircle,
                                    height:hCircle,
                                    child: Stack(
                                      children: <Widget>[
                                        Image.asset('assets/images/circle.png'),
                                         Align(alignment: Alignment.center, child: Text( '00:25', style:TextStyle(fontSize: fntChrono, fontFamily: fntAljazeera, fontWeight: FontWeight.bold),)),
                                         Padding(padding:EdgeInsets.only(bottom:35), child: Align(alignment: Alignment.bottomCenter, child: Image.asset('assets/images/field.png'))),
                                         Padding(padding:EdgeInsets.only(bottom:67), child: Align(alignment: Alignment.bottomCenter, child: Text('مجموع الكبسولات', style:TextStyle(fontSize: 12, fontFamily: fntAljazeera,)))),
                                         Padding(padding:EdgeInsets.only(bottom:31), child: Align(alignment: Alignment.bottomCenter, child: Text('02', style:TextStyle(fontSize: 14, fontFamily: fntAljazeera,)))),
                                      ],
                                    )
                                    ),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top:10)),
                            Column(
                              children: <Widget>[
                                Padding(padding:EdgeInsetsDirectional.only(bottom:6, top:8), 
                                  child: Align(alignment: Alignment.center, 
                                          child: Text('لتشغيل كبسولتين أو أكثر بشكل أوتوماتيكي \nاختر العدد المناسب لك من هنا', 
                                          style:TextStyle(fontSize: 10, fontFamily: fntAljazeera,),
                                          textAlign: TextAlign.center,
                                          )
                                        )
                                ),
                                Row(
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 
                                 children: <Widget>[
                                  Container(
                                    width: 90,height: 90,
                                    child: Image.asset('assets/images/btnStop.png',)
                                  ), 
                                     
                                  
                                   Expanded(
                                     child: Container(
                                      width:140,
                                      height: 140,
                                      margin: EdgeInsets.only(left:5,),
                                      padding: EdgeInsets.all(0),
                                      child: Center(child: Container(
                                              padding: EdgeInsets.all(0),
                                              margin: EdgeInsets.only(left:3),
                                              child:Image.asset(vIcon, fit: BoxFit.cover,),             
                                            ),),
                                     ),
                                   ),

                                   Container(
                                       padding: EdgeInsets.all(0),
                                       margin: EdgeInsets.all(0),
                                       width: 90,height: 90,
                                       child: 
                                            Center(child:AnimatedOpacity( opacity: 1, duration: Duration(seconds: 2), child:Image.asset('assets/images/btnRun.png', fit: BoxFit.cover,))), 
                                   ),
                                 ],
                             ),
                            ],
                            ),
                                Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 
                                 children: <Widget>[
                                  Container(
                                    width: 80,
                                    child:Text('أوقف الجلسة', 
                                        style:TextStyle(fontSize: 10, fontFamily: fntAljazeera,),
                                        textAlign: TextAlign.center,
                                      ),
                                  ), 
                                     
                                  
                                   Expanded(
                                     child: Container(
                                      // width:180,
                                        margin: EdgeInsets.all(0),
                                        padding: EdgeInsets.all(0),
                                        child: Center(child: Container(
                                                padding: EdgeInsets.all(0),
                                                margin: EdgeInsets.only(left:3),
                                                child:Text('عند انتهاء يومك تأكد من ضغط هذ الزر\n ليتم احتساب كبسولاتك لمنافسة الآخرين', 
                                                        style:TextStyle(fontSize: 10, fontFamily: fntAljazeera,),
                                                        textAlign: TextAlign.center,
                                                      ),             
                                            ),),
                                     ),
                                   ),

                                   Container(
                                       padding: EdgeInsets.all(0),
                                       margin: EdgeInsets.all(0),
                                       width: 80,
                                       child: Text('ابدأ من هنا', 
                                        style:TextStyle(fontSize: 10, fontFamily: fntAljazeera,),
                                        textAlign: TextAlign.center,
                                      ),
                                    
                                   ),
                                 ],
                             ),
                            Center(
                              child:Container(
                                 height: 100,
                                child: Column(
                                  children: <Widget>[
                                    Container( width: 70,height: 70,
                                    decoration:BoxDecoration(image:
                                    DecorationImage( image:AssetImage('assets/images/load.png'), fit: BoxFit.contain)),                                
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:0),
                                      child: Container(height: 20,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(width: 50,
                                              child: FlatButton(
                                                padding: const EdgeInsets.all(0),
                                                child: Text('اضغط هنا', 
                                                  style:TextStyle(fontSize: 10, fontFamily: fntAljazeera, color: Color(color_blue)),
                                                  textAlign: TextAlign.right,
                                                ), onPressed: ()=> launchInBrowser("https://www.youtube.com/watch?v=N0FAsZvVOAo&t=1s"),
                                              ),
                                            ),
                                            Text('لمزيد من الشرح  ', 
                                              style:TextStyle(fontSize: 10, fontFamily: fntAljazeera,),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                        //               ],
                        ),
                      ],
                    ),
                  )
                ),
                Container(
                    height:82,
                    width:MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left:8, right: 8, top:28),
                    decoration:BoxDecoration(
                      color:Colors.grey[100],
                      borderRadius:  BorderRadius.only(
                         bottomLeft: Radius.circular(24),
                         bottomRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 4,
                          color : Colors.grey[300],
                         // offset: Offset(0.0, 30.0), //(x,y)
                          blurRadius: 5.0
                        )
                      ]
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                       Container(
                         width: 70,
                         child: Text('الترتيب\n55',textAlign:TextAlign.center, 
                              style:TextStyle(fontFamily: fntAljazeera, fontSize: 17, height: 1.3)),
                       ),
                       Text("${DateTime.now().hour.toString().padLeft(2,'0')}:${DateTime.now().minute.toString().padLeft(2,'0')}", textAlign:TextAlign.center,
                             style:TextStyle(fontFamily: fntAljazeera, fontSize: 20, height: 1.3)),
                       Container(
                         width: 70,
                         child: Text('الرصيد\n43',textAlign:TextAlign.center, 
                              style:TextStyle(fontFamily: fntAljazeera, fontSize: 17, height: 1.3)),
                       ),
                     ],),
                   ),
                  
          ],
        ),        
    );
  }
  }

  