import 'package:flutter/material.dart';

Animation<double> animeAnimation(
    AnimationController controller, int index, int count) {
  return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    parent: controller,
    curve: Interval((1 / count) * index, 1.0,
        curve: Curves.fastLinearToSlowEaseIn),
  ));
}
