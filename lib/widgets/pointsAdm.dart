
import 'package:chronometer/Ressources/Ressources.dart';

import '../controller/function.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import '../models/User.dart';
import'../controller/user_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_switch/flutter_switch.dart';

class listPointsAdm extends StatefulWidget{
  listPointsAdm( {Key key} ) :super(key:key);

  @override
  State<StatefulWidget> createState() {
    return listAdmintstate();
  }

}
class listAdmintstate extends State<listPointsAdm> {
  var size;
  bool status=true;
  List k;
  List userDetails=[];
  List searchResult=[];
  //listWidgetstate( {Key key} ) :super(key:key);
  UserController db=UserController();
  void initState() {
    super.initState();
     db.getTrandingpoint().then((value) {
      setState(() {
        k=value;
        userDetails=value;

      });
    });
  
    //isInLeaderBoard = List<bool>.generate(items.length, (int i) => false);
  }
  ///////////////////////////////////////
  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    userDetails.forEach((userDetail) {
      if (userDetail.name.contains(text) )
        searchResult.add(userDetail);
    });

    setState(() {});
  }





  //////////////////////////////////////////
  TextEditingController search=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var snum=size.width*.041;
    var sheroname=17.0;//size.height*.0222;
    var spoint=size.width*.05;
    return Scaffold(
      body:Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(children: [
        Container(child: Container(
          height:size.height*.07 ,
            width: size.width*.83,
            child:TextField(

          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          textAlignVertical: TextAlignVertical.bottom,
          controller:search,
          enableInteractiveSelection: false,
          //autofocus: true,
            onChanged:  onSearchTextChanged,
          decoration:InputDecoration(
            prefixIcon:Image.asset('assets/images/search1.png',scale: 3,),
            hintText:'بحث',

            hintStyle: TextStyle(color: Colors.grey,fontFamily: fntAljazeera),
            filled: true,
            fillColor: Colors.white70,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(color: Color(0xffF4C852), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(
                color: Color(0xffF4C852),
              ),
            ),
          ),


        )),),
         Expanded(child: ((searchResult.length != 0) ||( search.text.isNotEmpty))?
         Container(
           margin:EdgeInsets.only(top: 20),
           child:  (searchResult==null)?Center(child:CircularProgressIndicator()) :Container(
             //margin:EdgeInsets.only(top:10,) ,
               child:ListView.builder(
                   itemCount:( searchResult.length),
                   itemBuilder: (BuildContext context, int position) {
                     return
                       Slidable(
                         actionPane: SlidableDrawerActionPane(),

                           secondaryActions: [
                     IconSlideAction(
                     color:Colors.redAccent,
                     icon:Icons.delete ,
                     foregroundColor:Colors.black,
                     onTap: ()async{

                      var s=await  db.delete(searchResult[position].user_id);
                      if (s==true) { setState(() {
                      searchResult.removeAt(position);
                      });}
                     },
                     )

                     ],
                       child:Container(
                       //height: size.height*.14,
                       // margin: EdgeInsets.only(top:10,),

                       child:Center(
                           child: Column(
                             children: [
                               ////////////////////verification
                               Container(

                                 height: size.height*.12,
                                 child: Center(child:Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     //Padding(padding: EdgeInsets.only(right:5)),
                                     searchResult[position].is_challengVerified ? Container(
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
                                             child: Text('${searchResult[position].score}',style:TextStyle(
                                               fontSize:(spoint>20)?20:spoint,
                                             ),)),),),
                                     ////User's name
                                    ////////////////////////////////
                                     Expanded(child:  Container(
                                       margin: EdgeInsets.only(right: size.width*.031,),
                                       child:Text('${searchResult[position].name}',textDirection:TextDirection.rtl,style:TextStyle(
                                         fontSize:(sheroname>21)?21:sheroname,
                                         fontWeight: FontWeight.bold,
                                         fontFamily: fntAljazeera,
                                       )),),),
///////////////////////////////////////////////////////////////////////////////
                                     ////circle of account

                                     Container(
                                         margin: EdgeInsets.only(right: size.width*.024,),
                                         child:GestureDetector(
                                           onTap: (){
                                             setState(() {
                                               var url='https://www.instagram.com/${searchResult[position].hero_instagram}/';
                                               launchInBrowser(url);
                                             });
                                           },
                                           child:CircleAvatar(
                                             backgroundColor: Colors.black,
                                             radius:size.width*.072,
                                             child: CircleAvatar(
                                                 backgroundColor: Colors.white,
                                                 radius:size.width*.072,

                                                 child:(searchResult[position].pictureName!=null) ?   CircleAvatar(
                                                     backgroundColor: Colors.black,
                                                     radius:size.width*.072,
                                                     child: CircleAvatar(
                                                         backgroundColor: Colors.transparent,
                                                         radius:size.width*.072,
                                                         backgroundImage:AssetImage( searchResult[position].pictureName,)
                                                     ) )  :Image.asset('assets/images/account.png',scale: 4,)
                                             ),),) ),
                                     //////////////////////////////////////////////////


                                     //////////////////////position
                                     Container(margin: EdgeInsets.only(right: size.width*.05),////circle of numbers
                                       child:Center(child:Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                           
                                             margin: EdgeInsets.only(top :searchResult[position].user_id==1?13:10),
                                             child:CircleAvatar(
                                                 backgroundColor: Colors.black,
                                                 radius: size.width*.031,
                                                 child:CircleAvatar(
                                                   radius:size.width*.03,
                                                   foregroundColor: Colors.black,
                                                   backgroundColor: Colors.white,
                                                   child: Text('${position+1}',style: TextStyle(
                                                     fontSize: (snum>17)?17:snum,
                                                   ),),

                                                 )
                                             ),),
                                           Container(
                                             width:28.0,
                                             height:searchResult[position].user_id==1?0:15.0,
                                             margin: EdgeInsets.only(top:10),
                                             child: searchResult[position].user_id==1?null:FlutterSwitch(
                                                  activeColor: Colors.black,
                                                  inactiveColor: Colors.green,
                                                  valueFontSize: 25.0,
                                                  toggleSize: 15.0,
                                                  value: searchResult[position].is_challengVerified,
                                                  borderRadius:15,
                                                  padding: 3,
                                                  showOnOff: false,
                                                  onToggle: (val)async {
                                                
                                                      var v=  searchResult[position].is_challengVerified;
                                                      var f= val.toString();
                                                      bool status =await db.challengVerified(searchResult[position].user_id, val.toString());
                                                    setState(() { 
                                                      if (status)
                                                        searchResult[position].is_challengVerified=val;
                                                    });
                                                  },
                                           ),),


                                         ],))),
                                   ],

                                 ) ,),),
                               (position==(searchResult.length-1))? Container(): Divider(thickness: 1,indent: size.width*.055,endIndent: size.width*.055,),
                             ],
                           )),
                     ));
                   })

           ),)
        : Container(
        margin:EdgeInsets.only(top: 20),
        child:  (k==null)?Center(child:CircularProgressIndicator()) :Container(
          //margin:EdgeInsets.only(top:10,) ,
            child:ListView.builder(
                itemCount:( k.length),
                itemBuilder: (BuildContext context, int position) {
                  return Slidable(
                      actionPane: SlidableDrawerActionPane(),

                  secondaryActions: [
                  IconSlideAction(
                  color:Colors.redAccent,
                  icon:Icons.delete ,
                  foregroundColor:Colors.black,
                  onTap: ()async{
                  var s= await db.delete(k[position].user_id);
                   if(s==true){
                     setState(() {

                       k.removeAt(position);

                     });
                   }


                  },
                  )

                  ],



                    child:Container(
                    //height: size.height*.14,
                    // margin: EdgeInsets.only(top:10,),

                    child:Center(
                        child: Column(
                          children: [
                            /////verification
                            Container(

                              height: size.height*.12,
                              child: Center(child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  //Padding(padding: EdgeInsets.only(right:5)),
                                  k[position].is_challengVerified ? Container(
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
                                            fontSize:(spoint>20)?20:spoint,
                                          ),)),),),
                                  ////hero's name
                                  ///////////////////////////////////
                                  Expanded(child:  Container(
                                    margin: EdgeInsets.only(right: size.width*.031,),
                                    child:Text('${k[position].name}',textDirection:TextDirection.rtl,style:TextStyle(
                                      fontSize:(sheroname>21)?21:sheroname,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fntAljazeera,
                                    )),),),
///////////////////////////////////////////////////////////
                                  ////circle of account

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

                                              child:(k[position].pictureName!=null) ?   CircleAvatar(
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
                                    child:Column(children: [
                                      Container(
                                        //margin: EdgeInsets.only(top:12),
                                        
                                        margin: EdgeInsets.only(top :k[position].user_id==1?23:12),
                                        child:CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: size.width*.031,
                                          child:CircleAvatar(
                                            radius:size.width*.03,
                                            foregroundColor: Colors.black,
                                            backgroundColor: Colors.white,
                                            child: Text('${position+1}',style: TextStyle(
                                              fontSize: (snum>17)?17:snum,
                                            ),),

                                          )
                                      ),),
                                      Container(
                                        width:38.0,
                                        height:k[position].user_id==1? 0: 18.0,
                                        margin: EdgeInsets.only(top:10),
                                        child:k[position].user_id==1?null: FlutterSwitch(
                                            activeColor:Colors.green,
                                            inactiveColor:Colors.black,
                                            valueFontSize: 25.0,
                                            toggleSize: 15.0,
                                            value: k[position].is_challengVerified,
                                            borderRadius: 15.0,
                                            padding: 3.0,
                                            showOnOff: false,
                                            onToggle: (val)async {
                                              
                                                var v=  k[position].is_challengVerified;
                                                var f= val.toString();
                                                bool status =await db.challengVerified(k[position].user_id, val.toString());
                                              setState(() { 
                                                if (status)
                                                  k[position].is_challengVerified=val;
                                              });
                                            },
                                          ),),

                                    ],))
                                ],

                              ) ,),),
                            (position==(k.length-1))? Container(): Divider(thickness: 1,indent: size.width*.055,endIndent: size.width*.055,),
                          ],
                        )),
                    ) );
                })

        ),)
         )



      ],),)

    );

  }
}


    _verifiedWidget(u, context) {
      
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
      if(u.is_verefied == "true"){
        return
          Container(
            width: w * 0.055,
            height: h * 0.03,

            child:    Image.asset(
              'assets/images/verified.png',
              // width: 30,
              // height: 30,
            ),
          );

      }

      else{
        return Container(
          child: Text('',
            style: TextStyle(fontSize: 0.0),),
        );

      }
    }