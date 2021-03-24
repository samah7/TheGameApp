import 'package:chronometer/Ressources/Ressources.dart';
import 'package:flutter/material.dart';

alertMsg(BuildContext context, String msgError, GlobalKey key, {marge = 0}){
  var bounds = key.globalPaintBounds;
  var length = bounds.bottom-(bounds.bottom-bounds.top)-marge;
  return  Center( 
            child: Opacity(
              opacity: 0.83,
              child: Transform.translate(
                offset: Offset(0,/*MediaQuery.of(context).size.height-*/length),
                child: Container(
                  height:70,
                  width:MediaQuery.of(context).size.width*0.6,
                  padding: EdgeInsets.symmetric(horizontal:10),
                  decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius:  BorderRadius.all(
                        Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 4,
                        color : Colors.grey[300],
                        blurRadius: 5.0
                      )
                    ]
                    ),
                    child:Center(
                      child: Text(msgError ,textAlign:TextAlign.center, 
                              style:TextStyle(fontFamily: fntAljazeera, fontSize: 12, height: 1.9)),
                    ),
                ),
              ), 
            ),
          );
}


extension GlobalKeyExtension on GlobalKey {
    Rect get globalPaintBounds {
      final renderObject = currentContext?.findRenderObject();
      var translation = renderObject?.getTransformTo(null)?.getTranslation();
      if (translation != null && renderObject.paintBounds != null) {
        return renderObject.paintBounds
            .shift(Offset(translation.x, translation.y));
      } else {
        return null;
      }
    }
  } 