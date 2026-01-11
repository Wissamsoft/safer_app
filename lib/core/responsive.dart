import 'package:flutter/widgets.dart';

/// Simple responsive scaler based on a 375pt baseline width (iPhone 8-like).
/// Use `rs(context, 16)` to get a scaled font/size value.
double rs(BuildContext context, double size) {
  final baseWidth = 375.0;
  final screenWidth = MediaQuery.of(context).size.width;
  return size * (screenWidth / baseWidth);
}
