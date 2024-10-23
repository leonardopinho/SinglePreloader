import 'package:custom_events/custom_events.dart';
import 'package:flutter/material.dart';
import 'package:simple_preloader/simple_preloader.dart';
import 'package:simple_preloader/src/preloader_events.dart';
import 'package:simple_preloader/src/types/preloader_animated_balls.dart';
import 'package:simple_preloader/src/types/preloader_animated_pulse.dart';
import 'package:simple_preloader/src/types/preloader_animated_success.dart';
import 'package:simple_preloader/src/types/preloader_default.dart';

class SimplePreloader extends StatefulWidget {
  final Widget child;
  final PreloaderType type;
  final Color indicatorColor;
  final Color containerColor;
  final double containerOpacity;
  final Color backgroundColor;
  final double backgroundOpacity;

  const SimplePreloader({
    super.key,
    this.type = PreloaderType.DEFAULT,
    required this.child,
    this.indicatorColor = Colors.white,
    this.containerColor = Colors.black54,
    this.containerOpacity = .5,
    this.backgroundColor = Colors.black38,
    this.backgroundOpacity = .5,
  });

  static SimplePreloaderState? of(BuildContext context) {
    return context.findAncestorStateOfType<SimplePreloaderState>();
  }

  @override
  SimplePreloaderState createState() => SimplePreloaderState();
}

class SimplePreloaderState extends State<SimplePreloader> {
  CustomEvents events = CustomEvents.instance;

  void show() {
    events.dispatchEvent(PreloaderEvents.SHOW);
  }

  void hide() {
    events.dispatchEvent(PreloaderEvents.HIDE);
  }

  @override
  void didUpdateWidget(SimplePreloader oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getPreloader(context);
  }

  Widget getPreloader(BuildContext context) {
    switch (widget.type) {
      case PreloaderType.DEFAULT:
        return PreloaderDefault(
          indicatorColor: widget.indicatorColor,
          containerColor: widget.containerColor,
          containerOpacity: widget.containerOpacity,
          backgroundColor: widget.backgroundColor,
          backgroundOpacity: widget.backgroundOpacity,
          child: widget.child,
        );
      case PreloaderType.ANIMATED_BALLS:
        return PreloaderAnimatedBalls(
          indicatorColor: widget.indicatorColor,
          containerColor: widget.containerColor,
          containerOpacity: widget.containerOpacity,
          backgroundColor: widget.backgroundColor,
          backgroundOpacity: widget.backgroundOpacity,
          child: widget.child,
        );
      case PreloaderType.ANIMATED_PULSE:
        return PreloaderAnimatedPulse(
          indicatorColor: widget.indicatorColor,
          containerColor: widget.containerColor,
          containerOpacity: widget.containerOpacity,
          backgroundColor: widget.backgroundColor,
          backgroundOpacity: widget.backgroundOpacity,
          child: widget.child,
        );
      case PreloaderType.ANIMATED_SUCCESS:
        return PreloaderAnimatedSuccess(
          indicatorColor: widget.indicatorColor,
          containerColor: widget.containerColor,
          containerOpacity: widget.containerOpacity,
          backgroundColor: widget.backgroundColor,
          backgroundOpacity: widget.backgroundOpacity,
          child: widget.child,
        );
    }
  }
}
