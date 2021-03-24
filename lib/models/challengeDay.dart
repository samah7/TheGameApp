class Day {
  final bool status;
  final String errNum;

  final int DayChallenge;
  final String message;

  Day({this.status, this.errNum, this.DayChallenge, this.message});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      status: json['status'],
      errNum: json['errNum'],
      DayChallenge: json['challenges Day'],
      message: json['msg'],

    );
  }
}
