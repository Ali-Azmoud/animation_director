import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

//import 'package:flutter/physics.dart';
import 'package:flutter/animation.dart';

AnimationConfig _globalAnimationConfig =
AnimationConfig(duration: Duration(milliseconds: 50), curve: Curves.linear);

double screenWidth;
double screenHeight;

class AnimationDirector extends StatefulWidget {
  final Key key;
  final List<ActorWidget> cast;
  final Function(int repeated, Duration runtime) onCompleted;
  final int repeatTimes;
  final bool autoStart;
  final double speed;
  final String group;
  final bool clear;
  final Function(bool isCompleted) isCompleted;

  AnimationDirector({this.key,
    this.cast,
    this.onCompleted,
    this.repeatTimes = 1,
    this.autoStart = false,
    this.speed = 1,
    this.group,
    this.clear = true,
    this.isCompleted})
      : assert(speed != null && speed > 0 && speed <= 10),
        assert(repeatTimes != null && repeatTimes >= 1),
        assert(autoStart != null),
        assert(cast != null && cast.length > 0);

  @override
  _AnimationDirectorState createState() => _AnimationDirectorState();
}

class _AnimationDirectorState extends State<AnimationDirector>
    with TickerProviderStateMixin {
  int _allActions = 0;
  int _completedActions = 0;
  List<WidgetDirectorItem> _widgetsArray = [];
  int _repeatedTimes = 0;
  double _speedFactor = 1;
  DateTime _startTime = DateTime.now();
  String _group;
  List<ActorWidget> cast = [];
  Map<String, Widget> _actorsLastSnapshot = {};
  Map<String, SnapShotActorAction> _actorsWidgetStates = {};
  bool _freshStart = true;
  Timer cif;

  checkIfAllActionsCompleted() async {
    if (_completedActions == _allActions) {
      _freshStart = false;
      _repeatedTimes++;

      DateTime finishTime = DateTime.now();

      if (widget.onCompleted != null)
        widget.onCompleted(_repeatedTimes, finishTime.difference(_startTime));

      if (_repeatedTimes < widget.repeatTimes && widget.group == null) {
        _freshStart = true;
        initialize(repeat: true);
      }
    }
  }

  checkIfFinished() {
    if (widget.isCompleted != null) {
      cif = Timer.periodic(Duration(milliseconds: 500), (_) {
        widget.isCompleted(_completedActions == _allActions);
      });
    }
  }

  @override
  void initState() {
    checkIfFinished();

//    _countAllActions();

    super.initState();

//    initialize();
  }

  @override
  void didUpdateWidget(AnimationDirector oldWidget) {
    initialize();
    super.didUpdateWidget(oldWidget);
  }

  initialize({bool repeat = false}) {
    _group = widget.group;
    cast = widget.cast;

    _speedFactor = 1 / widget.speed;

    if (widget.autoStart || repeat) _startAnimate();
  }

  _startAnimate([String groupName]) {
    if (_completedActions == _allActions || _completedActions == 0) {
      _completedActions = 0;

      if (this.mounted) {
        _speedFactor = 1 / widget.speed;

        if (groupName != null) {
          _group = groupName;
        }

        _countAllActions();

        _generateWidgets();
      }
    }
  }

  _countAllActions() {
    _allActions = 0;
    for (ActorWidget aw in cast) {
      _allActions += aw.actions.length;
    }
  }

  _addToActions(int addedActions) {
    _allActions += addedActions;
  }

  @override
  Widget build(BuildContext context) {
    if (screenHeight == null) {
      screenHeight = MediaQuery
          .of(context)
          .size
          .height;
      screenWidth = MediaQuery
          .of(context)
          .size
          .width;
    }

    return Stack(
      overflow: Overflow.clip,
      children: _widgetsArray,
    );
  }

  _generateWidgets() async {
    _widgetsArray = [];

    String randomNumber;

    for (ActorWidget actorWidget in cast) {
      randomNumber = _randomKey();

      _actorsWidgetStates[actorWidget.name] ??= SnapShotActorAction(
          position: ActorPosition(),
          container: ActorContainer(
              decoration: BoxDecoration(color: Colors.transparent)),
          scale: ActorScale());
      _widgetsArray.add(WidgetDirectorItem(
          actorsLastSnapshot: (aw) {
            return _actorsLastSnapshot[aw.name];
          },
          updateActorsLastSnapshot: (aw, ap) {
            _actorsLastSnapshot[aw.name] = ap;
          },
          actorsWidgetStates: (aw) {
            return _actorsWidgetStates[aw.name];
          },
          updateActorsWidgetStates: (aw, snapshot) {
            _actorsWidgetStates[aw.name] = snapshot;
          },
          adGroup: () {
            return _group;
          },
          adFreshStart: () {
            return _freshStart;
          },
          adCompletedActions: () {
            return _completedActions;
          },
          adAllActions: () {
            return _allActions;
          },
          adPlusCompletedActions: () {
            _completedActions++;
          },
          adSpeedFactor: () {
            return _speedFactor;
          },
          adAddToActions: (addedActions) {
            _addToActions(addedActions);
          },
          checkIfAllActionsCompleted: () {
            return checkIfAllActionsCompleted();
          },
          actorWidget: actorWidget,
          key: Key('Key' + randomNumber),
          snapshotKey: _widgetsArray.length));
    }
    setState(() {});
  }

  @override
  void dispose() {
    cif.cancel();
    super.dispose();
  }
}

