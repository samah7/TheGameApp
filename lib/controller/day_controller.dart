import '../models/challengeDay.dart';
import '../controller/user_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Day> fetchDay() async {
    final String url =
        "https://mymission-api.herokuapp.com/api/getChallengeDayCount";
    try{
        final response = await http.post(url, headers: {
          'Accept': 'application/json',
          'Authorization':
              'bearer ${UserController.user.token}',//eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9teW1pc3Npb24tYXBpLmhlcm9rdWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2MTI0NjUzMzksIm5iZiI6MTYxMjQ2NTMzOSwianRpIjoicHlScFNsenBOQXB5VjJBNyIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.CNQFwRuWIDSW9bJhD380NhXAjyslCUJ7E7xd25svENQ',
        }, body: {
          "api_password": "xuqhBhc8KkajZbhHoViT"
        });
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          print(jsonDecode(response.body));
          return Day.fromJson(jsonDecode(response.body));
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
        // throw Exception('Failed to load Day');
          return Day();
        }
    }
    catch(e){
          return Day();      
    }
  }