import 'package:flutter/material.dart';
import 'package:animation_director/animation_director.dart';

class Menu3x3 extends StatefulWidget {
  @override
  _Menu3x3State createState() => _Menu3x3State();
}

class _Menu3x3State extends State<Menu3x3> {

  double pageWidth;
  double pageHeight;
  String group = 'startUp';
  AnimationDirector aD;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {

    pageWidth = MediaQuery.of(context).size.width;
    pageHeight = MediaQuery.of(context).size.height;

    aD = AnimationDirector(
        repeatTimes: 1,
        speed: 1,
        autoStart: true,
        group: group,
        isCompleted: (isC){
          isCompleted = isC;
        },
        onCompleted: (int repeated, Duration runtime) {
          print("FINISHED - REPEATED $repeated in ${runtime.inMilliseconds}");
        },
        cast: [
          ActorWidget(name: 'Container', actions: [
            ActorAction(
              group: ['startUp', 'show'],
              position: ActorPosition(
                  bottom: 6,
                  right: 10,
                  duration: Duration(milliseconds: 0)),
              character: ActorCharacter(
                width: 50,
                height: 50,
                duration: Duration(milliseconds: 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            ActorAction(
                group: ['show'],
                character: ActorCharacter(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
                      border: Border.all(color: Colors.black12, width: 0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.decelerate),
                scale: ActorScale(
                    startScale: 1,
                    finishScale: 6,
                    alignment: Alignment.bottomRight,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic)),
            ActorAction(
              group: ['back'],
              position: ActorPosition(
                  bottom: 6,
                  right: 10,
                  duration: Duration(milliseconds: 500)),
              scale: ActorScale(startScale: 6, finishScale: 1,
                  alignment: Alignment.bottomRight,
                  curve: Curves.easeOutCubic,
                  duration: Duration(milliseconds: 300)),
              character: ActorCharacter(
                width: 50,
                height: 50,
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black54, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ]),

          ...app(
            name: 'App1',
            smallOffset: Offset(pageHeight - 65, pageWidth - 48),
            bigOffset: Offset(pageHeight - 300, pageWidth - 275),
            smallColor: Colors.blueAccent,
            bigIcon: Icons.home,
            bigText: 'Home',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 250),

          ),
          ...app(
            name: 'App2',
            smallOffset: Offset(pageHeight - 65, pageWidth - 38),
            bigOffset: Offset(pageHeight - 300, pageWidth - 185),
            smallColor: Colors.blue,
            bigIcon: Icons.add_circle,
            bigText: 'Add',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 300),
          ),
          ...app(
            name: 'App3',
            smallOffset: Offset(pageHeight - 65, pageWidth - 28),
            bigOffset: Offset(pageHeight - 300, pageWidth - 95),
            smallColor: Colors.blue,
            bigIcon: Icons.account_box,
            bigText: 'Account',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 350),
          ),
          ...app(
            name: 'App4',
            smallOffset: Offset(pageHeight - 57, pageWidth - 48),
            bigOffset: Offset(pageHeight - 220, pageWidth - 275),
            smallColor: Colors.blueAccent,
            bigIcon: Icons.ac_unit,
            bigText: 'Weather',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 250),
          ),
          ...app(
            name: 'App5',
            smallOffset: Offset(pageHeight - 57, pageWidth - 38),
            bigOffset: Offset(pageHeight - 220, pageWidth - 185),
            smallColor: Colors.blue,
            bigIcon: Icons.camera_alt,
            bigText: 'Camera',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 300),
          ),
          ...app(
            name: 'App6',
            smallOffset: Offset(pageHeight - 57, pageWidth - 28),
            bigOffset: Offset(pageHeight - 220, pageWidth - 95),
            smallColor: Colors.blue,
            bigIcon: Icons.assignment,
            bigText: 'Notes',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 350),
          ),
          ...app(
            name: 'App7',
            smallOffset: Offset(pageHeight - 49, pageWidth - 48),
            bigOffset: Offset(pageHeight - 140, pageWidth - 275),
            smallColor: Colors.blueAccent,
            bigIcon: Icons.edit,
            bigText: 'Edit',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 250),
          ),
          ...app(
            name: 'App8',
            smallOffset: Offset(pageHeight - 49, pageWidth - 38),
            bigOffset: Offset(pageHeight - 140, pageWidth - 185),
            smallColor: Colors.blue,
            bigIcon: Icons.group,
            bigText: 'Group',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 300),
          ),
          ...app(
            name: 'App9',
            smallOffset: Offset(pageHeight - 49, pageWidth - 28),
            bigOffset: Offset(pageHeight - 140, pageWidth - 95),
            smallColor: Colors.blue,
            bigIcon: Icons.room,
            bigText: 'Location',
            curve: Curves.easeOutSine,
            duration: Duration(milliseconds: 350),
          ),

          ActorWidget(name: 'StartClose', actions: [
            ActorAction(
                group: ['startUp', 'back'],
                position: ActorPosition(
                    bottom: 6,
                    right: 11,
                    duration: Duration(milliseconds: 0)),
                opacity:
                ActorOpacity(opacity: 1, duration: Duration(milliseconds: 0)),
                character: ActorCharacter(
                    width: 50,
                    duration: Duration(milliseconds: 0),
/*              decoration: BoxDecoration(
                color: Colors.black12
              ),*/
                    child: FlatButton(
                      padding: EdgeInsets.all(2),
                      splashColor: Colors.transparent,
                      onPressed: () {
                        if(isCompleted) {
                          group = 'show';
                          setState(() {

                          });
                        }

                      },
                      child: Container(
//                color: Colors.red,
                        width: 45,
                        height: 45,
                      ),
                    ))),
            ActorAction(
                waitBeforeStart: Duration(milliseconds: 300),
                group: ['show'],
                position: ActorPosition(
                    bottom: 6,
                    right: 11,
                    duration: Duration(milliseconds: 200)
                ),
                scale: ActorScale(startScale: 0, finishScale: 1,
                    curve: Curves.elasticOut,
                    alignment: Alignment.center, duration: Duration(milliseconds: 800)),
                opacity: ActorOpacity(opacity: 1),
                character: ActorCharacter(
                    width: 50,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      splashColor: Colors.transparent,
                      onPressed: () {
                        print("IC $isCompleted");
                        if(isCompleted) {
                          print("CLICKED");
                          group = 'back';
                          setState(() {

                          });
                        }
                      },
                      child: Center(
                        child: Container(
//                color: Colors.red,
                          child: Icon(
                            Icons.close,
                            size: 35,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    )))
          ]),
        ]
    );

    return aD;
  }
}


