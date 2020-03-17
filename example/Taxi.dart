import 'package:flutter/material.dart';
import 'package:animation_director/animation_director.dart';

class TaxiAnimation extends StatefulWidget {
  @override
  _TaxiAnimationState createState() => _TaxiAnimationState();
}

class _TaxiAnimationState extends State<TaxiAnimation> {

  @override
  Widget build(BuildContext context) {
    return AnimationDirector(
      repeatTimes: 100,
      speed: 1,
      autoStart: true,
      onCompleted: (int repeated, Duration runtime) {
        print("FINISHED - REPEATED $repeated in ${runtime.inMilliseconds}");
      },
      cast: [
        ActorWidget(
            name: 'Taxi',
            actions: [
              ActorAction(
                position: ActorPosition(top: 85, left: 10),
                  character: ActorCharacter(
                    width: 170,
                    child: Image.asset('assets/images/taxi/taxi.png')
                  )
              ),
              ActorAction(
                  position: ActorPosition(top: 84.7),

              ),
              ActorAction(
                  position: ActorPosition(top: 85.3),
              )
            ]),

      ],
    );
  }
}




class Taxi extends StatefulWidget {
  @override
  _TaxiState createState() => _TaxiState();
}

class _TaxiState extends State<Taxi> {

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        AnimationDirector(
          repeatTimes: 1,
          speed: 1,
          autoStart: true,
          onCompleted: (int repeated, Duration runtime) {
            print("FINISHED - REPEATED $repeated in ${runtime.inMilliseconds}");
          },
          cast: [

            ActorWidget(
                name: 'Taxi',
                actions: [
                  ActorAction(
                      position: ActorPosition(top: 20, left: 0, right: 0),
                      opacity: ActorOpacity(opacity: 0),
                      character: ActorCharacter(
                          child: Center(child: Text('Taxi', style: TextStyle(fontSize: 75),))
                      )
                  ),
                  ActorAction(
                      waitBeforeStart: Duration(milliseconds: 1000),
                      opacity: ActorOpacity(opacity: 1),
                      position: ActorPosition(top: 190, duration: Duration(milliseconds: 800))
                  ),
                ]
            ),
            ActorWidget(
                name: 'Numbers',
                actions: [
                  ActorAction(
                      position: ActorPosition(top: 280, left: 0, right: 0),
                      opacity: ActorOpacity(opacity: 0),
                      character: ActorCharacter(
                          child: Center(child: Column(
                            children: <Widget>[
                              Text('+521 (xxx)-xxx-xx-xx', style: TextStyle(fontSize: 18),),
                              Text('+521 (xxx)-xxx-xx-xx', style: TextStyle(fontSize: 18),),
                            ],
                          ))
                      )
                  ),
                  ActorAction(
                      waitBeforeStart: Duration(milliseconds: 1500),
                      opacity: ActorOpacity(opacity: 1, duration: Duration(milliseconds: 800)),
                  ),
                ]
            ),
            ActorWidget(
                name: 'Sky',
                actions: [
                  ActorAction(
                      position: ActorPosition(top: 0, right: 0, left: 0),
                      character: ActorCharacter(
                          height: 180,
                          decoration: BoxDecoration(
                              color: Color(0xff1b1e23),
                          )
                      )
                  ),
                ]
            ),
            ActorWidget(
                name: 'Sun',
                actions: [
                  ActorAction(
                      position: ActorPosition(top: 130, right: 80),
                      opacity: ActorOpacity(opacity: 0),
                      character: ActorCharacter(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Color(0xfff8f8f8),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(color: Colors.white, spreadRadius: 3, blurRadius: 5)
                              ]
                          )
                      )
                  ),
                  ActorAction(
                    waitBeforeStart: Duration(milliseconds: 1200),
                    opacity: ActorOpacity(opacity: 1),
                    position: ActorPosition(top: 20,
                      curve: Curves.easeOutBack,
                      duration: Duration(milliseconds: 1000),),
                  ),
                ]
            ),
            ActorWidget(
              name: 'Road',
              actions: [
                ActorAction(
                    position: ActorPosition(top: 170, left: 10, right: 10),
                    character: ActorCharacter(
                        child: Image.asset('assets/images/taxi/road.png')
                    )
                ),
              ]
            ),
            fallingBuilding(
                name: 'Building1',
                image: 'building1',
                wait: 100,
                left: 80
            ),
            fallingBuilding(
                name: 'Building2',
              image: 'building2',
              wait: 400,
              left: 140,
              top: 63,
            ),

