import 'package:chronometer/Ressources/Ressources.dart';
import 'package:flutter/material.dart';
tabBtn(String tab, context, isSelected){
  double fntSize = 17;//MediaQuery.of(context).size.width *0.06;
  if(fntSize>25)
  fntSize =25;
  return !isSelected ?
         Container(margin: EdgeInsets.only(top:7, bottom:4),
          decoration:BoxDecoration(color:Color(0xffEBEBEB),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow:
            [
              BoxShadow(
                color: Colors.white,
                spreadRadius:0.5,
                blurRadius: 3,
                offset: Offset(-1, -2), // changes position of shadow
              ),
            ]),
          child: Container(padding: EdgeInsets.only(right:3,top:2 ),
                  child: Align(
                        alignment: Alignment.center,
                        child: Text(tab, style: TextStyle(fontFamily:fntAljazeera, fontSize:fntSize, color: Colors.black45),)),
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.4,
                        
                  decoration: BoxDecoration(color:Color(0xffEBEBEB),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.75),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                )
            ) :
            Container(padding: EdgeInsets.only(right:3, ),
            margin: EdgeInsets.only(top:isSelected? 7:0 ),
                  child: Align(
                        alignment: Alignment.center,
                        child: Text(tab,style: TextStyle(fontFamily:fntAljazeera, fontSize: fntSize, color: Colors.black))
                      ),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.9,
                        
                  decoration:  BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/pressed.png',
                    ),
                    fit:BoxFit.contain,
                  ),
                )
              ,
                
            );
}