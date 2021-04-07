
import '../Ressources/Ressources.dart';

import '../controller/function.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import '../models/user.dart';
import'../controller/User_controller.dart';

class poitsWidget extends StatefulWidget{
  poitsWidget( {Key key} ) :super(key:key);

  @override
  State<poitsWidget> createState() {
    return listWidgetstate();
  }

}
class listWidgetstate extends State<poitsWidget> {
  var size;
  var g;
  List k=List<User>();
  List kl=List<User>();
  int c=1;
  bool load=false;
  UserController dbo = UserController();
  ScrollController s=ScrollController();



  @override
  initState(){
    super.initState();
    dbo.getTrandingpoint(1).then((v){
      setState(() {
        k=v;
      });
    });
    s.addListener(()async {

      print((s.position.pixels));
      if((s.position.pixels)==(s.position.maxScrollExtent)){
        setState(() {
          load=true;
        });

        c=c+1;
        print(load);
        dbo.getTrandingpoint(c).then((value)
        async{

          setState(() {

            k.addAll(value); print(load);

          });
          load=false;
        });



      }

    //load=false;
    });

  }
  @override
  void dispose(){
    s.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var snum=size.width*.041;
    var sheroname=17.0;//size.height*.024;
    var spoint=size.width*.05;
    return Scaffold(
      body:
      ((k.length)==0)?Center(child:CircularProgressIndicator()) :Container(
        //margin:EdgeInsets.only(top:10,) ,
        child:Column(children: [
          Expanded(
          child:ListView.builder(
              controller: s,
              itemCount: k.length,
              itemBuilder: (BuildContext context, int position) {
                return Container(
                  //height: size.height*.14,
                  // margin: EdgeInsets.only(top:10,),

                  child:Center(
                      child: Column(
                        children: [
                          Container(

                            height: size.height*.12,
                            child: Center(child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Padding(padding: EdgeInsets.only(right:5)),
                                ((  k[position].is_challengVerified)) ? Container(
                                    margin: EdgeInsets.only(left: size.width*.05,),
                                    height: size.height*.03,
                                    width:  size.height*.03,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/images/verified.png',)
                                          ,
                                          //fit:BoxFit.contain,
                                        )

                                    )
                                ):Container(
                                  margin: EdgeInsets.only(left: size.width*.05,),
                                  height: size.height*.03,
                                  width:  size.height*.03,

                                ),



                                ////circle of notes
                                Container(
                                  margin:  EdgeInsets.only(left: 12),
                                  child:  (position==0)?Container() :CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius:size.width*.0628,
                                    child: CircleAvatar(backgroundColor: Colors.white,
                                        radius:size.width*.0603,
                                        child: Text('${k[position].score}',style:TextStyle(
                                          fontSize:(spoint>18)?18:spoint,
                                        ),)),),),
                                ////hero's name
                                //Padding(padding: EdgeInsets.only(left:34,right: 12)),
                                Expanded(child:  Container(
                                  margin: EdgeInsets.only(right: size.width*.031,),
                                  child:Text('${k[position].name}',textDirection:TextDirection.rtl,style:TextStyle(
                                    fontSize: (sheroname>=21)?21:sheroname,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fntAljazeera,
                                  )),),),

                                ////circle of account
                                //Padding(padding: EdgeInsets.only(left:5,),),
                                Container(
                                    margin: EdgeInsets.only(right: size.width*.024,),
                                    child:GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          var url='https://www.instagram.com/${k[position].hero_instagram}/';
                                          launchInBrowser(url);
                                        });
                                      },
                                      child:CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius:size.width*.072,
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius:size.width*.072,

                                            child:((k[position].pictureName)!=null) ?   CircleAvatar(
                                                backgroundColor: Colors.black,
                                                radius:size.width*.072,
                                                child: CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    radius:size.width*.072,
                                                    backgroundImage:AssetImage( k[position].pictureName,)
                                                ) )  :Image.asset('assets/images/account.png',scale: 4,)
                                        ),),) ),
                                // Padding(padding: EdgeInsets.only(left:12,),),
                                Container(margin: EdgeInsets.only(right: size.width*.05),////circle of numbers
                                  child:CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: size.width*.045,
                                      child:CircleAvatar(
                                        radius:size.width*.042,
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white,
                                        child: Text('${position+1}',style: TextStyle(
                                            fontSize:  size.width*.030
                                        ),),

                                      )
                                  ),)
                              ],

                            ) ,),),
                          (position==(k.length-1))? Container(): Divider(thickness: 1,indent: size.width*.055,endIndent: size.width*.055,),
                        ],
                      )),
                );
              }
          )),
          load?
          Container(
          height: 100,
          color: Colors.transparent,
          child: Center(
            child: new CircularProgressIndicator(),
          ),
        )
          :Container(
        height:0,
    ),
      ])


)


    );
  }
}