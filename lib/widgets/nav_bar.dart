import 'package:flutter/material.dart';
import 'dart:math' as math;

class NavBar extends StatefulWidget {
  final bool isTop;
  NavBar({Key key, this.isTop = false}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _y;
  Animation _opacity;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _y = Tween(begin: 0.0, end: -10.0).animate(_controller);
    _opacity = Tween(begin: 1.0, end: 0.0).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              return Transform.rotate(
                angle: widget.isTop ? 0 : 180 * (math.pi / 180),
                child: Transform.translate(
                  offset: Offset(0.0, _y.value),
                  child: Opacity(
                    opacity: _opacity.value,
                    child: Icon(
                      Icons.arrow_upward,
                    ),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
