import 'package:flutter/material.dart';

class Screen_helper extends StatelessWidget {
  Widget mobile;
  Widget desktop;
  Widget tab;
  Screen_helper(
      {Key? key,
      required this.mobile,
      required this.desktop,
      required this.tab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 700) {
        return mobile;
      } else if (constraints.maxWidth >= 700 && constraints.maxWidth<1000) {
        return tab;
      }else{
        return desktop;
      }
    });
  }
}
