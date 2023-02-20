import 'package:flutter/material.dart';

Widget customBackground({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/background.png",
            ),
            fit: BoxFit.fill)),
    child: child,
  );
}
