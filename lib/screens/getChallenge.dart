import 'package:chronometer/Ressources/Ressources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import'package:flutter_slidable/flutter_slidable.dart';
import '../controller/user_controller.dart';
class GetCha extends StatefulWidget{
  GetCha({Key key}):super(key:key);
  @override
  State<StatefulWidget> createState() {

    return new _GetChastate();

  }

}
class _GetChastate extends State<GetCha>{
  @override
  UserController c = new UserController();


  @override
  Widget build(BuildContext context) {
     var size=MediaQuery.of(context).size;
    return MaterialApp(
        home:Scaffold(
            appBar:  PreferredSize(
              preferredSize: Size.fromHeight(size.height*.15),
              child:AppBar(backgroundColor: Colors.white70,
                        leading: IconButton(
                          padding: EdgeInsets.only(top: 20),
                          icon: Image.asset('assets/images/back.png',scale: 5,),
                          onPressed: () => Navigator.of(context).popAndPushNamed('/calendar'),
                        ),
                        flexibleSpace:Container(
                          margin:EdgeInsets.only(top:size.height*.05,right:size.width*.09)  ,
                          alignment: Alignment.centerRight,
                          child: Text('هدف التحدي',
                            textAlign: TextAlign.center,
                           textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: size.width*.09,
                                fontFamily: fntAljazeera
                            ),),
                        ),
                        ////rounded corners
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(35),
                          ),),
                          
                      //  shadowColor: Colors.black
                    ),                  
                ),
            body: Container(

              color: Colors.white,
              child:myDatawidget( c ,size),
            )
        )
    );

  }

}
Widget myDatawidget(UserController c,var size ){
  var future =  c.getChallenge();
  return  new FutureBuilder(
      future:future,
      builder: (BuildContext context,AsyncSnapshot<String>Snapshot){

        if(Snapshot.hasData){
          String target=Snapshot.data;
          return Container(


            margin:  EdgeInsets.only(top: size.height*.12, ),


            //padding: EdgeInsets.only(top: 50,bottom: 15),

            child: Column(children: [
              Container(child:
               Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Padding(padding: EdgeInsets.only(right:size.width*.04,),),
                Expanded(child: Container(
                  margin:EdgeInsets.only(right:size.width*.07),
                    child:Text('$target', textDirection:TextDirection.rtl,style: TextStyle(
                      fontSize: size.width*.08,
                      fontFamily: fntAljazeera,
                      fontWeight: FontWeight.w500,

                    ),) ),),
                 Container(
                 margin: EdgeInsets.only(right: size.width*.04),
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x59000000),
                        blurRadius:20, // soften the shadow
                        spreadRadius:0.0, //extend the shadow
                        offset: Offset(0.0,3),
                      )
                    ],),
                  //color: Colors.white,),

                  child: CircleAvatar(
                    radius: size.width*.06,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    child: Text('1',style: TextStyle(
                        fontSize: size.width*.07,
                    ),),

                  ),),



              ],
            ),),
            // Padding(padding: EdgeInsets.only(top: 10)),
              Container(
              height: 9,
               decoration: new BoxDecoration(
                 boxShadow: [
                   BoxShadow(
                     color:Color(0x0d000000),
                     blurRadius:3, // soften the shadow
                     spreadRadius:0.0, //extend the shadow
                     offset: Offset(0.0,4),
                   )
                 ],
                 // color: Colors.white,
               ),

               child: Divider(thickness:1,color: Colors.transparent),
             ),
            ],),

          );
        }
        else{return Center(child:Theme(
                                  data: Theme.of(context).copyWith(accentColor: cHint),
                                  child: CircularProgressIndicator()));
            }
      });
}
