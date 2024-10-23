import 'package:flutter/material.dart';

abstract class AbstractCustomPreloader {
  final Widget child;
  final Color indicatorColor;
  final Color containerColor;
  final double containerOpacity;
  final Color backgroundColor;
  final double backgroundOpacity;

  AbstractCustomPreloader({
    required this.child,
    required this.indicatorColor,
    required this.containerColor,
    required this.containerOpacity,
    required this.backgroundColor,
    required this.backgroundOpacity,
  });
}
