import 'package:flutter/material.dart';
import 'package:animation_director/animation_director.dart';

class FastFood extends StatefulWidget {
  @override
  _FastFoodState createState() => _FastFoodState();
}

class _FastFoodState extends State<FastFood> {
  String group;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationDirector(
        repeatTimes: 1,
        speed: 2,
        autoStart: true,
        group: group,
        onCompleted: (int repeated, Duration runtime) {
          print("FINISHED - REPEATED $repeated in ${runtime.inMilliseconds}");
        },
        cast: [
          ...background(context: context),
          title(context: context),
          redBackground(context: context),
          ...food(
              name: 'Chicken',
              title: 'Chicken',
              wait: 0,
              description: 'Some description for this delicious burger',
              image: 'food1'),
          ...food(
              name: 'Burger',
              title: 'Burger',
              wait: 2200,
              description: 'Some description for this delicious burger',
              image: 'food2'),
          ...food(
              name: 'Fried Egg',
              title: 'Fried Egg',
              wait: 4200,
              description: 'Some description for this delicious burger',
              image: 'food3'),
          ...food(
              name: 'Sausage',
              title: 'Sausage',
              wait: 6200,
              description: 'Some description for this delicious burger',
              image: 'food4'),
          start(),
        ]);
  }
}

ActorWidget title({BuildContext context}) {
  return
    ActorWidget(name: 'Title', actions: [
      ActorAction(
          waitBeforeStart: Duration(milliseconds: 8400),
          position: ActorPosition(
            bottom: -100,
            left: 0,
            right: 0,
          ),
          container: ActorContainer(
              child: Center(
                child: Text("Mr FastFood",
                  style: TextStyle(fontSize: 40),),
              ))),
      ActorAction(
        position: ActorPosition(
            bottom: MediaQuery.of(context).size.height - 200,
            duration: Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn),
      )
    ])
  ;
}

ActorWidget start() {
  return
    ActorWidget(name: 'StartBtn', actions: [
      ActorAction(
          waitBeforeStart: Duration(milliseconds: 8200),
          position: ActorPosition(
            bottom: -100,
            left: 0,
            right: 0,
          ),
          container: ActorContainer(
              child: Center(
            child: MaterialButton(
              height: 100,
              minWidth: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(100.0)),
              color: Colors.white,
              textColor: Colors.blueAccent,
              onPressed: () {},
              child: Text("Start", style: TextStyle(fontSize: 20),),
            ),
          ))),
      ActorAction(
        position: ActorPosition(
            bottom: 100,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn),
      )
    ])
  ;
}

List<ActorWidget> background({BuildContext context}) {
  return [
    ActorWidget(name: 'BackgroundBlue', actions: [
      ActorAction(
        position: ActorPosition(
          top: MediaQuery.of(context).size.height,
          left: 0,
          right: 0,
        ),
      ),
      ActorAction(
          position: ActorPosition(
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
            top: 0,
            left: 0,
            right: 0,
          ),
          container: ActorContainer(
              height: MediaQuery.of(context).size.height,
              decoration:
                  BoxDecoration(color: Colors.white)))
    ]),

  ];
}

ActorWidget redBackground({BuildContext context}) {
  return ActorWidget(name: 'BackgroundWhite', actions: [
    ActorAction(
        waitBeforeStart: Duration(milliseconds: 7500),
        position: ActorPosition(
          top: MediaQuery.of(context).size.height,
          left: 0,
          right: 0,
        ),
        scale: ActorScale(startScale: 0, finishScale: 0),
        container: ActorContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20)))),
    ActorAction(
        position: ActorPosition(
          duration: Duration(milliseconds: 350),
          curve: Curves.decelerate,
          top: 300,
          left: 0,
          right: 0,
        ),
        scale: ActorScale(
            startScale: 0,
            finishScale: 2.5,
            alignment: Alignment.topCenter,
            duration: Duration(milliseconds: 2100),
            curve: Curves.elasticOut),
        container: ActorContainer(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(200)))),
  ]);
}

List<ActorWidget> food(
    {String name, String title, String description, int wait, String image}) {

  print("assets/images/${image}.png");

  return [
    ActorWidget(name: name, actions: [
      ActorAction(
          waitBeforeStart: Duration(milliseconds: wait),
          path: ActorPath(
              path: 'M -70 350 A 70 50 0 1 1 470 350 PS W400 H700',
//                  displayPath: true,
              traversePercentage: 50,
              curve: Curves.easeOutBack,
              duration: Duration(milliseconds: 500)),
          container: ActorContainer(
              width: 100,
              height: 100,
decoration: BoxDecoration(color: Colors.blue)
//              child: Image.asset('assets/images/${image}.png'),
          )),
      ActorAction(
          waitBeforeStart: Duration(milliseconds: 1000),
          path: ActorPath(
              path: 'M -70 350 A 70 50 0 1 1 470 350 PS H700 W400 ',
//                      displayPath: true,
              startPositionInPercent: 50,
              traversePercentage: 100,
              curve: Curves.elasticOut,
              duration: Duration(milliseconds: 2000)))
    ]),
    ActorWidget(name: '${name}Title', actions: [
      ActorAction(
          waitBeforeStart: Duration(milliseconds: wait),
          position: ActorPosition(top: 180, left: 0, right: 0),
          container: ActorContainer(
              width: 100,
              child: Center(
                  child: Text(
                title,
                style: TextStyle(fontSize: 35),
              ))),
          scale: ActorScale(startScale: 0, finishScale: 0)),
      ActorAction(
        scale: ActorScale(
            alignment: Alignment.center,
            startScale: 0,
            finishScale: 1,
            curve: Curves.elasticOut,
            duration: Duration(milliseconds: 600)),
      ),
      ActorAction(
          waitBeforeStart: Duration(milliseconds: 200),
          scale: ActorScale(
              alignment: Alignment.center,
              startScale: 1,
              finishScale: 0,
              curve: Curves.easeInQuart,
              duration: Duration(milliseconds: 800))),
    ]),
    ActorWidget(name: '${name}Description', actions: [
      ActorAction(
          waitBeforeStart: Duration(milliseconds: wait),
          position: ActorPosition(right: 0, left: 0, top: 250),
          scale: ActorScale(startScale: 0, finishScale: 0)),
      ActorAction(
          waitBeforeStart: Duration(milliseconds: 100),
          container: ActorContainer(
              child: Center(
            child: Container(width: 220, child: Text(description)),
          )),
          scale: ActorScale(
              alignment: Alignment.center,
              startScale: 0,
              finishScale: 1,
              curve: Curves.elasticOut,
              duration: Duration(milliseconds: 1100))),
      ActorAction(
          scale: ActorScale(
              alignment: Alignment.center,
              startScale: 1,
              finishScale: 0,
              curve: Curves.easeInQuart,
              duration: Duration(milliseconds: 400))),
    ])
  ];
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
        container: ActorContainer(
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
