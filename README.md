## EDITING ...


# animation_director

A package to create nice and smooth animations for flutter

## Introduction

A simple package to build beautiful and smooth animations for flutter framework. By using this package, you don't need 
to bother yourself with `AnimationController`s, `AnimationTweens` and also timing and of those animations.

Here there are some simple examples of what I've made with this package in 5 minutes for each one.


![](showcase/animator-d1.gif)
![](showcase/animator-m3x3.gif)
![](showcase/hamburger.gif)
![](showcase/mr-fastfood.gif)


Each object on the screen is called an `ActorWidget`. and `ActorWidget` can have a list of actions. for example:  
```dart
  // ___________________________________
  ActorWidget(                          |
    name: 'Actor1',                     |
    actions: [                          |
      // ___________                    |
      ActorAction(  |                   |
        ...         |                   |
      ),            |                   |
      ActorAction(  |                   |
        ...         | (Sequentially)    | (Simultaneously)
      ),            |                   |
      ActorAction(  |                   |
        ...         |                   |
      )             |                   |
      // ___________|                   |
  ]),                                   |
  ActorWidget(),                        | 
  ActorWidget(),                        |
  ActorWidget(),                        |
  // ___________________________________|
  
```
All `ActorWidget` in your animation run simultaneously
All `ActorAction`s inside of an `ActorWidget` run sequentially