import 'package:custom_events/custom_events.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_preloader/src/preloader_events.dart';
import 'package:simple_preloader/src/preloader_mixin.dart';
import 'package:simple_preloader/src/types/abstract_type.dart';

class PreloaderAnimatedPulse extends StatefulWidget implements AbstractCustomPreloader {
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

  const PreloaderAnimatedPulse({
    super.key,
    required this.child,
    required this.indicatorColor,
    required this.containerColor,
    required this.containerOpacity,
    required this.backgroundColor,
    required this.backgroundOpacity,
  });

  @override
  PreloaderAnimatedPulseState createState() => PreloaderAnimatedPulseState();
}

class PreloaderAnimatedPulseState extends State<PreloaderAnimatedPulse> with SingleTickerProviderStateMixin, PreloaderMixin {
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
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: [
                Container(
                  width: width,
                  height: height,
                  color: widget.backgroundColor.withOpacity(widget.backgroundOpacity),
                ),
                Container(
                  width: 68.0,
                  height: 68.0,
                  decoration: BoxDecoration(
                    color: widget.containerColor.withOpacity(widget.containerOpacity),
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                    border: Border.all(
                      color: widget.containerColor.withOpacity(widget.containerOpacity),
                      width: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 135.0,
                  height: 135.0,
                  child: ColorFiltered(colorFilter: ColorFilter.mode(widget.indicatorColor, BlendMode.srcATop), child: Lottie.asset('packages/simple_preloader/assets/anim_2.json')),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
