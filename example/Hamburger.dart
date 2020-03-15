import 'package:flutter/material.dart';
import 'package:animation_director/animation_director.dart';

class Hamburger extends StatefulWidget {
  @override
  _HamburgerState createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {

  Paint progressPaint;

  @override
  void initState() {

    progressPaint = Paint()
      ..strokeWidth = 8.0
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..blendMode = BlendMode.softLight;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationDirector(
      repeatTimes: 1,
      speed: 1,
      autoStart: true,
      onCompleted: (int repeated, Duration runtime) {
        print("FINISHED - REPEATED $repeated in ${runtime.inMilliseconds}");
      },
      cast: [
/*          ActorWidget(
                actions: [
                  ActorAction(
                    container: ActorContainer(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.7)
                      )
                    )
                  )
                ]
              ),*/
        ActorWidget(
            name: '1',
            actions: [
              ActorAction(
                  position: ActorPosition(top: 100, left: -400),
                  container: ActorContainer(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(200)))),
              ActorAction(
                position: ActorPosition(
                    top: 100,
                    left: -230,
                    duration: Duration(milliseconds: 1300),
                    curve: Curves.elasticOut),
              ),
              ActorAction(
                waitBeforeStart: Duration(milliseconds: 1500),
                position: ActorPosition(
                    top: 100,
                    left: -500,
                    duration: Duration(milliseconds: 1300),
                    curve: Curves.elasticOut),
              )
            ]),
        ActorWidget(
            name: '2',
            actions: [
              ActorAction(
                  waitBeforeStart: Duration(milliseconds: 3000),
                  position: ActorPosition(
                      top: 0, left: -MediaQuery.of(context).size.width/2),
                  container: ActorContainer(
                      width: MediaQuery.of(context).size.width/2,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(color: Colors.deepPurple))),
              ActorAction(
                  position: ActorPosition(
                      left: 0,
                      curve: Curves.easeOutCubic,
                      duration: Duration(milliseconds: 600))),
              ActorAction(
                  container: ActorContainer(
                      decoration: BoxDecoration(
                          color: Color(0xff077D19)
                      ),
                      curve: Curves.decelerate,
                      duration: Duration(milliseconds: 3000)))
            ]),
        optionCircle(
            traversePercentage: 80,
            pathCurve: Curves.linearToEaseOut,
            pathDuration: Duration(milliseconds: 600),
            waitBefore: Duration(seconds: 1),
            rotateDuration: Duration(milliseconds: 1000),
            rotationTurn: 0,
            image: 'food4'),
        optionCircle(
            traversePercentage: 60,
            pathCurve: Curves.linearToEaseOut,
            pathDuration: Duration(milliseconds: 800),
            waitBefore: Duration(seconds: 1),
            rotateDuration: Duration(milliseconds: 1300),
            rotationTurn: 1,
            image: 'food1'),
        optionCircle(
            traversePercentage: 42,
            pathCurve: Curves.linearToEaseOut,
            pathDuration: Duration(milliseconds: 1000),
            waitBefore: Duration(seconds: 1),
            rotateDuration: Duration(milliseconds: 1200),
            image: 'food3'),
        optionCircle(
            traversePercentage: 20,
            pathCurve: Curves.linearToEaseOut,
            pathDuration: Duration(milliseconds: 1200),
            waitBefore: Duration(seconds: 1),
            rotateDuration: Duration(milliseconds: 1500),
            image: 'food2'),
        itemText(
          curve: Curves.decelerate,
          duration: Duration(milliseconds: 1000),
          top: 130,
          title: 'Hamburger',
          waitBefore: Duration(milliseconds: 3000),
        ),
        itemText(
          curve: Curves.decelerate,
          duration: Duration(milliseconds: 1000),
          top: 230,
          title: 'Fried Egg',
          waitBefore: Duration(milliseconds: 3100),
        ),
        itemText(
          curve: Curves.decelerate,
          duration: Duration(milliseconds: 1000),
          top: 340,
          title: 'Chicken',
          waitBefore: Duration(milliseconds: 3200),
        ),
        itemText(
          curve: Curves.decelerate,
          duration: Duration(milliseconds: 1000),
          top: 440,
          title: 'Sausage',
          waitBefore: Duration(milliseconds: 3300),
        ),
        /*ActorWidget(
                name: '3',
                actions: [
              ActorAction(
                  position: ActorPosition(
                    top: MediaQuery.of(context).size.height,
                    left: 0,
                  ),
                  container: ActorContainer(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(color: Color(0xfffbe9e9)),
                      clipPath:
                      'M 0 400 L 400 400 L 400 50 L 350 30 L 310 50 L 270 10 L 250 40 L 230 30 L 190 30 L 170 20 L 130 20 L 120 50 L 100 60 L 60 40 L 40 20 L 20 30 L 0 20 Z')),
              ActorAction(
                  waitBeforeStart: Duration(seconds: 4),
                  position: ActorPosition(
                      top: MediaQuery.of(context).size.height - 200,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeOut))
            ]),*/
/*            ActorWidget(
                name: '4',
                actions: [
              ActorAction(
                  position: ActorPosition(
                    top: MediaQuery.of(context).size.height - 200,
                    left: 0,
                  )),
              ActorAction(
                  waitBeforeStart: Duration(seconds: 5),
                  path: ActorPath(
                      displayProgress: true,
                      progressStyle: progressPaint,
                      progressLength: 400,
                      path:
                      'M 310 50 L 270 10 L 250 40 L 230 30 L 190 30 L 170 20 L 130 20 L 120 50 L 100 60 L 60 40 L 40 20 L 20 30 L 0 20 ',
                      duration: Duration(seconds: 5)))
            ]),
            ActorWidget(
                name: '5',
                actions: [
              ActorAction(
                  position: ActorPosition(
                    top: 20,
                    left: 8,
                  ),
                  container: ActorContainer(
                      height: 200,
                      width: 300,
                      child: Text(
                        "Burgershop",
                        style: TextStyle(fontSize: 55,
                          color: Colors.greenAccent,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.white.withOpacity(0.5),
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                        ),

                      )),
                  opacity: ActorOpacity(opacity: 0)),
              ActorAction(
                  waitBeforeStart: Duration(milliseconds: 5000),
                  opacity: ActorOpacity(
                      opacity: 1, duration: Duration(milliseconds: 3000)))
            ]),
            ActorWidget(
                name: '6',
                actions: [
              ActorAction(
                position: ActorPosition(
                  top: MediaQuery.of(context).size.height - 120,
                  left: -300,
                ),
                container: ActorContainer(
                    height: 200,
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "The best burgershop in the country!",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        Text(
                          "Visit us and taste our burgers...",
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    )),
              ),
              ActorAction(
                  waitBeforeStart: Duration(milliseconds: 5000),
                  position: ActorPosition(
                    left: 20,

                  ))
            ])*/
      ],
    );
  }

