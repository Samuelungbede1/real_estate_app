import 'package:flutter/material.dart';

import 'size_config.dart';

class NavigationBuilder extends PageRouteBuilder {
  NavigationBuilder(this.child,
      {this.isScale = true,
      RouteSettings? settings,
      this.direction = AxisDirection.left,
      this.directionDuration = 200,
      this.curve = Curves.easeOutSine})
      : super(
          settings: settings,
          reverseTransitionDuration: Duration(milliseconds: directionDuration),
          transitionDuration: Duration(milliseconds: directionDuration),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  final Widget child;
  final bool isScale;
  final AxisDirection direction;
  final Curve curve;
  final int directionDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final MediaQueryData media = MediaQuery.of(context);
    SizeConfig.setSize(media);
    return isScale
        ? ScaleTransition(
            scale: animation, child: MyWidgetBuilder(child: child))
        : SlideTransition(
            position: Tween<Offset>(
              begin: getDirection(),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: curve)),
            child: MyWidgetBuilder(child: child),
          );
  }

  Offset getDirection() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}

class MyWidgetBuilder extends StatelessWidget {
  const MyWidgetBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // SizeUtil().init(context);
    final MediaQueryData media = MediaQuery.of(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        alwaysUse24HourFormat: true,
        textScaler: const TextScaler.linear(1.0),
      ),
      child: Stack(
        children: <Widget>[
          WillPopScope(
            onWillPop: (() async => false),
            child: SizedBox(
                width: media.size.width,
                height: media.size.height,
                child: child),
          ),
        ],
      ),
    );
  }
}

