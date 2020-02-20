import 'package:after_init/after_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';
import 'package:skin_care/bloc/navigator.dart';
import 'package:skin_care/screens/bot_page.dart';
import 'package:skin_care/screens/bot_start.dart';
import 'package:skin_care/screens/desease_list.dart';
import 'package:skin_care/screens/newBotPage.dart';
import 'package:skin_care/widgets/nav_bar.dart';

class SkinCare extends StatefulWidget {
  SkinCare({
    Key key,
  }) : super(key: key);

  @override
  _SkinCareState createState() => _SkinCareState();
}

class _SkinCareState extends State<SkinCare>
    with TickerProviderStateMixin, AfterInitMixin<SkinCare> {
  final barHeight = 60.0;

  double _x = -100;
  double _lowerBound;
  double _upperBound;
  double _prevBound;
  double _border;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: double.negativeInfinity,
        upperBound: double.infinity);
  }

  @override
  void didInitState() {
    var media = MediaQuery.of(context);
    _upperBound = media.size.height - barHeight;
    _lowerBound = media.padding.top;
    _x = _upperBound;
    _border = (media.size.height - media.padding.top) / 2;
  }

  void _runAnimation(DragEndDetails e) {
    var media = MediaQuery.of(context);
    var _velocityThreshold = 700;
    double _toVal;
    var _velocity = e.velocity.pixelsPerSecond.dy;

    if (_velocity >= _velocityThreshold) {
      _toVal = _upperBound;
    } else if (_velocity <= -_velocityThreshold) {
      _toVal = _lowerBound;
    } else if (_x >= _border) {
      _toVal = _upperBound;
    } else if (_x < _border) {
      _toVal = _lowerBound;
    }
    print(_velocity);
    var _desc = SpringDescription(
      mass: 1.0,
      stiffness: 250.0,
      damping: 18.0,
    );
    var simulation = SpringSimulation(
        _desc, _x.clamp(_lowerBound, _upperBound), _toVal, _velocity / 30);
    _controller.animateWith(simulation);

    _x = _toVal;
    _prevBound = _x;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: barHeight),
              color: Colors.white,
              child: Navigator(
                key: Provider.of<NavigatorBloc>(context).navigatorKey,
                onGenerateRoute: (set) {
                  navigateTo(Widget toScreen) =>
                      CupertinoPageRoute(builder: (_) => toScreen);
                  switch (set.name) {
                    case "/":
                      return navigateTo(DeseaseList());
                      break;
                    default:
                      return navigateTo(DeseaseList());
                  }
                },
                initialRoute: "/",
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              var _top = _controller.isAnimating
                  ? _controller.value
                  : _x.clamp(_lowerBound, _upperBound);
              return Positioned(
                top: _top,
                right: 0,
                child: Container(
                  color: Colors.white,
                  width: media.size.width,
                  height: media.size.height - media.padding.top,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onVerticalDragUpdate: (e) {
                          setState(() {
                            if (_controller.isAnimating) {
                              _controller.stop();
                            }
                            _x += e.delta.dy;
                          });
                        },
                        onVerticalDragEnd: _runAnimation,
                        onVerticalDragCancel: () {
                          setState(() {
                            _x = _prevBound;
                          });
                        },
                        child: Container(
                          width: media.size.width,
                          height: barHeight,
                          margin: EdgeInsets.only(bottom: 0.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              _top >= _border
                                  ? BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(0, -10),
                                      color: Colors.black26,
                                    )
                                  : BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                      color: Colors.black12,
                                    ),
                            ],
                          ),
                          child: NavBar(
                            isTop: _top > _border,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Botpage(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
