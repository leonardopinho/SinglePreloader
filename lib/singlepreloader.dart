library singlepreloader;

import 'package:flutter/material.dart';

class SinglePreloader extends StatefulWidget {
  final Widget child;
  final Widget indicatorWidget;
  final Color indicatorColor;
  final Color containerColor;
  final Color backgroundColor;

  SinglePreloader({@required this.child, this.indicatorWidget, this.indicatorColor, this.containerColor, this.backgroundColor})
      : assert(child != null);

  @override
  _SinglePreloaderState createState() => _SinglePreloaderState();
}

class _SinglePreloaderState extends State<SinglePreloader> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  void show() {
    _controller.forward();
  }

  void hide() {
    _controller.reverse();
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500),);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _animation.addStatusListener((status) {
      setState(() {
        //_barrierVisible = status != AnimationStatus.dismissed;
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
    return Stack(children: [widget.child, FadeTransition(opacity: _animation, child: Stack(children: [
      Container(
        width: 40.0,
        height: 40.0,
        color: Colors.grey[400],
        child: CircularProgressIndicator(strokeWidth: 3.0, valueColor: AlwaysStoppedAnimation(widget.indicatorColor),),),
      Visibility(visible: true, child: ModalBarrier(color: widget.barrierColor,))
    ],))
    ]);
  }
}