import 'dart:async';

import 'package:mymission/Ressources/timer/bloc/timer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timer_screen_help.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:timer_builder/timer_builder.dart';
import '../widgets/alert.dart';
import '../Ressources/Ressources.dart';
import '../controller/function.dart';
import '../controller/user_controller.dart';

class TimerScreen extends StatefulWidget {
  @override
  TimerScreenstate createState() {
    return new TimerScreenstate();
  }
}

int totalCapsules = 0;

class TimerScreenstate extends State<TimerScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AppLifecycleState _notification;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }

  bool isRunning = false;
  bool isPaused = false;
  bool loadPrs = false;
  GlobalKey _keyRed = GlobalKey();

  int nbCbsl = 1;
  int nbCbslAtt = 0;
  Duration durInitial;
  int ordre = 0;
  String chrono;
  UserController db = UserController();
  String msgShow = '';
  String msgError = '';
  int x = 0;
  TimerBloc timerBloc;

  _getSizes() {
    final RenderBox renderBox = _keyRed.currentContext.findRenderObject();
    final size = renderBox.size;
    print("size of Red: $size");
    return size;
  }

  _getPositions() {
    final RenderBox renderBox = _keyRed.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    print("POSITION of Red: $position");
    return position;
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      var pos = _getPositions();
      var siz = _getSizes();
      var width = pos.dx + siz.width / 2;
      var height = pos.dy + siz.height / 2;
      if (!isRunning && !isPaused) {
        if (posy < height) {
          setState(() {
            vIcon = 'assets/images/auto1.png';
            durInitial = Duration(minutes: 25);
          });
          stopTimer(durInitial);
        } else if (posy <= (height) + 20 && posy >= (height) - 66) {
          if (posx <= (width) + 20 && posy >= (width) - 66) {
            setState(() {
              vIcon = 'assets/images/auto4.png';
              durInitial = Duration(minutes: 25 * 4);
            });
            stopTimer(durInitial);
          } else {
            setState(() {
              vIcon = 'assets/images/auto2.png';
              durInitial = Duration(minutes: 25 * 2);
            });
            stopTimer(durInitial);
          }
        } else {
          setState(() {
            vIcon = 'assets/images/auto3.png';
            durInitial = Duration(minutes: 25 * 3);
          });
          stopTimer(durInitial);
        }

        Vibration.vibrate(pattern: [
          50,
          90,
          100,
        ], intensities: [
          128,
          25,
          64
        ]);
      }
      duration = Duration(minutes: valueCpl * nbCbsl);
      durInitial = duration;
      print('height: ${height} , ${width} pos:$posx, $posy');
    });
  }

  double posx = 100.0;
  double posy = 100.0;
  var vIcon = 'assets/images/auto1.png';
  Widget widGres(BuildContext context) {
    return GestureDetector(
      key: _keyRed,
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: Container(
        padding: EdgeInsets.all(0),
        // margin: EdgeInsets.only(left:3),
        child: Image.asset(
          vIcon,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Duration duration;
  Duration durInitstable;
  Timer t;
  var dispoded = false;
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    dispoded = true;
    isRunningInBack = isRunning;
    if (isRunning) {
      durGlobal = Duration(seconds: duration.inSeconds);
      durInitGlobal = Duration(seconds: durInitial.inSeconds);
    } else {
      durGlobal = Duration(seconds: 0);
      durInitGlobal = Duration(seconds: 0);
    }

    t?.cancel();
    super.dispose();
  }

  initState() {
    WidgetsBinding.instance.addObserver(this);
    if (durGlobal.inSeconds == 0) {
      durInitial = Duration(minutes: 25);
    } else {
      /*      SystemChannels.lifecycle.setMessageHandler((msg) {

            if (msg == AppLifecycleState.paused.toString() ) {
              // On AppLifecycleState: paused
             // durGlobal.inSeconds =BlocProvider.of<TimerBloc>(context).currentState.duration ?? 0;
              if(isRunning)
                durGlobal = Duration(seconds:duration.inSeconds);
              else durGlobal = Duration(seconds:0);
              timerHandler.setEndingTime(durGlobal.inSeconds);
              setState((){});
            }

            if (msg == AppLifecycleState.resumed.toString() ) {
              // On AppLifecycleState: resumed
             /* BlocProvider.of<TimerBloc>(context).dispatch(
                Start(
                  duration: timerHandler.remainingSeconds,
                ),
              );*/
              
              durGlobal = Duration(seconds: timerHandler.remainingSeconds);
              setState((){});
            }            
           // return;
          });*/

      durInitial = Duration(minutes: 25);
    }
    isRunning = true;
    timerBloc = BlocProvider.of<TimerBloc>(context);
    timerBloc.duration = durInitial.inSeconds;
    timerBloc.add(
      TimerStarted(
        duration: durInitial.inSeconds,
      ),
    );
    if (!dispoded) initialize();

    t = Timer.periodic(
      Duration(minutes: 1),
      (_) {
        isLoadActive();
      },
    );
    super.initState();
  }

  initialize() async {
    await getRank();
    await getChallenge();
    await readCpls();
    isLoadActive();
    return true;
  }

  isLoadActive() {
    setState(() {
      loadPrs = nbCblG == 0 || !db.isLoadActive();
    });
  }

  getRank() async {
    int val = await db.getRank();
    setState(() {
      ordre = val;
    });
  }

  getChallenge() async {
    int val = await db.nbCplgetChallenge();
    setState(() {
      nbCbslAtt = val;
    });
  }

  readCpls() async {
    int val = await db.readCbl();
    setState(() {
      nbCblG = val;
    });
  }

