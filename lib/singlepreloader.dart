library singlepreloader;

import 'package:flutter/material.dart';

class SinglePreloader extends StatefulWidget {
  final Widget child;
  final Widget indicatorWidget;
  final Color indicatorColor;
  final Color containerColor;
  final Color backgroundColor;

  SinglePreloader(
      {@required this.child,
        this.indicatorWidget,
        this.indicatorColor = Colors.white,
        this.containerColor = Colors.grey,
        this.backgroundColor = Colors.black54})
      : assert(child != null);

  static _SinglePreloaderState of(BuildContext context) {
    final singlePreloaderState = context.ancestorStateOfType(TypeMatcher<_SinglePreloaderState>());
    return singlePreloaderState;
  }

  @override
  _SinglePreloaderState createState() => _SinglePreloaderState();
}

class _SinglePreloaderState extends State<SinglePreloader> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  bool _visible = false;

  void show() {
    _controller.forward();
  }

  void hide() {
    _controller.reverse();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _animation.addStatusListener((status) {
      setState(() {
        _visible = status != AnimationStatus.dismissed;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        widget.child,
        FadeTransition(
          opacity: _animation,
          child: Stack(children: [
            Container(
              width: _width,
              height: _height,
              color: Colors.black38,
            ),
            Center(
              child: Container(
                width: 65.0,
                height: 65.0,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(
                      color: Colors.black54,
                      width: 1,
                    )),
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(widget.indicatorColor),
                ),
              ),
            )
          ]),
        )
      ],
    );
  }
}