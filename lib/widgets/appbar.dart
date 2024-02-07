import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar bircaAppBar(void Function() onPressed) => AppBar(
    scrolledUnderElevation: 0,
    leading: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset('lib/assets/image/ic_back.svg')));