//PAUSE FUNCTION
  pauseTimer() async {
    if (isRunning) {
      setState(() {
        timerBloc.add(TimerPaused());
        isRunning = false;
      });
    } else {
      setState(() {
        timerBloc.add(TimerResumed());
        isRunning = true;
      });
    }
  }

  bool stoped = false;
  //STOP TIMER
  stopTimer(Duration resetDuration) async {
    switch (stoped) {
      case false:
        {
          setState(() {
            isRunning = false;
            stoped = true;
            print("duration in stopTimer fun : ${resetDuration.inSeconds}");
            timerBloc.add(TimerReset(duration: resetDuration));
          });
        }
        break;
      case true:
        {
          setState(() {
            isRunning = true;
            stoped = false;
            timerBloc.add(
              TimerStarted(duration: durInitial.inSeconds),
            );
          });
        }
    }
  }

  getTime() {
    var time = DateTime.now();
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  //LOAD CAPSULSE
  loadCapsules(BuildContext context) async {
    louseFocus(context);

    setState(() {
      loadPrs = true;
    });

    Future.delayed(
      const Duration(seconds: 1),
    ).then((_) async {
      msgShow = '';
      msgError = '';
      try {
        setState(() {
          msgError = '';
        });
        var response =
            await db.addDayCapsules(totalCapsules); //lalla@seba_123.com
        print('response register: ${totalCapsules}');
        if (!response)
          setState(() {
            msgError = db.rsponseMsg.replaceAll('{', '').replaceAll('[', '');
            msgError = msgError.replaceAll('}', '').replaceAll(']', '');
          });
      } catch (e) {
        db.saveCpsl(nbCblG).then(() {});
        msgError = err_errVerify;
      }

      setState(() {
        loadPrs = false;
      });

      if (!dispoded) await initialize();
      Vibration.vibrate(
          pattern: [50, 150, 100, 500], intensities: [128, 255, 64, 255]);
      if (msgError.trim() != '') {
        setState(() {
          msgShow = msgError;
        });
        await Future.delayed(Duration(seconds: 3)).then((_) {
          setState(() {
            msgShow = '';
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    cxt_contextTimer = context;

    double vide = MediaQuery.of(context).size.height * 0.15;
    double bfCrono = MediaQuery.of(context).size.height * 0.036;
    double arCrono = MediaQuery.of(context).size.height * 0.08;
    double arAuto = MediaQuery.of(context).size.height * 0.015;
    double W = MediaQuery.of(context).size.width;
    double hCircle = MediaQuery.of(context).size.width * 0.7;
    double fntChrono = W * 0.097;
    if (fntChrono > 40) fntChrono = 40;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: bfCrono),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width, //320,
              ////container contnent
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: <Widget>[
                              Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(0),
                                      margin: EdgeInsets.only(top: vide),
                                      width: hCircle,
                                      height: hCircle,
                                      child: Stack(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/circle.png',
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: TimerText(),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 2, bottom: 35),
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Image.asset(
                                                'assets/images/field.png',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 3,
                                              bottom: 31,
                                            ),
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: CapsulesText(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 62,
                                left: MediaQuery.of(context).size.width - 45,
                                child: IconButton(
                                  icon: Icon(Icons.info_outline,
                                      color: Colors.grey[500], size: 28),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TimerScreenHelp(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                  top: 62,
                                  left: 5,
                                  child: IconButton(
                                    icon: Image.asset(
                                      'assets/images/back.png',
                                      scale: 5,
                                    ), //Icon(Icons.keyboard_backspace, size:28),
                                    onPressed: () {
                                      if (Navigator.of(context).canPop())
                                        Navigator.of(context)
                                            .popAndPushNamed('/home');
                                      else
                                        Navigator.of(context)
                                            .pushNamed('/home');
                                    },
                                  )),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: arCrono)),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
                                    padding: EdgeInsets.all(0),
                                    shape: CircleBorder(),
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      margin: EdgeInsets.all(0),
                                      width: MediaQuery.of(context).size.width *
                                          0.22,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.22,
                                      child: Center(
                                          child: Image.asset(
                                        'assets/images/btnStop.png',
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                    onPressed: () => stopTimer(durInitial)),
                                Container(
                                  //color: Colors.red,
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  height:
                                      MediaQuery.of(context).size.width * 0.33,
                                  margin: EdgeInsets.only(
                                    left: 5,
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Center(child: widGres(context)),
                                ),
                                MaterialButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  padding: EdgeInsets.all(0),
                                  shape: CircleBorder(),
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    margin: EdgeInsets.all(0),
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                    height: MediaQuery.of(context).size.width *
                                        0.22, //90,height: 90,
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: AnimatedOpacity(
                                            opacity: isRunning ? 0 : 1,
                                            duration: Duration(seconds: 2),
                                            child: Image.asset(
                                              'assets/images/btnRun.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: AnimatedOpacity(
                                            opacity: isRunning ? 1 : 0,
                                            duration: Duration(seconds: 2),
                                            child: Image.asset(
                                              'assets/images/btnPause.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () => pauseTimer(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: arAuto),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 3,
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              padding: EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width * 0.165,
                              height: MediaQuery.of(context).size.height *
                                  0.064, // 70,height: 70,
                              decoration: BoxDecoration(
                                  //color: Colors.red,
                                  image: DecorationImage(
                                      image: AssetImage(loadPrs
                                          ? 'assets/images/loadPressed.png'
                                          : 'assets/images/load.png'),
                                      fit: BoxFit.cover)),
                              child: !loadPrs
                                  ? InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTapCancel: () {
                                        setState(() {
                                          loadPrs = true;
                                        });
                                      },
                                      onLongPress: () {
                                        setState(() {
                                          loadPrs = false;
                                        });
                                      },
                                      onTapDown: (val) {
                                        setState(() {
                                          loadPrs = true;
                                          print('hiiiiiiiiii onTapDown');
                                        });
                                      },
                                      onTap: () => loadCapsules(context),
                                    )
                                  : Text(
                                      '',
                                      style: TextStyle(fontSize: 0),
                                    ),
                            ),
                          ),
                        ]
                        //               ],
                        ),
                  ],
                ),
              )),
          Container(
            height: 82,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 8, right: 8, top: 28),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 4,
                      color: Colors.grey[300],
                      // offset: Offset(0.0, 30.0), //(x,y)
                      blurRadius: 5.0)
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 70,
                  child: Text("الترتيب\n${ordre ?? ''}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: fntAljazeera, fontSize: 17, height: 1.3)),
                ),
                TimerBuilder.periodic(Duration(minutes: 1), builder: (conetxt) {
                  /* db.isLoadActive().then((val){
                              loadPrs = !val;
                            });*/
                  return Text("${getTime()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: fntAljazeera, fontSize: 20, height: 1.4));
                }),
                Container(
                  width: 70,
                  child: Text('الرصيد\n$nbCbslAtt',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: fntAljazeera, fontSize: 17, height: 1.3)),
                ),
              ],
            ),
          ),
          msgShow.trim() == ''
              ? Text('')
              : alertMsg(context, msgShow, marge: 293),
        ],
      ),
    );
  }
}

