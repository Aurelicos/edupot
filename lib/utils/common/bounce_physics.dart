import 'package:flutter/material.dart';

class OneBouncePhysics extends BouncingScrollPhysics {
  const OneBouncePhysics({super.parent});

  @override
  OneBouncePhysics applyTo(ScrollPhysics? ancestor) {
    return OneBouncePhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (isOverscrollingTop(position, value)) {
      return value - position.minScrollExtent;
    }
    return super.applyBoundaryConditions(position, value);
  }

  bool isOverscrollingTop(ScrollMetrics position, double value) {
    return value < position.minScrollExtent;
  }
}
