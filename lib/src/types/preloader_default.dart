import 'package:custom_events/custom_events.dart';
import 'package:flutter/material.dart';
import 'package:simple_preloader/src/preloader_events.dart';
import 'package:simple_preloader/src/preloader_mixin.dart';
import 'package:simple_preloader/src/types/abstract_type.dart';

class PreloaderDefault extends StatefulWidget implements AbstractCustomPreloader {
  @override
  final Widget child;

  @override
  final Color indicatorColor;

  @override
  final Color containerColor;

  @override
  final double containerOpacity;

  @override
  final Color backgroundColor;

  @override
  final double backgroundOpacity;

  const PreloaderDefault({
    super.key,
    required this.child,
    required this.indicatorColor,
    required this.containerColor,
    required this.containerOpacity,
    required this.backgroundColor,
    required this.backgroundOpacity,
  });

  @override
  PreloaderDefaultState createState() => PreloaderDefaultState();
}

class PreloaderDefaultState extends State<PreloaderDefault> with SingleTickerProviderStateMixin, PreloaderMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    initEvents(this, changeStatus);
  }

  void changeStatus(status) {
    setState(() {
      _visible = status != AnimationStatus.dismissed;
    });
  }

  @override
  void dispose() {
    disposeEvents();
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
            opacity: animation,
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  color: widget.backgroundColor.withOpacity(widget.backgroundOpacity),
                ),
                Center(
                  child: Container(
                    width: 65.0,
                    height: 65.0,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: widget.containerColor.withOpacity(widget.containerOpacity),
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(
                        color: widget.containerColor.withOpacity(widget.containerOpacity),
                        width: 1,
                      ),
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: 2.9,
                      color: widget.indicatorColor,
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
