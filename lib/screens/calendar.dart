import '../Ressources/Ressources.dart';
import '../controller/day_controller.dart';
import '../controller/user_controller.dart';

import '../models/challengeDay.dart';

import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {

  Future<Day> futureDay;
  UserController db = UserController();

  @override
  void initState() {
    super.initState();
    futureDay = fetchDay();   
  }

  @override
  Widget build(BuildContext context) {
    var H = MediaQuery.of(context).size.height;
    var W = MediaQuery.of(context).size.width;
    bool exists = false;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(H*0.15),
        child: AppBar(
          leading: new IconButton(
              icon: Image.asset('assets/images/back.png',scale: 5,),
              onPressed: () {                
                if(Navigator.of(context).canPop())
                  Navigator.of(context).pop();                
                Navigator.of(context).pushNamed('/home');
              },
          ),
          title: Padding(
            padding: EdgeInsets.only(top:H*0.02, right:12.0),
            child: Align(alignment: Alignment.centerRight,
              child: Text(
                ' التحدي',
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: W*0.0917,
                  fontFamily: fntAljazeera,
                ),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Color(0xffEBEBEB),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.47,
                  // height: 360.0,
                  margin: const EdgeInsets.only(bottom: 10.0),

                  ///gridview
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: (){
                        // if(exists)
                         Navigator.of(context).pushNamed('/dailyTask');
                         },
                      child: Container(
                        margin: EdgeInsets.only(left:W*0.0748, right:W*0.0748),// top:H*0.057, bottom: H*0.0557 ),                      
                        height: MediaQuery.of(context).size.height * 0.3,
                        // height: 300,

                        child: Center(
                          child: FutureBuilder<Day>(
                            future: futureDay,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GridView.builder(
                                  itemCount: 60,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 10,                                      
                                          crossAxisSpacing: H*0.012,
                                          mainAxisSpacing: W*0.0169),
                                  itemBuilder: (BuildContext context, int index) {
                                    if ((index + 1) == snapshot.data.DayChallenge) {
                                      exists=true;
                                      if(UserController.user.lastDatePoint!=null)
                                      { 
                                        var dt = DateTime.parse(UserController.user.lastDatePoint).day;
                                        if(snapshot.data.DayChallenge!=dt)
                                        db.saveTask(true, true, true, true, true, true);
                                      }
                                      return Container(
                                        height: W*0.108,
                                        width: W*0.108,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/10_green.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                                      (snapshot.data.DayChallenge.toString()) != null ?
                                                      (snapshot.data.DayChallenge.toString()): 'default value',
                                                      style:TextStyle(fontFamily: fntAljazeera, fontSize:W*0.043 ),
                                              //snapshot.data.display_name
                                              ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        height: W*0.108,
                                        width: W*0.108,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/10_locked.png'),
                                              fit: BoxFit.cover),
                                        ),
                                      );
                                    }
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              // By default, show a loading spinner.
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: H*0.096,
                width: W*0.77,
                margin: EdgeInsets.only(left:  W*0.11, right: W*0.11, top: H*0.072-10),
                child: Card(
                  // shape: ShapeBorder.,
                  child: Center(
                    child: ListTile(
                      title: Text(
                        UserController.user.hasChallenge?
                         str_goToChallenge : str_createChallenge,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: fntAljazeera,
                          fontSize: W*0.057,// H*0.032,// W*0.057,
                          color: Colors.black,
                          height: 0.1
                        ),
                      ),
                      leading:  Image.asset('assets/images/back.png',scale: 5,),
                      onTap: () {                        
                          if(UserController.user.hasChallenge)
                            Navigator.of(context).pushNamed('/getCha');
                          else
                            Navigator.of(context).pushNamed('/createCha');
                      },
                    ),
                  ),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Container(
                height: H*0.096,
                width: W*0.77,
                margin: EdgeInsets.only(left:  W*0.11, right: W*0.11, top: 0.038*H),
                // margin: EdgeInsets.all(40.0),
                child: Card(
                  child: Center(
                    child: ListTile(
                      title: Text(
                        'العودة للرئيسية',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: fntAljazeera,
                          fontSize: W*0.057,// 24.0,
                          color: Colors.black,
                          height: 0.1
                        ),
                      ),
                      leading:  Image.asset('assets/images/back.png',scale: 5,),
                      onTap: () {
                                  Navigator.of(context).pushNamed('/home');
                                },
                    ),
                  ),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
