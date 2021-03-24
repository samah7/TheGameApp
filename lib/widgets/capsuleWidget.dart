
import '../Ressources/Ressources.dart';
import '../controller/function.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import '../models/user.dart';
import'../controller/user_controller.dart';

class capsuleWidget extends StatefulWidget{
  capsuleWidget( {Key key} ) :super(key:key);

  @override
  State<StatefulWidget> createState() {
    return capsuleWidgetstate();
  }

}
class capsuleWidgetstate extends State<capsuleWidget> {
  var size;
  List<User> capsulelist;
  //listWidgetstate( {Key key} ) :super(key:key);
  UserController dbc=UserController();
  void initState() {
    super.initState();
    dbc.getTrandingcapsules().then((value) {
      setState(() {
        capsulelist=value;


      });
    });

    //isInLeaderBoard = List<bool>.generate(items.length, (int i) => false);
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var snum=size.width*.041;
    var sheroname=17.0;//size.height*.0222;
    var spoint=size.width*.05;
    return Scaffold(
      body:(capsulelist==null)?Center(child:   Theme(data: Theme.of(context).copyWith(accentColor: Colors.black38),
      child:CircularProgressIndicator() ,)) :Container(
        //margin:EdgeInsets.only(top:10,) ,
          child:ListView.builder(
              itemCount:( capsulelist.length),
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
                                capsulelist[position].is_challengVerified ? Container(
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
                                  child: (position==0)?Container() : CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius:size.width*.0628,
                                    child:CircleAvatar(backgroundColor: Colors.white,
                                        radius:size.width*.0603,
                                        child: Text('${capsulelist[position].capsules}',style:TextStyle(
                                          fontSize:(spoint>20)?20:spoint,
                                        ),)),),),
                                ////hero's name
                                //Padding(padding: EdgeInsets.only(left:34,right: 12)),
                                Expanded(child:  Container(
                                  margin: EdgeInsets.only(right: size.width*.031,),
                                  child:Text('${capsulelist[position].name}',textDirection:TextDirection.rtl,style:TextStyle(
                                    fontSize:(sheroname>21)?21:sheroname,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fntAljazeera,
                                  )),),),

                                ////circle of account
                                //Padding(padding: EdgeInsets.only(left:5,),),
                                Container(
                                  margin: EdgeInsets.only(right: size.width*.024,),
                                  child:GestureDetector(
                                    child:  CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius:size.width*.072,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius:size.width*.072,

                                          backgroundImage:AssetImage((capsulelist[position].pictureName==null)?'assets/images/account.png': capsulelist[position].pictureName,)
                                      ),),

                                    onTap: (){
                                      setState(() {


                                          var url='https://www.instagram.com/${capsulelist[position].hero_instagram}/';
                                          launchInBrowser(url);


                                      });


                                    },
                                  )),
                                // Padding(padding: EdgeInsets.only(left:12,),),
                                Container(margin: EdgeInsets.only(right: size.width*.05),////circle of numbers
                                  child:CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: size.width*.031,
                                      child:CircleAvatar(
                                        radius:size.width*.03,
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white,
                                        child: Text('${position+1}',style: TextStyle(
                                            fontSize:(snum>17)?17:snum
                                        ),),

                                      )
                                  ),)
                              ],

                            ) ,),),
                          (position==(capsulelist.length-1))? Container(): Divider(thickness: 1,indent: size.width*.055,endIndent: size.width*.055,),
                        ],
                      )),
                );
              })

      ),
    );

  }
}