class WidgetDirectorItem extends StatefulWidget {
  final ActorWidget actorWidget;
  final Key key;
  final int snapshotKey;
  final Function adGroup;
  final Function adFreshStart;
  final Function adCompletedActions;
  final Function adAllActions;
  final Function adPlusCompletedActions;
  final Function adSpeedFactor;
  final Function(ActorWidget aw) actorsLastSnapshot;
  final Function(ActorWidget aw, AnimatedPositioned ap)
  updateActorsLastSnapshot;
  final Function(ActorWidget aw) actorsWidgetStates;
  final Function(ActorWidget aw, SnapShotActorAction snapshot)
  updateActorsWidgetStates;
  final Function checkIfAllActionsCompleted;
  final Function(int addedActions) adAddToActions;

//  final _InnerAnimationConfig animationConfig;

  WidgetDirectorItem({this.actorWidget,
    this.key,
    this.snapshotKey,
    this.actorsLastSnapshot,
    this.updateActorsLastSnapshot,
    this.adGroup,
    this.adFreshStart,
    this.adCompletedActions,
    this.adAllActions,
    this.adPlusCompletedActions,
    this.adSpeedFactor,
    this.actorsWidgetStates,
    this.updateActorsWidgetStates,
    this.checkIfAllActionsCompleted,
    this.adAddToActions});

  @override
  _WidgetDirectorItemState createState() => _WidgetDirectorItemState();
}

