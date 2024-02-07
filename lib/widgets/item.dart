import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets/designsystem/palette.dart';

Widget artistItem(String path, String artistName) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(path),
        Text(
          artistName,
          style: const TextStyle(color: Palette.gray06),
        ),
      ],
    );
