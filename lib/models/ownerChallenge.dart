class Challenge{


  final int userId;
   String isVerified;
  final String displayName;
  final String pictureName;
   String role;
    String is_banned;



  Challenge({this.userId, this.isVerified , this.displayName, this.pictureName, this.role, this.is_banned});


  factory Challenge.fromJson(Map<String, dynamic>jsonData){

    return Challenge(
      userId: jsonData['user_id'],
      isVerified: jsonData['is_challengVerified'],
      displayName: jsonData['display_name'],
      pictureName: jsonData['pictureName'],
      role: jsonData['role'],
       is_banned: jsonData['is_banned'],



    );
  }

}