class _WidgetDirectorItemState extends State<WidgetDirectorItem>
    with TickerProviderStateMixin {
  ActorAction actorAction;
  List<List<String>> _animationsList = [];
  Key actorKey = Key(_randomKey());

  ActorContainer lastACon = ActorContainer();

//  SpringSimulation lastPhysicsSpringSimulation;
  Offset lastPathOffset;
  Axis lastPhysicsAxis;
  double runTimeTop = 0;
  double runTimeLeft = 0;
  List<ActorAction> _actions = [];
  double _localSpeedFactor = 1;

  List<AnimationController> _animationControllers = [];

  @override
  void initState() {
    for (ActorAction item in widget.actorWidget.actions) {
      List<String> actorActions = [];
      if (item.position != null) actorActions.add('position');
      if (item.path != null) actorActions.add('path');
      if (item.rotation != null) actorActions.add('rotation');
      if (item.container != null) actorActions.add('container');
      if (item.opacity != null) actorActions.add('opacity');
      _animationsList.add(actorActions);
    }

    runActions();
    super.initState();
  }

  runActions() async {
    int addedActions = 0;

    int iterator = 0;
    for (ActorAction item in widget.actorWidget.actions) {
      _actions.add(item);

      if (item.path != null) {
        for (int innerIterator = 0;
        innerIterator < _animationsList.length;
        innerIterator++) {
          if (innerIterator > iterator) {
            if (_animationsList[innerIterator].contains('position')) {
              addedActions++;
              _actions.add(ActorAction(
                group: item.group,
                position: ActorPosition(
                    top: -2000,
                    left: -2000,
                    duration: Duration(milliseconds: 0)),
              )
                .._extra = 'AfterPath');
              break;
            }
          }
        }
      }
      iterator++;
    }

    widget.adAddToActions(addedActions);

    await Future.forEach(_actions, (ActorAction item) async {
      if (mounted) {
        if (widget.adGroup() != null &&
            (item.group == null ||
                (item.group != null &&
                    !item.group.contains(widget.adGroup())))) {
          widget.adPlusCompletedActions();
        } else {
          _localSpeedFactor = widget.adSpeedFactor();

          SnapShotActorAction lastSA =
          widget.actorsWidgetStates(widget.actorWidget);

          await Future.delayed(item.waitBeforeStart * _localSpeedFactor);

          ActorPosition aPos;
          aPos = item.position ?? lastSA.position;
          aPos.duration ??= _globalAnimationConfig.duration;
          aPos.curve ??= _globalAnimationConfig.curve;
          aPos.top ??= lastSA.position.top ?? null;
          aPos.left ??= lastSA.position.left ?? null;
          aPos.right ??= lastSA.position.right ?? null;
          aPos.bottom ??= lastSA.position.bottom ?? null;

/*          ActorPhysics aPhys;
          if (item.physics != null) {
            aPhys = item.physics;
            aPhys.physicsSpringSimulation ??= lastPhysicsSpringSimulation ?? null;
            aPhys.axis ??= lastPhysicsAxis ?? Axis.vertical;
          } else {}*/

          ActorScale aScl = item.scale ?? lastSA.scale;
          aScl.duration ??= _globalAnimationConfig.duration;
          aScl.curve ??= _globalAnimationConfig.curve;
          aScl.alignment ??= lastSA.scale.alignment ?? Alignment.topLeft;
          aScl.startScale ??= lastSA.scale.startScale ?? 1;
          aScl.finishScale ??= lastSA.scale.finishScale ?? 1;

          ActorOpacity aOpc = item.opacity ?? ActorOpacity();
          aOpc.duration ??= _globalAnimationConfig.duration;
          aOpc.curve ??= _globalAnimationConfig.curve;
          aOpc.opacity ??= 1;

          ActorContainer aCon = item.container ?? lastSA.container;
          aCon.duration ??= _globalAnimationConfig.duration;
          aCon.curve ??= _globalAnimationConfig.curve;
          aCon.decoration ??= lastSA.container.decoration ?? null;
          aCon.foregroundDecoration ??=
              lastSA.container.foregroundDecoration ?? null;
          aCon.width ??= lastSA.container.width ?? null;
          aCon.height ??= lastSA.container.height ?? null;
          aCon.padding ??= lastSA.container.padding ?? null;
          aCon.margin ??= lastSA.container.margin ?? null;
          aCon.child ??= lastSA.container.child ?? null;
          aCon.clipPath ??= lastSA.container.clipPath ?? null;

          ActorRotation aRot = item.rotation ?? ActorRotation();
          aRot.duration ??= _globalAnimationConfig.duration;
          aRot.curve ??= _globalAnimationConfig.curve;
          aRot.rotationTurns ??= 0.0;
          aRot.alignment ??= Alignment.center;
          aRot.clockwise ??= true;
          aRot.verticalFlipTurns ??= 0;
          aRot.horizontalFlipTurns ??= 0;
          aRot.startTween ??= 0.0;

          ActorPath aPath;
          aPath = item.path ?? null;
          if (aPath != null) {
            aPath.duration ??= _globalAnimationConfig.duration;
            aPath.curve ??= _globalAnimationConfig.curve;
            aPath.traversePercentage ??= 100;
            aPath.startPositionInPercent ??= 0;
            aPath.displayPath ??= false;
            aPath.displayProgress ??= false;
            aPath.fadingProgress ??= false;
            aPath.fixedWidth ??= null;
            aPath.fixedHeight ??= null;
            aPath.pathStyle ??= null;
            aPath.progressStyle ??= null;
            aPath.progressLength ??= null;
            aPath.progressAnimationRepeat ??= 0;
            aPath.offset ??=
                Offset((aCon.width ?? 1) / 2, (aCon.height ?? 1) / 2);
          }

          actorAction = ActorAction(
              group: item.group,
              position: aPos,
//            physics: aPhys,
              path: aPath,
              opacity: aOpc,
              rotation: aRot,
              onStart: item.onStart,
              onCompleted: item.onCompleted,
              container: aCon,
              scale: aScl);

          widget.updateActorsWidgetStates(
              widget.actorWidget,
              SnapShotActorAction(
                  position: actorAction.position,
                  container: actorAction.container,
                  scale: ActorScale(
                      startScale: actorAction.scale.finishScale,
                      finishScale: actorAction.scale.finishScale,
                      alignment: actorAction.scale.alignment)));

          actorAction.scale._scaleController = AnimationController(
              duration: aScl.duration * _localSpeedFactor, vsync: this);
          _animationControllers.add(actorAction.scale._scaleController);
          actorAction.scale._animation = Tween(
              begin: actorAction.scale.startScale,
              end: actorAction.scale.finishScale)
              .animate(CurvedAnimation(
              parent: actorAction.scale._scaleController,
              curve: actorAction.scale.curve ?? Curves.easeIn));
          actorAction.scale._scaleController.forward();

          actorAction.rotation._rotationController = AnimationController(
              duration: aRot.duration * _localSpeedFactor, vsync: this);
          _animationControllers.add(actorAction.rotation._rotationController);
          actorAction.rotation._animation =
              Tween(begin: actorAction.rotation.startTween, end: 1.0).animate(
                  CurvedAnimation(
                      parent: actorAction.rotation._rotationController,
                      curve: actorAction.rotation.curve ?? Curves.easeIn));

          actorAction.rotation._rotationController.forward();
/*
          if (actorAction.physics != null &&
              actorAction.physics.physicsSpringSimulation != null) {
            actorAction.physics._physicsController = AnimationController(
              vsync: this,
              upperBound: 500,
            )..addListener(() {
              setState(() {});
            });
            actorAction.physics._physicsController
                .animateWith(actorAction.physics.physicsSpringSimulation);
          }*/

          if (actorAction.onStart != null) {
            actorAction.onStart();
          }

          if (mounted) setState(() {});

          List<int> lastActionDurations = [];
          lastActionDurations
              .add(aPos != null ? aPos.duration.inMilliseconds : 0);
          lastActionDurations
              .add(aPath != null ? aPath.duration.inMilliseconds : 0);
          lastActionDurations.add(aOpc.duration.inMilliseconds);
          lastActionDurations.add(aRot.duration.inMilliseconds);
          lastActionDurations.add(aCon.duration.inMilliseconds);
          lastActionDurations.add(aScl.duration.inMilliseconds);
          int longestTransitionInMilliSeconds = lastActionDurations.reduce(max);
          await Future.delayed(
              Duration(milliseconds: longestTransitionInMilliSeconds) *
                  _localSpeedFactor);

          widget.adPlusCompletedActions();

          if (actorAction.onCompleted != null) {
            actorAction.onCompleted();
          }
        }

        if (widget.adAllActions() == widget.adCompletedActions()) {
          widget.checkIfAllActionsCompleted();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (actorAction == null) {
      Widget returnWidget = Positioned(
        child: Container(),
      );
      if (!widget.adFreshStart() &&
          widget.actorsLastSnapshot(widget.actorWidget) != null)
        returnWidget = widget.actorsLastSnapshot(widget.actorWidget);

      return returnWidget;
    }

    Widget innerAnimations = AnimatedOpacity(
      duration: actorAction.opacity.duration * _localSpeedFactor,
      curve: actorAction.opacity.curve,
      opacity: actorAction.opacity.opacity,
      child: AnimatedBuilder(
        animation: actorAction.rotation._rotationController,
        builder: (context, child) {
          int clockwise = (actorAction.rotation.clockwise) ? 1 : -1;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ((actorAction.rotation._animation.value *
                  actorAction.rotation.rotationTurns *
                  pi *
                  2) *
                  clockwise)
              ..rotateX((actorAction.rotation._animation.value *
                  actorAction.rotation.verticalFlipTurns *
                  pi *
                  2) *
                  clockwise)
              ..rotateY((actorAction.rotation._animation.value *
                  actorAction.rotation.horizontalFlipTurns *
                  pi *
                  2) *
                  clockwise),
            child: AnimatedContainer(
              duration: actorAction.container.duration * _localSpeedFactor,
              curve: actorAction.container.curve,
              width: actorAction.container.width,
              height: actorAction.container.height,
              padding: actorAction.container.padding,
              margin: actorAction.container.margin,
              decoration: actorAction.container.decoration,
              foregroundDecoration: actorAction.container.foregroundDecoration,
              child: actorAction.container.child,
            ),
          );
        },
      ),
    );

    if (actorAction.container.clipPath != null) {
      innerAnimations = ClipPath(
          clipBehavior: Clip.antiAlias,
          clipper: PathClipper(pathString: actorAction.container.clipPath),
          child: innerAnimations);
    }

    if (actorAction.path != null) {
      innerAnimations = PathAnimation(
          key: Key(_randomKey()),
          pathStyle: actorAction.path.pathStyle,
          progressStyle: actorAction.path.progressStyle,
          offset: actorAction.path.offset,
          curve: actorAction.path.curve,
          duration: actorAction.path.duration * _localSpeedFactor,
          child: innerAnimations,
          path: actorAction.path.path,
          fixedHeight: actorAction.path.fixedHeight,
          fixedWidth: actorAction.path.fixedWidth,
          displayPath: actorAction.path.displayPath,
          fadingProgress: actorAction.path.fadingProgress,
          displayProgress: actorAction.path.displayProgress,
          progressAnimationRepeat: actorAction.path.progressAnimationRepeat,
          progressLength: actorAction.path.progressLength,
          traversePercentage: actorAction.path.traversePercentage,
          startPositionInPercent: actorAction.path.startPositionInPercent,
          onProgress: (double top, double left) {
            for (int i = 0; i < _actions.length; i++) {
              if (_actions[i].position != null &&
                  _actions[i]._extra != null &&
                  _actions[i]._extra == 'AfterPath') {
                _actions[i].position.top = top;
                _actions[i].position.left = left;
              }
            }
          });
    }
    /*if (actorAction.physics != null &&
        actorAction.physics.physicsSpringSimulation != null) {
      return Positioned(
        child: innerAnimations,
        top: actorAction.physics.axis == Axis.vertical
            ? actorAction.physics._physicsController.value
            : actorAction.position.top,
        left: actorAction.physics.axis == Axis.horizontal
            ? actorAction.physics._physicsController.value
            : actorAction.position.left,
      );
    } else {*/

    widget.updateActorsLastSnapshot(
        widget.actorWidget,
        AnimatedPositioned(
          duration: actorAction.position.duration * _localSpeedFactor,
          curve: actorAction.position.curve,
          child: ScaleTransition(
              scale: actorAction.scale._animation,
              alignment: actorAction.scale.alignment,
              child: innerAnimations),
          top: actorAction.position.top,
          right: actorAction.position.right,
          bottom: actorAction.position.bottom,
          left: actorAction.position.left,
        ));

    return widget.actorsLastSnapshot(widget.actorWidget);
//    }
  }

  @override
  void dispose() {
    for (AnimationController ac in _animationControllers) {
      ac.dispose();
    }
    super.dispose();
  }
}

class SnapShotActorAction {
  ActorPosition position;
  ActorContainer container;
  ActorScale scale;

  SnapShotActorAction({this.position, this.container, this.scale});

  @override
  String toString() {
    return "<<Pos:${this.position}-Cont:${this.container}-Scl:${this.scale}>>";
  }
}

class ActorAction {
  List<String> group;
  String _extra;

  Function onCompleted;
  Function onStart;
  Duration waitBeforeStart;
  ActorPath path;
  ActorPosition position;
  ActorOpacity opacity;
  ActorContainer container;
  ActorRotation rotation;
  ActorScale scale;

//  ActorPhysics physics;

  ActorAction({this.group,
    this.onCompleted,
    this.onStart,
    this.waitBeforeStart = const Duration(milliseconds: 0),
    this.position,
    this.path,
    this.opacity,
    this.container,
    this.rotation,
    this.scale
//      this.physics
  });
}

class ActorWidget {
  String name;
  List<ActorAction> actions;

  ActorWidget({
    @required this.name,
    @required this.actions,
  });
}

class AnimationConfig {
  @required
  Duration duration;
  @required
  Curve curve;

  AnimationConfig({this.duration, this.curve});
}

class ActorPosition extends AnimationConfig {
  double top;
  double left;
  double right;
  double bottom;

  ActorPosition({duration, curve, this.left, this.top, this.right, this.bottom})
      : super(duration: duration, curve: curve);

  @override
  String toString() {
    return "@${this.top}-${this.right}-${this.bottom}-${this.left}@";
  }
}

/*
class ActorPhysics {
  SpringSimulation physicsSpringSimulation;
  AnimationController _physicsController;
  Axis axis;

  ActorPhysics({this.axis, this.physicsSpringSimulation});
}
*/

class ActorPath extends AnimationConfig {
  @required
  String path;
  int traversePercentage;
  int startPositionInPercent;
  bool displayPath;
  bool displayProgress;
  Offset offset;
  Paint pathStyle;
  Paint progressStyle;
  int progressLength;
  int progressAnimationRepeat;
  bool fadingProgress;
  double fixedWidth;
  double fixedHeight;

  ActorPath({duration,
    curve,
    this.path,
    this.offset,
    this.traversePercentage,
    this.startPositionInPercent,
    this.displayPath,
    this.displayProgress,
    this.pathStyle,
    this.progressStyle,
    this.progressLength,
    this.progressAnimationRepeat,
    this.fadingProgress,
    this.fixedWidth,
    this.fixedHeight})
      : /*assert(path != null),*/
        assert(traversePercentage == null ||
            (traversePercentage > 0 && traversePercentage <= 1000)),
        super(duration: duration, curve: curve);
}

class ActorOpacity extends AnimationConfig {
  @required
  double opacity;

  ActorOpacity({duration, curve, this.opacity})
      : super(duration: duration, curve: curve);
}

class ActorContainer extends AnimationConfig {
  double width;
  double height;
  Widget child;
  String clipPath;
  EdgeInsets padding;
  EdgeInsets margin;
  BoxDecoration decoration;
  BoxDecoration foregroundDecoration;

  ActorContainer({duration,
    curve,
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.clipPath,
    this.decoration,
    this.foregroundDecoration})
      : super(duration: duration, curve: curve);

  @override
  String toString() {
    return "@${this.width}-${this.height}@";
  }
}

class ActorScale extends AnimationConfig {
  @required
  Alignment alignment;
  double startScale;
  double finishScale;
  AnimationController _scaleController;
  Animation _animation;

  ActorScale(
      {duration, curve, this.alignment, this.finishScale, this.startScale})
      : super(duration: duration, curve: curve);

  @override
  String toString() {
    return "@${this.startScale}-${this.finishScale}@";
  }
}

class ActorRotation extends AnimationConfig {
  @required
  double rotationTurns;
  Alignment alignment;
  AnimationController _rotationController;
  Animation _animation;
  bool clockwise;
  double startTween;
  double verticalFlipTurns;
  double horizontalFlipTurns;

  ActorRotation({duration,
    curve,
    this.rotationTurns,
    this.alignment,
    this.clockwise,
    this.verticalFlipTurns,
    this.horizontalFlipTurns,
    this.startTween})
      : assert(startTween == null ||
      (startTween != null && startTween >= 0 && startTween < 1)),
        super(duration: duration, curve: curve);
}

class PathAnimation extends StatefulWidget {
  final Key key;
  final Duration duration;
  final Curve curve;
  final Widget child;
  final String path;
  final bool fadingProgress;
  final bool displayPath;
  final bool displayProgress;
  final int traversePercentage;
  final Offset offset;
  final Function onProgress;
  final Paint pathStyle;
  final Paint progressStyle;
  final int progressLength;
  final int progressAnimationRepeat;
  final double fixedWidth;
  final double fixedHeight;
  final int startPositionInPercent;

  PathAnimation({this.key,
    this.path,
    this.duration,
    this.curve,
    this.child,
    this.offset,
    this.fadingProgress = false,
    this.displayPath = false,
    this.displayProgress = false,
    this.onProgress,
    this.pathStyle,
    this.progressStyle,
    this.progressAnimationRepeat,
    this.progressLength,
    this.fixedHeight,
    this.fixedWidth,
    this.traversePercentage = 100,
    this.startPositionInPercent = 0});

  @override
  State<StatefulWidget> createState() {
    return PathAnimationState();
  }
}

class PathAnimationState extends State<PathAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Path _path;
  Offset position;
  double left;
  double top;
  GlobalKey _key = GlobalKey();
  int _repeatedAnimation = 0;
  int progressLength;
  PathMetric pathMetric;

  List<Offset> points = [];

  @override
  void initState() {
    _path = drawPath();
    PathMetrics pathMetrics = _path.computeMetrics();
    pathMetric = pathMetrics.elementAt(0);

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween(
        begin: (widget.startPositionInPercent == 0)
            ? 0.0
            : widget.startPositionInPercent / 100,
        end: widget.traversePercentage / 100)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve))
      ..addListener(() {
        if (widget.displayProgress) {
          points.add(new Offset(position.dx, position.dy));
          if (widget.progressLength != null &&
              points.length > widget.progressLength) {
            points.removeAt(0);
          }
        }
        _getPositions();
        setState(() {});
      })
      ..addStatusListener((status) {
        if (_repeatedAnimation < widget.progressAnimationRepeat) {
          if (status == AnimationStatus.completed) {
            _controller.forward(from: 0);
            _repeatedAnimation++;
          }
        }

        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    position = calculate(_animation.value);
    top = position.dy - widget.offset.dy;
    left = position.dx - widget.offset.dx;

    return Container(
      child: Stack(
        overflow: Overflow.visible,
//        fit: StackFit.expand,
        children: <Widget>[
          (widget.displayPath)
              ? Positioned(
            top: 0,
            child: CustomPaint(
              painter:
              PathPainter(path: _path, pathStyle: widget.pathStyle),
            ),
          )
              : Container(),
          (widget.displayProgress)
              ? Positioned(
            top: 0,
            child: CustomPaint(
              painter: LinePainter(
                  points: points,
                  progressStyle: widget.progressStyle,
                  fadingProgress: widget.fadingProgress),
            ),
          )
              : Container(),
          Positioned(
            key: _key,
            top: top,
            left: left,
            child: widget.child,
          ),
        ],
      ),
    );
  }

  _getPositions() {
    if (_key != null && _key.currentContext != null) {
      double paddingTop = MediaQuery
          .of(context)
          .padding
          .top;
      if (paddingTop > 0)
        paddingTop = 0;
      else
        paddingTop = 24;
      final RenderBox renderBox = _key.currentContext.findRenderObject();
      final position = renderBox.localToGlobal(Offset(0, -paddingTop));
      widget.onProgress(position.dy, position.dx);
    }
  }

  @override
  void dispose() {
    _getPositions();
    _controller.dispose();
    super.dispose();
  }

  Path drawPath() {
    Path path = Path();
    return generatePath(path: path, pathString: widget.path);
  }

  Offset calculate(value) {
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }
}

class PathPainter extends CustomPainter {
  Path path;
  Paint pathStyle;

  PathPainter({this.path, this.pathStyle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = pathStyle ?? Paint()
      ..color = Colors.redAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = false
      ..strokeWidth = 15.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LinePainter extends CustomPainter {
  List<Offset> points;
  Paint progressStyle;
  bool fadingProgress;

  LinePainter({this.points, this.progressStyle, this.fadingProgress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = progressStyle ?? Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    if (fadingProgress) {
      double opacityIntense = 1 / points.length;
      for (int iterator = 0; iterator < points.length; iterator++) {
        paint.color = paint.color.withOpacity(opacityIntense * iterator);
        canvas.drawPoints(
            PointMode.polygon,
            [
              points[iterator],
              points.length > iterator + 1
                  ? points[iterator + 1]
                  : points[iterator]
            ],
            paint);
      }
    } else {
      canvas.drawPoints(PointMode.polygon, points, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PathClipper extends CustomClipper<Path> {
  String pathString;

  PathClipper({this.pathString});

  @override
  Path getClip(Size size) {
    Path path = Path();
    return generatePath(path: path, pathString: pathString);
  }

  @override
  bool shouldReclip(PathClipper oldClipper) => true;
}

Path generatePath({Path path, String pathString}) {
  double adaptiveWidth;
  double adaptiveHeight;

  pathString = pathString.trim();

  List<String> pathDetails = pathString.split("PS");
  if (pathDetails.length > 1) {
    RegExpMatch adaptiveWidthRgx =
    RegExp(r'(?<=W)(\d*)(?=\s*)').firstMatch(pathDetails[1]);
    if (adaptiveWidthRgx != null)
      adaptiveWidth = int.parse(adaptiveWidthRgx.group(0)).toDouble();

    RegExpMatch adaptiveHeightRgx =
    RegExp(r'(?<=H)(\d*)(?=\s*)').firstMatch(pathDetails[1]);
    if (adaptiveHeightRgx != null)
      adaptiveHeight = int.parse(adaptiveHeightRgx.group(0)).toDouble();
  }

  pathString = pathDetails[0].trim();
  pathString = pathString.replaceAll(' M', "@M");
  pathString = pathString.replaceAll(' L', "@L");
  pathString = pathString.replaceAll(' A', "@A");
  pathString = pathString.replaceAll(' Q', "@Q");
  pathString = pathString.replaceAll(' C', "@C");
  pathString = pathString.replaceAll(' Z', "@Z");
  List<String> splitter = pathString.split("@");

  for (String point in splitter) {
    List<String> pointParts = point.split(" ");
    String pointType = pointParts[0];
    List<double> doublePointValues = [];
    int index = 0;
    for (String pointValue in pointParts) {
      index++;
      if (index == 1) continue;
      doublePointValues.add(double.parse(pointValue));
    }

    switch (pointType) {
      case 'M':
        path.moveTo(calcWidth(doublePointValues[0], adaptiveWidth),
            calcHeight(doublePointValues[1], adaptiveHeight));
        break;
      case 'L':
        path.lineTo(calcWidth(doublePointValues[0], adaptiveWidth),
            calcHeight(doublePointValues[1], adaptiveHeight));
        break;
      case 'Q':
        path.quadraticBezierTo(
            calcWidth(doublePointValues[0], adaptiveWidth),
            calcHeight(doublePointValues[1], adaptiveHeight),
            calcWidth(doublePointValues[2], adaptiveWidth),
            calcHeight(doublePointValues[3], adaptiveHeight));
        break;
      case 'C':
        path.cubicTo(
          calcWidth(doublePointValues[0], adaptiveWidth),
          calcHeight(doublePointValues[1], adaptiveHeight),
          calcWidth(doublePointValues[2], adaptiveWidth),
          calcHeight(doublePointValues[3], adaptiveHeight),
          calcWidth(doublePointValues[4], adaptiveWidth),
          calcHeight(doublePointValues[5], adaptiveHeight),
        );
        break;
      case 'A':
        path.arcToPoint(
          Offset(calcWidth(doublePointValues[5], adaptiveWidth),
              calcHeight(doublePointValues[6], adaptiveHeight)),
          radius: Radius.elliptical(doublePointValues[0], doublePointValues[1]),
          rotation: doublePointValues[2],
          clockwise: doublePointValues[4] == 1 ? true : false,
          largeArc: doublePointValues[3] == 1 ? true : false,
        );
        break;
      case 'Z':
        path.close();
        break;
    }
  }
  return path;
}

double calcWidth(double size, double relatedWidth) {
  if (relatedWidth == null) return size;
  double percent = size * 100 / relatedWidth;
  return percent * screenWidth / 100;
}

double calcHeight(double size, double relatedHeight) {
  if (relatedHeight == null) return size;
  double percent = size * 100 / relatedHeight;
  return percent * screenHeight / 100;
}

String _randomKey() {
  String randomNumber;
  randomNumber = Random().nextInt(999999).toString();
  randomNumber += Random().nextInt(999999).toString();
  randomNumber += Random().nextInt(999999).toString();
  return randomNumber;
}
