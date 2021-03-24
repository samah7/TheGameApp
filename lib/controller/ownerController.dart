import 'dart:convert';

import 'package:chronometer/controller/user_controller.dart';

import '../models/listChallenges.dart';
import '../models/ownerChallenge.dart';
import 'package:http/http.dart' as http;


class ChallengeApi {


  final String url = "https://mymission-api.herokuapp.com/api/getTrandingInPoints";

  Future<List<Challenge>> fetchChallenges() async {
    try {
      http.Response response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Authorization": "bearer ${UserController.user.token ?? 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9teW1pc3Npb24tYXBpLmhlcm9rdWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2MTIyNzIxMjksIm5iZiI6MTYxMjI3MjEyOSwianRpIjoicnNRd1dsaE1iT0oxWVdncSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.ETuGJ3SeUPF4B93vsUdoNuLx3ny5k1GPBU8AG67etic'}",
          },
          body: {
            "api_password": "xuqhBhc8KkajZbhHoViT"
          }
      );


      if (response.statusCode == 200) {
        String data = response.body;

        var jsonData = jsonDecode(data);

        ///list of articles
        Challenges challenges = Challenges.fromJson(jsonData);

        /// from list of maps to list iterable
        /// /// collection of articles
        List<Challenge> challengeList = challenges.challenges.map((e) =>
            Challenge.fromJson(e)).toList();

        return challengeList;
      }
      else {
        print("status Code is");
        print(response.statusCode);
      }
    }
    catch (e) {
      print(e);
    }
  }


  /// update


  Future<bool>updateUser(int id, String role, is_banned) async {
    // final prefs = await SharedPreferences.getInstance();
    // final key = 'token';
    // final value = prefs.get(key ) ?? 0;

    bool status=false;

    String upUrl = "https://mymission-api.herokuapp.com/api/updateUser";
    try {
      http.Response response =await http.post(upUrl,
          headers: {
            "Accept": "application/json",
            "Authorization": "bearer ${UserController.user.token ?? 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9teW1pc3Npb24tYXBpLmhlcm9rdWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2MTI0NjUzMzksIm5iZiI6MTYxMjQ2NTMzOSwianRpIjoicHlScFNsenBOQXB5VjJBNyIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.CNQFwRuWIDSW9bJhD380NhXAjyslCUJ7E7xd25svENQ'}",
          },
          body:
          {
            "user_id": id.toString(),
            "role": "$role",
            "api_password": "xuqhBhc8KkajZbhHoViT",
            "is_banned": false.toString(),
          });
          
            print('Response status : ${response.statusCode}');
            print('Response body : ${response.body}');
            var data= json.decode(response.body);
            status = data['status'];
         
          return status;
    }
    catch(e){
      return status;
    }

  }


  /// search for user
   getIsbanned(String name) async {
    String myUrl = "https://mymission-api.herokuapp.com/api/searchForUser";
    // rsponseMsg = '';
    String is_banned = "";
    try {
      final response = await http.post(myUrl,
          headers: {
            'Accept': 'application/json',
            'Authorization': "bearer ${UserController.user.token ?? 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9teW1pc3Npb24tYXBpLmhlcm9rdWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2MTIyODM0NjQsIm5iZiI6MTYxMjI4MzQ2NCwianRpIjoiOXM1dTJLRnRSdnZkcEdldCIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.NEyqZR56uGMiXWQZfOpoLnucyuANZd_CDVQbVpmhHgU'}",
          },
          body: {
            "display_name": "$name",
            "api_password": "xuqhBhc8KkajZbhHoViT"
          }
      );

      var data = json.decode(response.body);
      // status =  data['status'];
      // if(!status) rsponseMsg = data['msg'].toString();
      is_banned = data['is_banned'];

      return data['status'];
    }
    catch (e) {
      return false;
    }
      return false;
    // rsponseMsg = e.message;
    // status = false;
    // }
   // return is_banned;
  }

}