class TimerHandler {
  DateTime _endingTime;

  TimerHandler._privateConstructor();
  TimerHandler();

  static final TimerHandler _instance = new TimerHandler();
  static TimerHandler get instance => _instance;

  int get remainingSeconds {
    final DateTime dateTimeNow = new DateTime.now();
    Duration remainingTime = _endingTime.difference(dateTimeNow);
    // Return in seconds
    return remainingTime.inSeconds;
  }

  void setEndingTime(int durationToEnd) {
    final DateTime dateTimeNow = new DateTime.now();

    // Ending time is the current time plus the remaining duration.
    this._endingTime = dateTimeNow.add(
      Duration(
        seconds: durationToEnd,
      ),
    );
  }
}

final timerHandler = TimerHandler.instance;

class TimerText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TimerBloc>().state;
    final hoursStr =
        ((state.duration / 3600) % 60).floor().toString().padLeft(2, '0');
    final minutesStr =
        ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (state.duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$hoursStr:$minutesStr:$secondsStr',
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.097,
        fontFamily: fntAljazeera,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CapsulesText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TimerBloc>().state;
    totalCapsules = totalCapsules + state.capsules;
    return Text(
      '${totalCapsules}',
      style: TextStyle(
        fontSize: 14,
        fontFamily: fntAljazeera,
      ),
    );
  }
}
