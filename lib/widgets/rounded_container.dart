import 'package:flutter/material.dart';

/// A simple Container with rounded top left and right borders.
class RoundedBordersContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  /// A simple Container with rounded top left and right borders.
  ///  * Border radius is 32.0
  const RoundedBordersContainer(
      {Key? key,
      required this.child,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: height * 0.03, horizontal: width * 0.07),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: child,
    );
  }
}
