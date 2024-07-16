import 'package:flutter/material.dart';
import 'package:morningstar/presentation_layer/theme/pallete.dart';

class BorderState {
  static InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: Pallete.blueColor,
      width: 1.0,
    ),
  );

  static InputBorder focusedBorder = BorderState.border;

  static InputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: Pallete.blackColor,
      width: 1.0,
    ),
  );

  static InputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: Pallete.redColor,
      width: 1.0,
    ),
  );

  static InputBorder focusedErrorBorder = BorderState.errorBorder;
}
