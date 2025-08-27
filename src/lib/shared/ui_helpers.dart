import 'dart:math';

import 'package:flutter/material.dart';

const double _smallSize = 10;
const double _mediumSize = 25;
const double _largeSize = 50;
const double _massiveSize = 120;

const Widget kSpaceSmall = SizedBox(height: _smallSize);
const Widget kSpaceMedium = SizedBox(height: _mediumSize);
const Widget kSpaceLarge = SizedBox(height: _largeSize);
const Widget kSpaceMassive = SizedBox(height: _massiveSize);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);
