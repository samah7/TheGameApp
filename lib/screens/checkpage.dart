import 'package:chronometer/Ressources/Ressources.dart';
import 'package:chronometer/controller/function.dart';
import 'package:chronometer/controller/user_controller.dart';
import 'package:chronometer/screens/login_register.dart';
import 'package:chronometer/screens/timer_screen.dart';
import 'package:chronometer/widgets/alert.dart';
import 'package:flutter/material.dart';

class CheckPage extends StatefulWidget {
  final bool confirm;
  final String email;
  CheckPage({Key key, this.confirm=true, this.email}) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  final TextEditingController _checkNum = new TextEditingController(); 
  var loadPrs = false;  
  String  msgShow = '';
  String  msgError = '';
  UserController db = UserController();
  var containerKey = GlobalKey();
       
  
  send()async{        
    louseFocus(context);

    setState(() {
      loadPrs = true;
    });

    Future.delayed(const Duration(seconds: 1), ).then((_) async {
       msgShow = '';
       msgError = '';

             
        if(_checkNum.text.trim()=='') 
        setState(() {
          msgError = widget.confirm ? err_codeConfirm : err_mailConfirm;
        });
        else {
           // if(widget.confirm)
           try
            {
                setState(() {msgError = ''; });

                var response = await db.verifyEmail(widget.email, _checkNum.text);//lalla@seba_123.com
                print('response register: ${response}');
                if(response) 
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>LoginRegisterScreen(login:true, first:true))
                  );
                  //Navigator.of(context).pushNamed('/homeUser');
                else
                {                  
                 if(msgError.toLowerCase() == err_codeMissed.toLowerCase() || msgError.toString().toLowerCase().contains('email') ) 
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>LoginRegisterScreen()));  

                  setState(() {
                      msgError = db.rsponseMsg.replaceAll('{','').replaceAll('[','');
                      msgError = msgError.replaceAll('}','').replaceAll(']',''); 
                  });
                }
                           
              }
            catch(e){
              msgError = err_errVerify;
            }
         /* else 
            {
                if(widget.confirm)
                {
                  setState(() {msgError = ''; });

                  var response = await db.verifyCode(_checkNum.text);//lalla@seba_123.com
                  print('response register: ${response}');
                  if(response) 
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>TimerScreen())
                    );
                    //Navigator.of(context).pushNamed('/homeUser');
                  else setState(() {
                    msgError = db.rsponseMsg.replaceAll('{','').replaceAll('[','');
                    msgError = msgError.replaceAll('}','').replaceAll(']','');
                  });
                
                  if(msgError == err_codeMissed) 
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>CheckPage()));                
                }
                else
                {
                  setState(() {msgError = ''; });

                  var response = await db.verifySendCode(_checkNum.text);//lalla@seba_123.com
                  print('response register: ${response}');
                  if(response) 
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>CheckPage())
                    );
                    //Navigator.of(context).pushNamed('/homeUser');
                  else setState(() {
                    msgError = db.rsponseMsg.replaceAll('{','').replaceAll('[','');
                    msgError = msgError.replaceAll('}','').replaceAll(']','');
                  });
                
                  if(msgError == err_codeMissed) 
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>CheckPage(confirm: true,)));                
                }
            } */ 
        }
    
      setState(() {
          loadPrs = false;           
        }); 

      
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
    }  );
    
  }  
  
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    double logosize=size.height*.131;
    return Scaffold(
      appBar: AppBar( 
         leading: new IconButton(
              icon: Image.asset('assets/images/back.png',scale: 5,),
                   onPressed: () {}), 
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(''),
      ),
      body: Center( 
        child: SingleChildScrollView(
          child:  Stack(
          children: <Widget>[
            Container(
             width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              child: Column( 
                  mainAxisAlignment: MainAxisAlignment.start,  
                  children: <Widget>[
                    CircleAvatar(
                      radius:logosize,
                      backgroundImage: AssetImage('assets/images/logoblack.png'),
                    ), 
                    SizedBox(height: MediaQuery.of(context).size.height*0.086), 
                    Padding( 
                      padding: EdgeInsets.all(5.0), 
                    child: Container( 
                      height: MediaQuery.of(context).size.height*0.065, 
                      width: MediaQuery.of(context).size.width*0.8,
                      //margin: EdgeInsets.only(top: 5.0, bottom: 5.0), 
                      child: TextField(
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center, 
                        controller: _checkNum,
                        keyboardType: widget.confirm ?  TextInputType.text : TextInputType.emailAddress,
                        style: TextStyle(fontSize:15, color: cText, fontFamily: fntAljazeera),
                        decoration: InputDecoration( 
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),   
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                            borderSide: BorderSide(
                              color: Color(0xff000000),
                              //width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            borderSide: BorderSide(
                              color: Color(0xff000000), 
                              //width: 2.0, 
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            borderSide: BorderSide(
                                //width: 2.0,
                                ),
                          ),
                          hintText: widget.confirm ? str_codeConfirm : str_email,
                          hintStyle: TextStyle( 
                              fontFamily: fntAljazeera,
                              fontSize: 15.0,
                              color: Color(0x80000000)),
                        ),
                      ),
                    ), 
                    ), 
                    //SizedBox(height: 3.0), 
                      Container(
                              height: 23.0,
                              width: 160,
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.only(top:6),  
                    child: FlatButton(  
                        child: Text( widget.confirm ? str_resendConfirm : str_haveConfirm,
                        style: new TextStyle(
                                      color: Color(0xff2F80C4), 
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 13.0, 
                                    ), 
                                    textAlign: TextAlign.center,  
                        ), 
                        onPressed: ()async{
                           await db.sendVerifyCode(widget.email);
                         //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>LoginRegisterScreen(login:true)));
                        },//CheckPage(confirm: !widget.confirm,))),  
                    ), 
                      ),    
                    SizedBox(height:MediaQuery.of(context).size.height* 0.06),  
               Container( 
                 //width: MeiaQuery.of(context).size.width, 
                 key: containerKey,                 
                 height: MediaQuery.of(context).size.height*0.077,
                 width: MediaQuery.of(context).size.width*0.4,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage(loadPrs? 'assets/images/clicked.png': 'assets/images/noclicked.png'), 
                     fit: BoxFit.contain,  
                   ), 
                 ), 
                      child: InkWell( 
                        splashColor: Colors.transparent, 
                        highlightColor: Colors.transparent, 
                        
                        onTapDown: (val){
                            setState((){
                              loadPrs = true; 
                            }); 
                        }, 
                        onTap: send,
                         
                       
                        ), 
               ),     
                      
                    SizedBox(height: MediaQuery.of(context).size.height* 0.03), 
                  Text("BY \n TG Developers", 
                  textAlign: TextAlign.center,  
                  style: new TextStyle(
                              fontSize: 20.0,  
                              fontFamily: fntAqua, 
                              color: Color(0x59000000), 
                              height: 1.3, 
                              ), 
                  ), 
                
                  ],
                ),
            ), 
            msgShow.trim()==''? Text('') :
             alertMsg(context,  msgShow, containerKey)
          ],
          ), 
        ), 
      ), 
    );
  }
}