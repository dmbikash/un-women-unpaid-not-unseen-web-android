import 'package:flutter/material.dart';

/// Custom splash factory that doesn't show any splash effect
class NoSplash extends InteractiveInkFeatureFactory {
  static final InteractiveInkFeatureFactory splashFactory = NoSplash();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    onRemoved,
  }) {
    return _NoSplash(
      controller: controller,
      referenceBox: referenceBox,
    );
  }
}

class _NoSplash extends InteractiveInkFeature {
  _NoSplash({
    required MaterialInkController controller,
    required RenderBox referenceBox,
  }) : super(
    controller: controller,
    referenceBox: referenceBox,
    color: Colors.transparent,
  );

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    // Do nothing - no splash
  }
}