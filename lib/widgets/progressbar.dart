import 'package:flutter/material.dart';

import '../designSystem/palette.dart';

ClipRRect progressBar(double value) => ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    child: LinearProgressIndicator(
      value: value,
      backgroundColor: Palette.gray02,
      valueColor: const AlwaysStoppedAnimation<Color>(Palette.primary),
    ));
