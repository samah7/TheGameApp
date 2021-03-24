import 'package:chronometer/Ressources/Ressources.dart';
import 'package:flutter/material.dart';
class began extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return beganstate();

  }
}
class beganstate extends State<began>{
  
  @override
  initState(){
     super.initState();
  }

  bool loadPrs=false;
  static const gold = Color(0xffffEAA0);
  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
        width: MediaQuery.of(context).size.width,
    height:MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    image: DecorationImage(

    image: AssetImage('assets/images/bgd1.png'),
    fit: BoxFit.fill,

    )),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top:size.height*.034),
                    height: size.height*0.139,
                    width: size.width*.248,
                    decoration: BoxDecoration(
                      image:DecorationImage(image: AssetImage('assets/images/logo1.png',),fit: BoxFit.cover,),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:size.height*.029),
                    child: Text('MY MISSION',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width*.096,
                      fontFamily: 'corbel',
                      color:gold,
                      height: 1
                    ),),
                  ),
                ],

              ),

            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(top:size.height*.56, right:0.06*size.width),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Container(
                 // margin:EdgeInsets.only(right:size.width*.06),
                  child:Text('   مرحبا بك في تطبيق تحدي الستين الخاص بلعبة الحياة.هذا التطبيق \n   سيساعدك  على توثيق التحدي الخاص بك \n   تم تطوير هذا التطبيق من قبل أبطال اللعبة  Developers.',textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: fntAljazeera,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width*0.029,
                      color: Colors.black),),),
                new Container(
                  margin: EdgeInsets.only(right: size.width*.65,top: 0),
                    height:size.height*.06,
                    width:size.width*.28,
                    //alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image:AssetImage(loadPrs?'assets/images/start2.png':'assets/images/start1.png'),
                        fit: BoxFit.cover,
                      ),

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
                        onTap: (){
                          setState(() {
                            loadPrs=true;
                            Future.delayed(const Duration (milliseconds:600),()=>"2").then((onValue){
                              Navigator.of(context).pushReplacementNamed('/home');
                              setState(() {
                                loadPrs=false;
                              });
                            });
                          });
                        })

                ),

              ],)
            )
          ],
        ),)
      ),
    );


  }
}