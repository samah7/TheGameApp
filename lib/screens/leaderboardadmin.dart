import 'package:chronometer/widgets/tabBtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import'../controller/user_controller.dart';
import '../widgets/CapsulesAdm.dart';
import '../widgets/pointsAdm.dart';

class LeaderBoardAdmin extends StatefulWidget {
  LeaderBoardAdmin({Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return LeaderBoardAdminState();
  }
}

class LeaderBoardAdminState extends State<LeaderBoardAdmin>
    with TickerProviderStateMixin {


  TabController _controller;
  int _selectedIndex = 0;

  // List<bool> isInLeaderBoard;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2); 

    _controller.addListener(() {
      setState(() { 
        
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
    //isInLeaderBoard = List<bool>.generate(items.length, (int i) => false);
  }


  @override
  Widget build(BuildContext context) {
    var siz=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(          
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35.0),
                  bottomLeft: Radius.circular(35.0))),
          leading: new IconButton(
              icon: Image.asset('assets/images/back.png',scale:5), 
              onPressed: ()=>Navigator.of(context).popAndPushNamed('/home')),
          backgroundColor: Color(0xffEBEBEB),
          elevation: 0.0,
          title: Text(''),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: new Size(siz.width,  60.0),
            child: new Container(
              padding: EdgeInsets.only(bottom:siz.height*0.025, right: siz.width*0.065, left: siz.width*0.065),
              child: Theme(
                  data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
      
                child: TabBar(
                  labelPadding:EdgeInsets.only(right: 2.0, left: 2) ,
                  indicator: null,
                  controller: _controller,
                  labelStyle: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorColor: Colors.transparent,
                  labelColor: Color(0xff000000),
                  tabs: [
                    Tab(
                      child:tabBtn(' الكبسولات  ',context, _selectedIndex ==0)
                   ),
                    Tab(
                      child:tabBtn('نقاط التحدي',context,_selectedIndex == 1,),                     
                    ),
                  ],
                  onTap: (val) {
                   setState(() {
                     
                   });
                    print('$_controller.index $_selectedIndex', );
                  },
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
            controller: _controller,
            children: <Widget>[
              listCapsulesAdm(),
              listPointsAdm(),
            ]),

      ),


      // نقاط التحدي


    );
  }
}