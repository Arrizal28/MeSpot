import 'package:flutter/material.dart';

enum MespotColors {
  green("green", Color(0xFF77ad33)),
  lightbgColor("lightbgColor", Color(0xFFf9f9f9)),
  blackbgColor("blackbgColor", Color(0xFF1F1413)),
  containerDarkBgColor("containerblackbgColor", Color(0xFF4A4A4A));

  const MespotColors(this.name, this.color);

  final String name;
  final Color color;
}
