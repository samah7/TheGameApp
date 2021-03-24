import '../models/ownerChallenge.dart';





class Challenges{

  bool status;
  String errNum;

///list of challenge
  final List<dynamic> challenges;


  Challenges({this.status,this.errNum,this.challenges});


  factory Challenges.fromJson(Map<String, dynamic> jsonData){

    return Challenges(
      status: jsonData['status'],
        errNum: jsonData['errNum'],
        challenges: jsonData['challenges']
    );
  }

}