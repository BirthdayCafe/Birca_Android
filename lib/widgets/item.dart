import 'package:flutter/material.dart';
import '../designSystem/palette.dart';

artistItem(String path, String artistName) => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              path,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset('lib/assets/image/artist.svg');
              },
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          artistName,
          style: const TextStyle(color: Palette.gray06),
        ),
      ],
    );
