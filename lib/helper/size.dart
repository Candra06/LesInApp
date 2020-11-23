import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context, {int number = 1}) {
  return displaySize(context).height * number;
}

double displayWidth(BuildContext context, {int number = 1}) {
  return displaySize(context).width * number;
}

double displayHalfHeight(BuildContext context, {double number = 0.5}) {
  return displaySize(context).height * number;
}

double displayHalfWidth(BuildContext context, {double number = 0.5}) {
  return displaySize(context).width * number;
}