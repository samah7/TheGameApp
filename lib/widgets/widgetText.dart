import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textfield extends StatelessWidget{
  TextEditingController herogoal=TextEditingController();
  final  String hinttext;
  final Image  f;
  textfield( {Key key,this.hinttext,this.herogoal,this.f} ) :super(key:key);



  @override

  //textfieldstate createState() =>  textfieldstate(this.hinttext,this.herogoal,this.f);

  Widget build(BuildContext context) {

    return TextField(

      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.bottom,
      controller:herogoal,
      enableInteractiveSelection: false,
      //autofocus: true,

      decoration:InputDecoration(
        prefixIcon:f,
        hintText:hinttext,


        disabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(25.0),
          borderSide:new BorderSide(color:Colors.black,width:2),
          
        ),

        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(25.0),
          borderSide:new BorderSide(color:Colors.black,width:2),
          
        ),

        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(25.0),
          borderSide:new BorderSide(color:Colors.black,width:2),
          
        ),
        // contentPadding: Idg,
        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(25.0),
          borderSide:new BorderSide(color:Colors.black,width:2),
          
        ),
        //  enabled: false,
      ),
    );
  }

}