List<ActorWidget> app({
  String name,
  Color smallColor,
  Curve curve,
  Duration duration,
  Duration wait,
  Offset smallOffset,
  Offset bigOffset,
  IconData bigIcon,
  String bigText,
}) {
  return [
    ActorWidget(name: name, actions: [
      ActorAction(
          group: ['startUp', 'show'],
          waitBeforeStart: wait ?? Duration(milliseconds: 0),
          position: ActorPosition(
              top: smallOffset.dx,
              left: smallOffset.dy,
              duration: Duration(milliseconds: 50)),
          scale: ActorScale(
              startScale: 0.1,
              finishScale: 0.1,
              alignment: Alignment.topLeft,
              duration: Duration(milliseconds: 50)),
          character: ActorCharacter(
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ],
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                child: Icon(
                  bigIcon,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              duration: Duration(milliseconds: 0))),
      ActorAction(
        group: ['show'],
        position: ActorPosition(
            top: bigOffset.dx,
            left: bigOffset.dy,
            duration: duration ?? Duration(milliseconds: 300),
            curve: curve ?? Curves.linear),
        scale: ActorScale(
            startScale: 0.2,
            finishScale: 1,
            alignment: Alignment.topLeft,
            duration: Duration(milliseconds: 300)),
      ),
      ActorAction(
          group: ['back'],
          position: ActorPosition(
              top: smallOffset.dx,
              left: smallOffset.dy,
              duration: Duration(milliseconds: 200)),
          scale: ActorScale(
              startScale: 1,
              finishScale: 0.1,
              alignment: Alignment.topLeft,
              duration: Duration(milliseconds: 200)),
          character: ActorCharacter(
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ],
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                child: Icon(
                  bigIcon,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              duration: Duration(milliseconds: 0))),
    ]),
    ActorWidget(name: name + '-label', actions: [
      ActorAction(
        waitBeforeStart: Duration(milliseconds: 500),
        group: ['show'],
        scale: ActorScale(
            startScale: 0.1, finishScale: 1, curve: Curves.elasticOut,
          duration: Duration(milliseconds: 700)
        ),
        position: ActorPosition(
            top: bigOffset.dx + 55,
            left: bigOffset.dy,
            duration: Duration(milliseconds: 300)),
        character: ActorCharacter(
            width: 50,
            child: Center(
                child: Text(
                  bigText,
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ))),
      ),
      ActorAction(
          group: ['back'],
          scale: ActorScale(
              startScale: 1, finishScale: 0.0, curve: Curves.elasticOut),
          position: ActorPosition(
              top: bigOffset.dx + 55,
              left: bigOffset.dy,
              duration: Duration(milliseconds: 300)),
          )
    ]),
  ];
}

//
