import 'package:flutter/material.dart';
import 'package:mymission/Ressources/Ressources.dart';

alertMsg(BuildContext context, String msgError, {marge = 0}) {
  return Center(
    child: Opacity(
      opacity: 0.83,
      child: Transform.translate(
        offset: Offset(0, (MediaQuery.of(context).size.height / 2) + 60),
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width * 0.6,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 4, color: Colors.grey[300], blurRadius: 5.0)
              ]),
          child: Center(
            child: Text(msgError,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: fntAljazeera, fontSize: 12, height: 1.9)),
          ),
        ),
      ),
    ),
  );
}
