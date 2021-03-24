import 'package:chronometer/screens/ownerScreenPage.dart';

import '../screens/began.dart';
import '../screens/home.dart';
import '../screens/thehomepage.dart';

import '../controller/function.dart';
import 'checkpage.dart';
import '../widgets/alert.dart';

import '../controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Ressources/Ressources.dart';

class LoginRegisterScreen extends StatefulWidget {
  final login;
  final first;
  const LoginRegisterScreen({Key key, this.login=false, this.first=false}) : super(key: key);
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}


class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  String msgError = '';
  String msgShow = '';

  UserController db = UserController();
  TextEditingController _email;
  TextEditingController _pwd;
  TextEditingController _cPwd;
  var containerKey = GlobalKey();
  
  double vide, H, W, txtVide;

  @override
  initState(){
    
   _email = TextEditingController(text:'');
   _pwd   = TextEditingController(text:'');
   _cPwd  = TextEditingController(text:'');
   super.initState();
 
  }
  

  bool btnPressed = false;
  Widget decoratedTextField(String hint, double fontSize, TextEditingController controller, BuildContext context,  
                            {bool obscure=false, TextAlign align=TextAlign.center,TextInputType type=null, int length=null, List <TextInputFormatter> list=null } ){
     double radius = length!=1 ? 80 : 9;
     
    final node = FocusScope.of(context);
     return  Container(       
     /* decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: cGreyL,
            blurRadius:7,
            offset: const Offset(3, 5),
          ),
        ],
      ),*/
       margin: EdgeInsets.only(top:txtVide, ),
      // margin: EdgeInsets.symmetric(horizontal: 10),
       height: H,
       width: W,
       child: TextField(    
                    controller : controller,  
                    inputFormatters: list,
                    obscureText: obscure,
                    textAlign: align,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(fontSize:fontSize, color: cText, fontFamily: fntAljazeera),
                    keyboardType: type == null ? TextInputType.text : type,                   
                    maxLength: length == null ? null : length,                    
                      
                    decoration: InputDecoration(
                      contentPadding: length!=1 ? EdgeInsets.symmetric(vertical:1.0, ):EdgeInsets.only(top:0, left: 2),
                      filled: true,
                      fillColor: cField,
                      hintText: hint,
                      counterText: '',
                      hintStyle: TextStyle(fontSize:15, color:cHint, fontFamily: fntAljazeera),
                      disabledBorder: OutlineInputBorder(                      
                        borderRadius: BorderRadius.circular(radius),
                        borderSide: BorderSide(color:cBorder,width: 2
                      ),),
                    
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:cBorder,width: 2),
                        borderRadius:BorderRadius.circular(radius),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:cBorder,width: 2),
                        borderRadius:BorderRadius.circular(radius),
                      )
                    ),                 
                   onChanged: (value){          
                    if(length == 1) 
                     node.nextFocus();
                    }
                  ),
     );
   }

  loginRegister(BuildContext context)async{    
    louseFocus(context);

    setState(() {
      btnPressed = true;
    });

   await Future.delayed(durPress, );
      
       msgShow = '';
       msgError = '';
      setState(() {
          btnPressed = false;           
        });

       if(widget.login)
       try {         
            if(_pwd.text.trim()==''||_email.text.trim()=='') 
            setState(() {
              msgError = err_fillData;
            });
            else 
            {
              setState(() {msgError = ''; });

              var response = await db.loginData(_email.text, _pwd.text,true,);//lalla@seba_123.com
              print('response register: ${response}');
              if(response) 
              {
                 if(widget.first)
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>began()));
                 else if(UserController.user.role=='owner')
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>OwnerScreen()));
                 else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>TheHomePage()));
              }  
                
                //Navigator.of(context).pushNamed('/homeUser');
              else setState(() {
                msgError = db.rsponseMsg.replaceAll('{','').replaceAll('[','');
                msgError = msgError.replaceAll('}','').replaceAll(']','');
              });
            
              if(msgError == err_codeMissed )
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>CheckPage(email:_email.text)));  
                
             //   _showNotificationWithSound() ;              
          }
        }
      catch(e){
        msgError = err_errVerify;
      }
      
      else
      try {
            if(_pwd.text!=_cPwd.text || _pwd.text.length<8) 
            setState(() {
              if (_pwd.text!= _cPwd.text) msgError = err_cPwdNotEqualPwd;
              if (_pwd.text.length<8) msgError = err_pwdLength;
            });
            else 
            {
              setState(() {
                    msgError = '';
              });
              var response = await db.registerData(_email.text, _pwd.text, _cPwd.text);//lalla@seba_123.com
              print('response register: ${response}');
              if(response) Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckPage(email:_email.text)));
              else 
              {
                  if(msgError.trim() !='')
                  {
                    setState(() {
                        msgShow = msgError;
                        });
                    await Future.delayed(Duration(seconds: 8)).then((_) {
                          setState(() {
                            msgShow = '';
                          });
                        });
                  }
                setState(() {
                  if (db.rsponseMsg!=null)
                  {
                      msgError = db.rsponseMsg.replaceAll('{','').replaceAll('[','');
                      msgError = msgError.replaceAll('}','').replaceAll(']',''); 
                  }
                });               
              
                if(msgError.toLowerCase() == err_emailTaken.toLowerCase() )
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>LoginRegisterScreen(login:true)));  

               else  if(msgError.toLowerCase() == err_codeMissed.toLowerCase() || 
                      msgError.toLowerCase().contains('social id') ||
                      msgError.toString().toLowerCase().contains('email') )
                       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>CheckPage(email:_email.text)));  
              }
            }
      }
      catch(e){
        msgError = err_errVerify;
      }

    if(msgError.trim() !='')
    {
      setState(() {
           msgShow = msgError;
          });
      await Future.delayed(Duration(seconds: 3)).then((_) {
            setState(() {
              msgShow = '';
            });
          });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    txtVide = MediaQuery.of(context).size.height*0.033;
    var brBtn = MediaQuery.of(context).size.height*( widget.login? 0.035 : 0.03); 
    var afBtn = MediaQuery.of(context).size.height*( widget.login? 0.04 : 0.02);

    vide = MediaQuery.of(context).size.height*0.11; 
    H = MediaQuery.of(context).size.height*0.065; 
    W = MediaQuery.of(context).size.width*0.73; 
    var logoSize = MediaQuery.of(context).size.height*0.26;

    var btnH = MediaQuery.of(context).size.height*0.067; 
    var btnW = MediaQuery.of(context).size.width*0.3; 
    
    var hTitle = MediaQuery.of(context).size.height*0.027; 
    var brTitle  = MediaQuery.of(context).size.height*0.059;
    //var afTitle  = MediaQuery.of(context).size.height*0.039;

    var fntSize  =  MediaQuery.of(context).size.height*0.05;
   //var fntSize  =  MediaQuery.of(context).size.width*0.0298;
   
 //   var fntSizeFoot  =  MediaQuery.of(context).size.width*0.048;
    var fntSizeFoot  =  MediaQuery.of(context).size.height*0.027;
    
    var brAcc  = MediaQuery.of(context).size.height*0.047;
    var hAcc   = MediaQuery.of(context).size.height*0.02;
    var hFoot  = MediaQuery.of(context).size.height*0.06; 
    
    var afFoot = MediaQuery.of(context).size.height*0.06; 
    var brFoot = MediaQuery.of(context).size.height*( widget.login? 0.06 : 0);


    return Scaffold(
      backgroundColor: cWhite,
      body: Stack(
        children: <Widget>[ 
          SingleChildScrollView(
            child: Center(
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                   // crossAxisAlignment: CrossAxisAlignment.center,
                    children:<Widget>[
                        widget.login ? Text(''):
                        Transform.translate(
                          offset: Offset(-MediaQuery.of(context).size.width/2+20,15),
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            //padding: const EdgeInsets.only(top:25),
                            child: IconButton(icon:Icon(Icons.keyboard_backspace), onPressed: ()=>Navigator.of(context).pop(),)
                          ), 
                        ),
                        Container(
                            margin: EdgeInsetsDirectional.only(top:vide, bottom:brTitle),
                            width: logoSize, // MediaQuery.of(context).size.width*0.45,
                            height: logoSize, //MediaQuery.of(context).size.width*0.45,
                            child: Image.asset('assets/images/logoblack.png', fit: BoxFit.contain,)),
                            
                             Container(
                               child: Opacity(
                                 opacity:0.78,
                                 child: Text( widget.login?str_login:str_register, 
                                     style:TextStyle(
                                       fontSize: 22, 
                                       fontFamily: fntAljazeera, 
                                       fontWeight: FontWeight.bold,
                                       height: 1,
                                       ),
                                  ), 
                               ),
                             ), 
                              //SizedBox(height:afTitle ,),
                            
                            decoratedTextField(str_email,15, _email, context,type: TextInputType.emailAddress),
                            decoratedTextField(str_password,15, _pwd, context, obscure: true),
                            !widget.login?
                            decoratedTextField(str_cPassword,15, _cPwd, context, obscure:true):
                             Text('', style: TextStyle(fontSize:0, ),),
                            Container(
                              key : containerKey,
                              height: btnH,
                              width: btnW,
                              margin:  EdgeInsets.only( top: brBtn, bottom: afBtn),
                              padding:  EdgeInsets.all( 0),
                              decoration: BoxDecoration(             
                                image:DecorationImage(image:  AssetImage(!btnPressed?'assets/images/btnNext.png':'assets/images/btnNextPressed.png'), fit: BoxFit.contain),
                              ),
                              child: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTapCancel:  (){setState(() {
                                             btnPressed=false;
                                          });},
                                          
                                          onTapDown: (val){setState(() {                                   
                                             btnPressed=true;
                                          });},                         
                                          onTap:()=> loginRegister(context),                         
                                                  
                                        ),
                            ),

                            widget.login?
                            Container(
                              height: hAcc,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                      FlatButton(
                                        padding: EdgeInsets.all( 0),
                                        child: Text(str_createAcc, 
                                              style:TextStyle(
                                                      fontSize: 13,
                                                      fontFamily: fntAljazeera, 
                                                      color: Color(color_blue), 
                                                      height:0),
                                              textAlign: TextAlign.left,
                                            ),
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginRegisterScreen(login: false,)));
                                        },
                                      ),
                                    Text(str_dontHaveAcc, 
                                      style:TextStyle(
                                              fontSize: 13, 
                                              fontFamily: fntAljazeera,height: 0),
                                      textAlign: TextAlign.center,
                                    )
                                ],
                              )                            
                            )
                            :
                             Text('', style: TextStyle(fontSize:0, ),),
                            
                            Container(
                              margin: EdgeInsets.only(top:brFoot, bottom: afFoot),
                              child: Text(str_ByTgDev,textAlign: TextAlign.center, style:TextStyle(height: 1.4, fontFamily: fntAqua, color: cLGrey, fontSize: fntSizeFoot),),
                            )
                  ]
                  ),
                  msgShow.trim()==''?
                   Text('', style: TextStyle(fontSize:0, ),)
                  :
                  alertMsg(context,  msgShow, containerKey, marge: 25),                    
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}