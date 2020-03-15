import 'package:flutter/material.dart';
import 'package:animation_director/animation_director.dart';

class Dribble1SF extends StatefulWidget {
  @override
  _Dribble1SFState createState() => _Dribble1SFState();
}

class _Dribble1SFState extends State<Dribble1SF> {
  String group;

  @override
  void initState() {


    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return AnimationDirector(
        key: Key('Sa'),
        repeatTimes: 5,
        speed: 2,
        autoStart: true,
        group: group,
        onCompleted: (int repeated, Duration runtime) {
          print("FINISHED - REPEATED $repeated in ${runtime.inMilliseconds}");
        },
        cast: [
          ActorWidget(name: 'BG', actions: [
            ActorAction(
                character: ActorCharacter(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.white70),
                ))
          ]),
          ActorWidget(name: 'Cl1', actions: [
            ActorAction(position: ActorPosition(top: -200, left: 20)),
//              ActorAction(position: ActorPosition(top: -200, left: 20)),
            ActorAction(
//              waitBeforeStart: Duration(milliseconds: 200),
                position: ActorPosition(
                    top: -45,
                    left: 0,
                    curve: Curves.elasticOut,
                    duration: Duration(milliseconds: 1500)),
                character: ActorCharacter(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
//                      boxShadow: [BoxShadow(color: Colors.black, spreadRadius: 4, blurRadius: 3)],
                      color: Color(0xfff8f8f8)
                  ),
                  clipPath:
                  'M 0 130 C 60 160 70 270 150 360 C 240 440 300 380 400 510 L 400 0 L 0 0 Z PS 400 700',
                ))
          ]),
          ActorWidget(name: 'Cl2', actions: [
            ActorAction(position: ActorPosition(top: -100, left: 50)),
            ActorAction(
                waitBeforeStart: Duration(milliseconds: 50),
                position: ActorPosition(
                    top: -45,
                    left: 0,
                    curve: Curves.elasticOut,
                    duration: Duration(milliseconds: 2100)),
                character: ActorCharacter(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Color(0xfff0f0f0)),
                  clipPath:
                  'M 0 50 C 80 160 130 90 200 240 C 280 410 340 300 400 460 L 400 0 L 0 0 Z PS 400 700',
                ))
          ]),

        ActorWidget(
            name: 'Cl3',
            actions: [
          ActorAction(position: ActorPosition(top: -200, left: 100)),
          ActorAction(
              waitBeforeStart: Duration(milliseconds: 220),
              position: ActorPosition(
                  top: -45,
                  left: 0,
                  curve: Curves.elasticOut,
                  duration: Duration(milliseconds: 1700)),
              character: ActorCharacter(
                width: MediaQuery.of(context).size.width * 2,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Color(0xffe5e5e5)),
                clipPath:
                    'M 82 0 C 101.5 102 192 34 258 262 C 311 366.5 399 310 443 518 C 492 629 567 559 619 709 C 744 862 716 772 784 795 L 790 1 Z PS 400 700',
              ))
        ]),
        ActorWidget(
            name: 'Cl4',
            actions: [
           ActorAction(position: ActorPosition(left: -200)),
          ActorAction(
//              waitBeforeStart: Duration(milliseconds: 220),
              position: ActorPosition(
                  left: -40,
                  curve: Curves.elasticOut,
                  duration: Duration(milliseconds: 700)),
              character: ActorCharacter(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Color(0xffFBEBF5)),
                clipPath: 'M 0 410 C 100 490 310 470 230 700 L 0 700 Z PS 400 700',
              ))
        ]),
        ActorWidget(
            name: 'BxSh',
            actions: [
          ActorAction(position: ActorPosition(left: -100, top: MediaQuery.of(context).size.height + 100),
              character: ActorCharacter(
                width: MediaQuery.of(context).size.width + 200,
                height: 100,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 40.0, spreadRadius: 0.5)]
                ),
              )
          ),
          ActorAction(
            waitBeforeStart: Duration(milliseconds: 600),
            position: ActorPosition(
                top: MediaQuery.of(context).size.height - 70,
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 1600)),
          )
        ]),
          footerButton(
          name: 'Home',
          context: context,
            title: Icon(Icons.home, color: Colors.blue.withOpacity(0.7)), left: 0, startInMilliseconds: 500),
        footerButton(
          name: 'Notifications',
            context: context,
            title: Icon(Icons.notifications, color: Colors.blue.withOpacity(0.2),),
            left: MediaQuery.of(context).size.width / 5,
            startInMilliseconds: 350),
        footerButton(
          name: 'Add',
            context: context,
            title: Icon(Icons.add_circle, color: Colors.blue.withOpacity(0.2)),
            left: MediaQuery.of(context).size.width / 5 * 2,
            startInMilliseconds: 430),
        footerButton(
          name: 'Profile',
            context: context,
            title: Icon(Icons.person, color: Colors.blue.withOpacity(0.2)),
            left: MediaQuery.of(context).size.width / 5 * 3,
            startInMilliseconds: 650),
          footerButton(
            name: 'Apps',
              context: context,
              title: Icon(Icons.apps, color: Colors.blue.withOpacity(0.2)),
              left: MediaQuery.of(context).size.width / 5 * 4,
              startInMilliseconds: 650),


          ActorWidget(name: 'Title', actions: [
            ActorAction(
                position: ActorPosition(left: 0, top: 160),
                opacity: ActorOpacity(opacity: 0),
                character: ActorCharacter(
                  width: MediaQuery.of(context).size.width,
//                height: 100,
                  child: Center(
                      child: Text(
                        'App Title',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      )),
                )),
            ActorAction(
              opacity: ActorOpacity(opacity: 1, duration: Duration(milliseconds: 1000)),
            )
          ]),
          ActorWidget(name: 'Desc', actions: [
            ActorAction(
                position: ActorPosition(left: 0, top: 200),
                opacity: ActorOpacity(opacity: 0),
                character: ActorCharacter(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Here is a placeholder for your business description',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          Text(
                            'Tap to continue and find out more information',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      )),
                )),
            ActorAction(
              opacity: ActorOpacity(opacity: 1, duration: Duration(milliseconds: 1000)),
            )
          ]),

        ]);
  }
}


ActorWidget footerButton(
    {String name,
      BuildContext context,
      Widget title,
      double left,
      int startInMilliseconds}) {
  return ActorWidget(name: name, actions: [
    ActorAction(
        waitBeforeStart: Duration(milliseconds: startInMilliseconds),
        position: ActorPosition(
            top: MediaQuery.of(context).size.height + 100, left: left),
        character: ActorCharacter(
            width: MediaQuery.of(context).size.width / 5,
            height: 60,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(child: title))),
    ActorAction(
      position: ActorPosition(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 1000),
          top: MediaQuery.of(context).size.height - 80),
    ),
  ]);
}