  ActorWidget itemText(
      {Curve curve,
        Duration duration,
        Duration waitBefore,
        String title,
        double top}) {
    return ActorWidget(
        name: title,
        actions: [
          ActorAction(
            waitBeforeStart: waitBefore,
            position: ActorPosition(left: -200, top: top),
            container: ActorContainer(
                width: 200,
                height: 100,
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white70, fontSize: 25),
                )),
          ),
          ActorAction(
              position: ActorPosition(
                  left: 30,
                  curve: Curves.elasticOut,
                  duration: Duration(milliseconds: 2000)))
        ]);
  }

  ActorWidget optionCircle(
      {int traversePercentage,
        Curve pathCurve,
        Duration pathDuration,
        Duration waitBefore,
        Duration rotateDuration,
        double rotationTurn = 1.0,
        String image}) {
    return ActorWidget(
        name: image,
        actions: [
          ActorAction(
              waitBeforeStart: waitBefore - Duration(milliseconds: 500),
              path: ActorPath(
                  displayPath: false,
                  traversePercentage: traversePercentage,
                  path: 'M -30 100 A 1 1 0 0 1 -30 500 ',
                  curve: pathCurve,
                  duration: pathDuration),
              container: ActorContainer(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/' + image + '.png')),
              rotation: ActorRotation(
                  rotationTurns: rotationTurn,
//            clockwise: false,
//              horizontalFlipTurns: 1.0,
                  startTween: 0.6,
                  duration: rotateDuration,
                  curve: Curves.elasticOut)),
          ActorAction(
              position: ActorPosition(
                  left: 210,
                  curve: Curves.elasticOut,
                  duration: Duration(milliseconds: 2000)))
        ]);
  }
}


