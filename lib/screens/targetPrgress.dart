
import 'package:chronometer/Ressources/Ressources.dart';
import 'package:flutter/material.dart';
class home15 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new homestate15();
  }

}
class homestate15 extends  State<home15>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return new  MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height*.15),
          child:Container( 
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.red,
                offset: Offset(0, 2.0),
                blurRadius: 4.0,
              )
            ]),
            child: AppBar(backgroundColor: Colors.white70,
                leading: IconButton(
                  //padding: EdgeInsets.only(top: 20),
                  icon: Image.asset('assets/images/back.png',scale: 5,),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace:Container(
                  margin:EdgeInsets.only(top:size.height*.05,right:size.width*.09)  ,
                  alignment: Alignment.centerRight,
                  child: Text('التقدم بالهدف',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width*.09,
                      fontFamily: fntAljazeera,

                    ),),
                ),
                ////rounded corners
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(35),
                  ),),
                //shadowColor: Colors.black
            ),
          ),),
        body: Center(
          child: Container(
            //margin: EdgeInsets.only(top:size.height*.36),
            child: Text('coming soon',style: TextStyle(fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
            fontSize:size.width*.10,
          ),),),
        ),
      ),

    );

  }


}