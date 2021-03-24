import 'dart:convert';
import 'package:intl/intl.dart';

import '../Ressources/Ressources.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

 class UserController{
   String url    = 'https://mymission-api.herokuapp.com/api';
   String urlAdm = 'https://maak-app.herokuapp.com/api/employee';
   var status;
   var rsponseMsg='';
   static User user = User.fromJson(Map());
  
 
  loginData(String email, String password, bool save) async{
      String myUrl= "$url/login";
      rsponseMsg = '';
      var msg;
      try{
      final response = await http.post(myUrl,
              headers: {'Accept':'application/json'},
              body:{'social_id':email, 'password':password, "api_password": "xuqhBhc8KkajZbhHoViT"}
              );
        var data = json.decode(response.body);
        status = data['status'];
        if (status){          
          user.setToken = data['access_token']; 
          var result = data['Data']; 
          user = User.fromJson(result); 
          await getChallenge();
          rsponseMsg = '';
          status = true;

          await _saveInfoUser();
          await readTask();
          
          print('data : ${data['access_token']}');
        } else{
          print('data : ${data['msg']}');
          rsponseMsg = data['msg'].toString();
        }
      }
      catch(e){
        print(e.toString());
        if (e.message.toString().contains('Failed host'))
           rsponseMsg =  err_errConnexion ;
        else rsponseMsg = e.toString();
        status = false;
      }
      return status;
  }
   
  Future<bool> getChallengeUser() async {
    String myUrl = '$url/getChallenge';
    var ret = false;
    var target;
    var insta;
    var lastDate;
    try {
      http.Response res = await http.post(myUrl,
          headers: {
            "Accept": 'application/json',
            'Authorization': 'bearer ${user.token}'
          },
          body: {
            "api_password": "xuqhBhc8KkajZbhHoViT"
          }
      );
      var data = json.decode(res.body);
      ret = data["status"];
      if (ret) {
        target    = data['challenge']['hero_target'];
        insta     = data['challenge']['hero_instagram'];
        lastDate  = data['challenge']['lastAddedCapsulesDate'];
        var role  = data['challenge']['role'];
        user.setRole = role ?? user.role;

        user.lastDate = lastDate;
        user.setHero_target = target;
        user.setInstagram = insta;
        user.hasChallenge = target!=null && target != '';

      }
      else rsponseMsg = data['msg'];
    } 
    catch (e) {
        print(e);
    }
    return ret;
  }

  logout() async{
     String myUrl="$url/logout";
     rsponseMsg = '';
     try{
     final response = await http.post(myUrl,
            headers: {'Accept':'application/json',
                      'Authorization' : 'bearer ${user.token}'},                      
            body: {
              "api_password": "xuqhBhc8KkajZbhHoViT"
            } 
          );
      var data = json.decode(response.body);
      status =  data['status'];
      if (status)
      {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove(shared_token);
        prefs.remove(shared_role);
        prefs.remove(shared_name);
        prefs.remove(shared_insta);
        prefs.remove(shared_isBanned);
        prefs.remove(shared_Date);
        prefs.remove(shared_hasChallenge);
        prefs.remove(shared_picture);
        prefs.remove(shared_target);
        
       /*
       // prefs.remove(shared_nbCpl);
        prefs.remove(shared_task1);
        prefs.remove(shared_task2);
        prefs.remove(shared_task3);
        prefs.remove(shared_task4);
        prefs.remove(shared_task5);
        prefs.remove(shared_task4);
        prefs.remove(shared_DatePoint);
        prefs.remove(shared_firstOpen);*/
      } 
      else{
        rsponseMsg = data['msg'].toString();
      }
    }
    catch(e){
      print(e.message());
       status = false;
    }
    return status;
   }

  registerData(String email, String password, String c_password) async{
    rsponseMsg = '';
    String myUrl="$url/register";    
    status = false;
    try{
        final response = await http.post(myUrl,
              headers: {'Accept':'application/json'},
              body:{'social_id':email, 'password':password, 'c_password':c_password, "api_password": "xuqhBhc8KkajZbhHoViT"}
              );
        var data = json.decode(response.body);
        status =  data['status'];
        rsponseMsg = data['msg'].toString();
    }
    catch(e){
      if (e.message!=null && e.message.contains('Failed host'))
      rsponseMsg =  err_errConnexion ;
    else if (e.message!=null)
         rsponseMsg = e.toString();
    }

    return status;
  }

  Future sendVerifyCode(String email) async{
    String myUrl= "$url/resendVerifyCode";
    rsponseMsg = '';
    try{
      final response = await http.post(myUrl,
            headers: {
              'Accept':'application/json',
              }, 
            body: {
              "social_id": email,
              "api_password": "xuqhBhc8KkajZbhHoViT"
            }          
            );

      var data = json.decode(response.body);
      status =  data['status'];

      if(!status) rsponseMsg = data['msg'].toString();
    }
    catch(e) {
      rsponseMsg = e.toString();
      status = false;
    }   
    return status;
  }

  Future verifyEmail(String email, String code) async{
    String myUrl= "$url/verifyEmail";
    rsponseMsg = '';
    try{
      final response = await http.post(myUrl,
            headers: {
              'Accept':'application/json',
              }, 
            body: {
              "social_id"    : email,
              "verifyCode"   : code,
              "api_password" : "xuqhBhc8KkajZbhHoViT"
            }          
            );

      var data = json.decode(response.body);
      status =  data['status'];
      if(!status) rsponseMsg = data['msg'].toString();
    }
    catch(e) {
      rsponseMsg = e.message;
      status = false;
    }   
    return status;
  }


 Future addDayCapsules(int capsules) async{
  String myUrl= "$url/addDayCapsules";
  rsponseMsg = '';
  status = false;
  try{
    final response = await http.post(myUrl,
          headers: {
            'Accept':'application/json',
            'Authorization':'bearer ${user.token}'
            }, 
          body: {
            "capsules": '$capsules',
            "api_password": "xuqhBhc8KkajZbhHoViT"
          }          
          );

    var data = json.decode(response.body);
    status =  data['status'];
    if(status) 
    {
      await saveCpsl(0);
      await saveLastDateLoad(DateTime.now());
      }
    else rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    if (e.message.toString().contains('Failed host'))
        rsponseMsg =  err_errConnexion ;
    else rsponseMsg = e.message;
    status = false;
  }   
  return status;
}

 getnbHours() async{
  double nbHours = 0;
  String myUrl= "$url/getCountHoursAfterAddCapsules";
  rsponseMsg = '';
  status = false;
  try{
    final response = await http.post(myUrl,
          headers: {
            'Accept':'application/json',
            'Authorization':'bearer ${user.token}'
            },
          body: {
            "api_password": "xuqhBhc8KkajZbhHoViT"
          } 
          );

    var data = json.decode(response.body);
    nbHours = data['differnet_In_hours'];
    status =  data['status'];

    if(!status) rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    rsponseMsg = e.message;
    status = false;
  }   
  return nbHours;
}


//getTrandingChallenges

getRank() async{
  String myUrl= "$url/getUserRankInCapsules";
  int rank; 
  rsponseMsg = '';
  if (user.hasChallenge)                 
  try{
    final response = await http.post(myUrl,
          headers: {
            'Accept':'application/json',
            'Authorization':'bearer ${user.token}'
            }, 
          body: {
            "api_password": "xuqhBhc8KkajZbhHoViT"
           } 
          );

    var data = json.decode(response.body);
    status =  data['status'];
    rank =  data['rank'];
    if(!status) rsponseMsg = data['msg'].toString();
  }
  catch(e) {
    rsponseMsg = e.message;
    status = false;
    rank = 0;
  }   
  return rank;
}

  Future<int>nbCplgetChallenge()async{
    String myUrl='$url/getChallenge';
    status=false;
    int rasid = 0;
    try{
      http.Response res=await http.post(myUrl,
          headers: {
            "Accept":'application/json',
            'Authorization':'bearer ${user.token}'
          },
          body: {
           "api_password": "xuqhBhc8KkajZbhHoViT"
          }
      ) ;
     var data=json.decode(res.body);
      if (data != null && data["status"] == true) {
        var cha=data['challenge'];
        rasid =cha['capsules'];
       //print(target);
      }
     

    }catch(e){
      return rasid;
    }
     return rasid;
   }
  
 addPicture(String pictureName) async{
    double nbHours = 0;
    String myUrl= "$url/addPicture";
    rsponseMsg = '';
    try{
      final response = await http.post(myUrl,
            headers: {
              'Accept':'application/json',
              'Authorization':'bearer ${user.token}'
              },
            body: { 
              "pictureName": pictureName,
              "api_password": "xuqhBhc8KkajZbhHoViT"
             } 
            );

      var data = json.decode(response.body);
      status =  data['status'];
      if(!status) 
      rsponseMsg = data['msg'].toString();
      else 
      {        
        user.setPictureName = pictureName;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(shared_picture, user.pictureName);
      }
    }
    catch(e) {
      rsponseMsg = e.message;
      status = false;
    }   
    return status;
}

getPicture() async{
    String picture = '';
    String myUrl= "$url/getUserPictureName";
    rsponseMsg = '';
    try{
      final response = await http.post(myUrl,
            headers: {
              'Accept':'application/json',
              'Authorization':'bearer ${user.token}'
              },
            body: { 
              "api_password": "xuqhBhc8KkajZbhHoViT"
             } 
            );

      var data = json.decode(response.body);
      status =  data['status'];
      if(!status) rsponseMsg = data['msg'].toString();
      picture = data['picturename'];      
    }
    catch(e) {
      rsponseMsg = e.message;
      status = false;
    }   
    return picture;
}

getDayChallengePoints() async{
    int point = 0;
    String myUrl= "$url/getChallengeDayCount";
    rsponseMsg = '';
    try{
      final response = await http.post(myUrl,
            headers: {
              'Accept':'application/json',
              'Authorization':'bearer ${user.token}'
              },
            body: { 
              "api_password": "xuqhBhc8KkajZbhHoViT"
             } 
            );

      var data = json.decode(response.body);
      status =  data['status'];
      if(!status) rsponseMsg = data['msg'].toString();
      point = data['challenges Day'];      
    }
    catch(e) {
      rsponseMsg = e.message;
      status = false;
    }   
    return point;
}
  
   saveCpsl(int cbl) async{
     final prefs = await SharedPreferences.getInstance();
     prefs.setInt(shared_nbCpl, cbl);
   }

  readCbl()async{
     var prefs = await SharedPreferences.getInstance();
     final key = shared_nbCpl;
     final value = prefs.getInt(key)?? 0;
     return value; 
   }  

   
   saveLastDateLoad(now) async{ 
     var val = now.toString();
     final prefs = await SharedPreferences.getInstance();
     user.lastDate = val;
     prefs.setString(shared_Date, val);
   }

  int getnbHoursLastDateLoad(){  
    var now = DateTime.now();   
    var val = DateTime(now.year, now.month, now.day - 1);//, now.hour, now.minute); 
    String yesterday = val.toString();
    var lastDate;
   /* var prefs = await SharedPreferences.getInstance();
    final key = shared_Date;*/
    
    var dtUser = DateTime.parse(user.lastDate);
    val = DateTime(dtUser.year, dtUser.month, dtUser.day);
    String value = yesterday;
    
    if(user.lastDate==null || user.lastDate.trim()=='')
    lastDate = DateTime.parse(value);
    else lastDate = val;

    
    int diff = now.difference(lastDate).inDays;
    //double diff = now.difference(lastDate).inSeconds/3600;
    return diff;     
  } 

  bool isLoadActive(){
     bool isActive = false;
     var nbMin = 24;
     double nbHours = 24; 
     int day = 0;
     status = false;
   
    /*nbHours = getnbHoursLastDateLoad();     
     isActive = (nbHours>=nbMin && user.hasChallenge);
    */
     day = getnbHoursLastDateLoad();
    /* var tm =  DateFormat.H().format(DateTime.now()); 
     int t = int.parse(tm);*/
     isActive = (day>=1 && user.hasChallenge);// && ( t >= 0));
     
     return isActive;
   }

   _saveInfoUser() async{
     final prefs = await SharedPreferences.getInstance();
     prefs.setString(shared_token, user.token);
     prefs.setString(shared_role, user.role);
     prefs.setString(shared_name, user.name);
     prefs.setBool(shared_isBanned, user.is_banned);
     prefs.setBool(shared_hasChallenge, user.hasChallenge);
     prefs.setString(shared_insta, user.hero_instagram);
     prefs.setString(shared_target, user.hero_target);
     prefs.setString(shared_picture, user.pictureName);
     prefs.setString(shared_Date, user.lastDate);
   }
   readUserInfo()async{ 
     try{     
      final prefs       =  await SharedPreferences.getInstance();
      user.setToken     = prefs.getString(shared_token);
      token = user.token;
      user.setName      = prefs.getString(shared_name);
      user.setIs_banned = prefs.getBool(shared_isBanned);
      user.setPictureName = prefs.getString(shared_picture);
      bool read = await getChallengeUser();
      if(!read)
      {
        user.hasChallenge = prefs.getBool(shared_hasChallenge)??false;
        user.setRole      = prefs.getString(shared_role);
        user.setInstagram = prefs.getString(shared_insta);
        user.setHero_target = prefs.getString(shared_target);
        user.lastDate       = prefs.getString(shared_Date);
      }
      await readTask();
      return true;
     }
     catch(e){
       return false;
     }
   }

   getRole() async{
     final prefs = await SharedPreferences.getInstance();
     final key = shared_role;
     final value = prefs.get(key);
     return value;
   }


   
  saveTask(task1, task2, task3, task4, task5, task6) async{
     user.task1  = task1 ;      
     user.task2  = task2 ;      
     user.task3  = task3 ;      
     user.task4  = task4 ;      
     user.task5  = task5 ;      
     user.lastDatePoint = DateTime.now().toString(); 
     user.task6  = task6 ;      

     final prefs = await SharedPreferences.getInstance();
     prefs.setBool(shared_task1,     task1        );
     prefs.setBool(shared_task2,     task2        );
     prefs.setBool(shared_task3,     task3        );
     prefs.setBool(shared_task4,     task4        );
     prefs.setBool(shared_task5,     task5        );
     prefs.setBool(shared_task6,     task6        );
     prefs.setString(shared_DatePoint, DateTime.now().toString());
   }

   readTask()async{
      final prefs =  await SharedPreferences.getInstance();
      user.task1          = prefs.getBool(shared_task1)??true;
      user.task2          = prefs.getBool(shared_task2)??true;
      user.task3          = prefs.getBool(shared_task3)??true;
      user.task4          = prefs.getBool(shared_task4)??true;
      user.task5          = prefs.getBool(shared_task5)??true;
      user.task6          = prefs.getBool(shared_task4)??true;
      user.lastDatePoint  = prefs.getString(shared_DatePoint);
   }

   Future<SharedPreferences> readToken() async{
     final prefs = await SharedPreferences.getInstance();
     final key = shared_token;
     final value = prefs.get(key)?? 0;
     return prefs;
   }
   
/////
///

_saveHasChallenge(bool haschallenge)async{
  final prefs=await SharedPreferences.getInstance();
  final key=shared_hasChallenge;
  final value=haschallenge;
  prefs.setBool(key,value);
  
  prefs.setString(shared_name, user.name);
  prefs.setString(shared_insta, user.hero_instagram);
  prefs.setString(shared_target, user.hero_target);
}

//read haschallenge
  //create challenge
  createChallenge(String name, String instegram, String target) async {
    status = false;
    rsponseMsg='';
    String myUrl = 'https://mymission-api.herokuapp.com/api/createChallenge';
    try {
      http.Response res = await http.post(myUrl,
          headers: {
            "Accept": 'application/json',
            'Authorization': 'bearer ${user.token}'
          },
          body: {
            "display_name": "$name",
            "hero_instagram": "$instegram",
            "hero_target": "$target",
            "api_password": "xuqhBhc8KkajZbhHoViT"
          }
      );
      var data = json.decode(res.body);
      status = data['status'];

      if (status==true){ 
           rsponseMsg='تم تسجيل هدفك بنجاح';
           user.hasChallenge   = true;
           user.setName        = name;
           user.setHero_target = target;
           await _saveHasChallenge(user.hasChallenge);
      }
      else{
        rsponseMsg = data["msg"];
        if (rsponseMsg==null)
        rsponseMsg = data.toString().split(':')[1].replaceAll('}', '');
        status = false;
      }
    } 
    catch(e) {
        print(e);
        status=false;     
          if (e.message.toString().contains('Failed host'))
            rsponseMsg =  err_errConnexion ;
          else rsponseMsg=e.toString();
    }
    return status;
  }


  Future<String> getChallenge() async {
    String myUrl = '$url/getChallenge';
    status = false;
    rsponseMsg = '';
    var target;
    var insta;
    var lastDate;
    try {
      http.Response res = await http.post(myUrl,
          headers: {
            "Accept": 'application/json',
            'Authorization': 'bearer ${user.token}'
          },
          body: {
            "api_password": "xuqhBhc8KkajZbhHoViT"
          }
      );
      var data = json.decode(res.body);
      status = data["status"];
      if (status) {
        target    = data['challenge']['hero_target'];
        insta     = data['challenge']['hero_instagram'];
        lastDate  = data['challenge']['lastAddedCapsulesDate'];
        var role  = data['challenge']['role'];
        user.setRole = role ?? user.role;
        user.lastDate = lastDate;
        user.setHero_target = target;
        user.setInstagram = insta;
        user.hasChallenge = target!=null && target != '';

      }
      else rsponseMsg = data['msg'];
        //print(target);
        return target;
     // }
     // else {

      //}
    } 
    catch (e) {
        print(e);
      
        if (e.message.toString().contains('Failed host'))
            rsponseMsg =  err_errConnexion ;
        else rsponseMsg=e.toString(); 
    }
  }
  
  addDaypoint(int point)async{
    String myUrl='$url/addDayPoints';
    rsponseMsg='';
    status = false;
    try{
      http.Response res=await http.post(myUrl,
          headers: { "Accept": 'application/json',
            'Authorization': 'bearer ${user.token}'},
          body:{
            "points":'$point',
            "api_password": "xuqhBhc8KkajZbhHoViT"
          } );
      var  data = json.decode(res.body);
      status=data['status'];
      if (status==true){
        rsponseMsg = ' تم تسجيل نقاطك لليوم بنجاح';
      }else{
        rsponseMsg = data["msg"];
        if (rsponseMsg==null)
        rsponseMsg = data.toString().split(':')[1].replaceAll('}', '');
      }

    }catch(e){
      print(e.toString());
      if (e.message.toString().contains('Failed host'))
        rsponseMsg = 'تأكد من اتصالك بالأنترنت';
      else rsponseMsg = e.toString();

    }

  }
// /////get point for leaderbord
 
  /////get point for leaderbord
  Future<List<User>> getTrandingpoint()async{
    List heroslist=List<User>();
    String myUrl='$url/getTrandingInPoints';
    var tk= user.token??token;
    try{
      http.Response res= await http.post(myUrl,
        headers: { "Accept": 'application/json',
          'Authorization': 'bearer $tk'},
        body: {
          "api_password": "xuqhBhc8KkajZbhHoViT"
        }
      );
     var data=  json.decode(res.body);

     List u=data["challenges"];
    for (var i=0;i<u.length;i++){
      var v= User.fromJson(u[i]);
      heroslist.add(v);
    }

    }
    catch(e) {}
    return heroslist;


  }

//////
////gettranding capsules
  Future<List<User>> getTrandingcapsules()async{
    List heroslist=List<User>();
    String myUrl='$url/getTrandingInCapsules';
    try{
      http.Response res= await http.post(myUrl,
          headers: { "Accept": 'application/json',
            'Authorization': 'bearer ${user.token}'},
          body: {
            "api_password": "xuqhBhc8KkajZbhHoViT"
          }
      );
      var data=  json.decode(res.body);

      List u=data["challenges"];
      for (var i=0;i<u.length;i++){
        var vc= User.fromJson(u[i]);
        heroslist.add(vc);
      }

    }
    catch(e) {}
    return heroslist;

  }

/////
  Future<bool>delete(int  id)async{
    status=false;
  String myUrl='$url/deleteUser';
  try{
  http.Response res= await http.post(myUrl,
      headers: { "Accept": 'application/json',
        'Authorization': 'bearer ${user.token}'},
      body: {
        "user_id":"$id",
        "api_password": "xuqhBhc8KkajZbhHoViT"
      });
       var data=json.decode(res.body);
       status=data["status"];
      }catch(e){

  }
  return status;
}

 Future<bool> challengVerified(int id,String bool)async{
    String myUrl='$url/challengVerified';
    try{
      http.Response res= await http.post(myUrl,
          headers: { "Accept": 'application/json',
            'Authorization': 'bearer ${user.token}'},
          body: {
            "user_id":'$id',
            "is_challengVerified":'$bool',
            "api_password": "xuqhBhc8KkajZbhHoViT"
          });
      var data=json.decode(res.body);
      status=data["status"];
      return status;
    }catch(e){

    }
  }

}