            ActorWidget(
                name: 'AnimateTaxi',
                actions: [
                  ActorAction(
                      position: ActorPosition(top: 0, right: -150),
                      character: ActorCharacter(
                          child: Container(
                              width: 100,
                              height: 100,
                              child: TaxiAnimation())
                      )
                  ),
                  ActorAction(
                    position: ActorPosition(
                        duration: Duration(milliseconds: 900),
                        right: 170),
                  )
                ]),
            ActorWidget(
                name: 'Bush1',
                actions: [
                  ActorAction(
                      position: ActorPosition(top: 120, right: 20),
                      scale: ActorScale(startScale: 0, finishScale: 0),
                      character: ActorCharacter(
                          height: 100,
                          child: Image.asset('assets/images/taxi/bush.png')
                      )
                  ),
                  ActorAction(
                    waitBeforeStart: Duration(milliseconds: 200),
                    scale: ActorScale(
                        duration: Duration(milliseconds: 1200),
                        curve: Curves.elasticOut,
                        startScale: 0, finishScale: 0.6, alignment: Alignment.center),
                  ),
                ]
            ),
            ActorWidget(
                name: 'Bush2',
                actions: [
                  ActorAction(
                      position: ActorPosition(top: 120, left: 20),
                      scale: ActorScale(startScale: 0, finishScale: 0),
                      character: ActorCharacter(
                          height: 100,
                          child: Image.asset('assets/images/taxi/bush.png')
                      )
                  ),
                  ActorAction(
                    waitBeforeStart: Duration(milliseconds: 600),
                    scale: ActorScale(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.decelerate,
                        startScale: 0, finishScale: 0.4, alignment: Alignment.center),
                  ),
                ]
            ),
            light(name: 'Light1', wait: 2000),
            light(name: 'Light2', wait: 2600),
            light(name: 'Light1', wait: 5000),
            light(name: 'Light2', wait: 5600),

          ],
        )
      ],
    );
  }


  ActorWidget light({
  String name,
    int wait
}) {
    return ActorWidget(
        name: name,
        actions: [
          ActorAction(
            waitBeforeStart: Duration(milliseconds: wait),
              position: ActorPosition(top: 88, left: 30),
              scale: ActorScale(startScale: 0, finishScale: 0),
              character: ActorCharacter(
                  height: 100,
                  child: Image.asset('assets/images/taxi/light.png')
              )
          ),
          ActorAction(
            scale: ActorScale(
                duration: Duration(milliseconds: 10),
                curve: Curves.decelerate,
                startScale: 0, finishScale: 0.5, alignment: Alignment.center),
          ),
          ActorAction(
            waitBeforeStart: Duration(milliseconds: 300),
            scale: ActorScale(
                duration: Duration(milliseconds: 10),
                curve: Curves.decelerate,
                startScale: 0.5, finishScale: 0, alignment: Alignment.center),
          ),
        ]
    );
  }

  ActorWidget fallingBuilding({
    String name,
    String image,
    int wait = 0,
    double left,
    double top = 48,

}) {
    return ActorWidget(
        name: name,
        actions: [
          ActorAction(
            waitBeforeStart: Duration(milliseconds: wait),
              position: ActorPosition(top: -200, left: left),
              character: ActorCharacter(
                  width: 150,
                  child: Image.asset('assets/images/taxi/${image}.png')
              )
          ),
          ActorAction(
            position: ActorPosition(top: top, duration: Duration(milliseconds: 1000),
                curve: Curves.bounceOut
            ),
          )
        ]);
  }
}
