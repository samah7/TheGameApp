import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../models/ownerChallenge.dart';
import '../Controller/ownerController.dart';
import '../Ressources/Ressources.dart';
import '../models/listChallenges.dart';


class OwnerScreen extends StatefulWidget {
  @override
  _OwnerPageState createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerScreen> {
  List<Challenge> _challenges = List<Challenge>();

  List<Challenge> _challengeDisplay = List<Challenge>();

  ///search  (affichage de list)
  bool _isLoading = true;

  Challenges c = new Challenges();

  ChallengeApi _api = new ChallengeApi();

  /// switch valeur
  bool value_1 = true;

  @override
  void initState() {
    _api.fetchChallenges().then((value) {
      setState(() {
        _isLoading = false;
        _challenges.addAll(value);
        _challengeDisplay = _challenges;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(h * 0.092),
        child: AppBar(
          backgroundColor: Color(0XffEBEBEB),
          leading: new IconButton(
              icon: Image.asset('assets/images/back.png', scale: 5),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              }),
          title: Center(
            child: Text(
              "Command Center",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          // if(_challengeDisplay.length > 0){
          if (!_isLoading) {
            return index == 0 ? _search() : _listItem(index - 1);
            //return  _listItem(index);
            //
            //
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        itemCount: _challengeDisplay.length + 1,
      ),
    );
  }

  //
  // ///barre de recherche
  _search() {
    return new Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.036,
          bottom: MediaQuery.of(context).size.height * 0.0394,
          right: MediaQuery.of(context).size.width * .08,
          left: MediaQuery.of(context).size.width * .08),
      height: MediaQuery.of(context).size.height * .076,
      width: MediaQuery.of(context).size.width * 0.83,

      // padding: EdgeInsets.all(15.0),
      child: TextField(
        ///on changed function
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _challengeDisplay = _challenges.where((_hero) {
              var postTile = _hero.displayName.toLowerCase();

              //post.title.toLowerCase();
              return postTile.contains(text);
            }).toList();
          });
        },
        autocorrect: true,
        decoration: InputDecoration(
          prefixIcon: Image.asset(
            'assets/images/search1.png',
            scale: 3,
          ),
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(color: Color(0xffF4C852), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(
              color: Color(0xffF4C852),
            ),
          ),
        ),
      ),
      // ),
    );
  }

  ///liste
  ////*
  _listItem(index) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    _verifiedWidget() {
      if (_challengeDisplay[index].isVerified == "true") {
        return Container(
          width: w * 0.055,
          height: h * 0.03,
          child: Image.asset(
            'assets/images/verified.png',
          ),
        );
      } else {
        return Container(
          width: w * 0.055,
          height: h * 0.03,
          child: Text(
            '',
            style: TextStyle(fontSize: 0.0),
          ),
        );
      }
    }

    ///flutter switch
    _switchWidget() {
      if (index == 0) {
        return Container(
          width: w * 0.055,
          height: h * 0.03,
          child: Text(
            '',
            style: TextStyle(fontSize: 0.0),
          ),
        );
      } else {
        return Container(
            child: FlutterSwitch(
          // toggleSize: 45.0,
          value: _challengeDisplay[index].role != "hero",
          borderRadius: 15.0,
          padding: 2.0,
          toggleColor: Color.fromRGBO(225, 225, 225, 1),
          /*  switchBorder: Border.all(
      color: Colors.green,
      width: 1.0,
    ),*/

          activeColor: Colors.green,
          inactiveColor: Colors.grey,
          onToggle: (val) async {
            bool status = false;
            if (_challengeDisplay[index].role == "hero") {
              status = await _api.updateUser(
                  _challengeDisplay[index].userId, "admin", false);

              if (status == true) {
                setState(() {
                  _challengeDisplay[index].role = "admin";
                });
              }
            } else if ((_challengeDisplay[index].role == "admin")) {
              value_1 = true;

              status = await _api.updateUser(
                  _challengeDisplay[index].userId, "hero", false);

              if (status == true) {
                setState(() {
                  _challengeDisplay[index].role = "hero";
                });
                print('ffff');
                print(_challengeDisplay[index].role);
              }
            }
          },
        ));
      }
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                /// verified widget
                _verifiedWidget(),

                SizedBox(
                  width: w * .048,
                ),

                Container(
                  width: w * 0.135,

                  height: h * 0.0339,
                  //height: 55.0,
                  //height: h * 0.035,
                  child: _switchWidget(),
                ),

                SizedBox(
                  width: w * .036,
                ),

                /// name of hero
                ///
                Expanded(
                  child: Container(
                    child: Text(
                      _challengeDisplay[index].displayName != null
                          ? _challengeDisplay[index].displayName
                          : 'name',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        //25
                       // fontSize: w * .03396,
                        fontSize: w * .03396<15 ? w * .03396:15,

                        fontWeight: FontWeight.bold,
                        fontFamily: fntAljazeera,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: w * .036,
                ),

                ///image of hero

                Container(
                  height: h * .08,
                  width: w * .1449,
                  child: CircleAvatar(
                    radius: w * .1449,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: w * .1449,
                      backgroundImage: AssetImage(
                          _challengeDisplay[index].pictureName != null
                              ? _challengeDisplay[index].pictureName
                              : 'assets/imageavatar/hero.jpg'),
                    ),
                  ),
                ),

                SizedBox(
                  width: w * 0.036,
                ),

                Container(
                  height: h * .039,
                  width: w * 0.07,

                  //   child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      //radius: 14.5,
                      radius: .0394,

                      child: Text(
                        '${index + 1}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  // ),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(
                  width: w * 0.067,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
