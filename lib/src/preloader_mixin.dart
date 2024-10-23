import 'package:custom_events/custom_events.dart';
import 'package:flutter/material.dart';
import 'package:simple_preloader/src/preloader_events.dart';

mixin PreloaderMixin {
  CustomEvents events = CustomEvents.instance;
  late final AnimationController controller;
  late final Animation<double> animation;
  late final Function callback;

  void show() {
    controller.forward();
  }

  void hide() {
    controller.reverse();
  }

  void initEvents(TickerProvider ctx, Function changeStatus) {
    callback = changeStatus;

    controller = AnimationController(
      vsync: ctx,
      duration: const Duration(milliseconds: 800),
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCirc,
    );

    animation.addStatusListener((status) {
      events.dispatchEvent(PreloaderEvents.STATUS, value: status);
    });

    events.addEventListener(PreloaderEvents.STATUS, callback);
    events.addEventListener(PreloaderEvents.SHOW, show);
    events.addEventListener(PreloaderEvents.HIDE, hide);
  }

  void disposeEvents() {
    controller.dispose();
    events.removeEventListener(PreloaderEvents.STATUS, listener: callback);
    events.removeEventListener(PreloaderEvents.SHOW, listener: show);
    events.removeEventListener(PreloaderEvents.HIDE, listener: hide);
  }
}
