import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/animation.dart';
import 'package:skin_care/screens/bot_page.dart';
import 'package:skin_care/screens/bot_start.dart';
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
    _border = (media.size.width - media.padding.top) / 2;
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
      stiffness: 100.0,
      damping: 15.0,
    );
    var simulation = SpringSimulation(_desc, _x, _toVal, _velocity);
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
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  offset:
                                      Offset((_top > _border) ? 10 : -10, 0),
                                  color: Colors.black12)
                            ]),
                            child: NavBar(
                              isTop: _top > _border,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: BotStart(
                              tabController: null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}
