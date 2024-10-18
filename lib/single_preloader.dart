library single_preloader;

import 'package:flutter/material.dart';

class SinglePreloader extends StatefulWidget {
  final Widget child;
  final Widget indicatorWidget;
  final Color indicatorColor;
  final Color containerColor;
  final Color backgroundColor;

  const SinglePreloader({
    required this.child,
    this.indicatorWidget = const CircularProgressIndicator(),
    this.indicatorColor = Colors.white,
    this.containerColor = Colors.grey,
    this.backgroundColor = Colors.black54,
    super.key,
  });

  static _SinglePreloaderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_SinglePreloaderState>();
  }

  @override
  _SinglePreloaderState createState() => _SinglePreloaderState();
}

class _SinglePreloaderState extends State<SinglePreloader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _visible = false;

  void show() {
    _controller.forward();
  }

  void hide() {
    _controller.reverse();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _animation.addStatusListener((status) {
      setState(() {
        _visible = status != AnimationStatus.dismissed;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        widget.child,
        if (_visible)
          FadeTransition(
            opacity: _animation,
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  color: Colors.black38,
                ),
                Center(
                  child: Container(
                    width: 65.0,
                    height: 65.0,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                      ),
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(widget.indicatorColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
