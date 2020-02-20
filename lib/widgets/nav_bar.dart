import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class NavBar extends StatefulWidget {
  final bool isTop;
  NavBar({Key key, this.isTop = false}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _textOpacity;
  Animation _y;
  Animation _opacity;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _textOpacity = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _y = Tween(begin: 0.0, end: -10.0).animate(_controller);

    _opacity = Tween(begin: 1.0, end: 0.0).animate(_controller);

    _controller.repeat();
    _textOpacity.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Container(
        child: Stack(
          children: <Widget>[
            Positioned(
                bottom: widget.isTop ? 7 : null,
                right: 0,
                left: 0,
                top: widget.isTop ? null : 7,
                child: Opacity(
                  opacity: _textOpacity.value,
                  child: Text(
                    widget.isTop ? "Open Bot" : "Hide Bot",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45),
                  ),
                )),
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                  Transform.rotate(
                    angle: widget.isTop ? 0 : 180 * (math.pi / 180),
                    child: Transform.translate(
                      offset: Offset(0.0, _y.value),
                      child: Opacity(
                        opacity: _opacity.value,
                        child: Icon(
                          CupertinoIcons.up_arrow,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _textOpacity.dispose();
    super.dispose();
  }
}
