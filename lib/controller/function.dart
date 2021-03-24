import '../controller/user_controller.dart';
import '../screens/login_register.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

louseFocus(BuildContext context){
  FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();}
}
    //        onSelectNotification: onSelectNotification);
  


fctExit(BuildContext context)async {
    var db = UserController();
    await db.logout();
   // Navigator.of(context).pushReplacementNamed('/login');
  
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>LoginRegisterScreen(login:true,)));

   /* Future.delayed(const Duration(milliseconds: 1000), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });*/
}

int sumpoint(bool s1,bool s2,bool s3,bool s4,bool s5,bool s6){
  var spoint=getboolpoint(s1)*2;
  var mpoint=getboolpoint(s2)*2;
  var lpoint=getboolpoint(s3)*2;
  var sppoint=getboolpoint(s4);
  var tpoint=getboolpoint(s5)*2;
  var rpoint=getboolpoint(s6);
  return spoint+mpoint+lpoint+sppoint+tpoint+rpoint;

}
int getboolpoint(bool p) {
  if(p==false){
    return 1;}
  else{ return 0;}
}

/////////////////////////
Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}


