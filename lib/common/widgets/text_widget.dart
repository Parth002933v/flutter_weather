import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<Shadow> shadow = [
  const Shadow(
    color: Colors.black12,
    offset: Offset(3, 4),
  ),
];

class Text30bold extends StatelessWidget {
  const Text30bold({
    super.key,
    this.text = 'Enter text',
    this.color = Colors.white,
  });

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.spMin,
          color: color,
          shadows: shadow),
    );
  }
}

class Text40bold extends StatelessWidget {
  const Text40bold({
    super.key,
    this.text = 'Enter text',
    this.color = Colors.white,
  });

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.spMin,
          color: color,
          shadows: shadow,
          height: 1),
    );
  }
}

class Text80bold extends StatelessWidget {
  const Text80bold({
    super.key,
    this.text = 'Enter text',
    this.color = Colors.white,
    this.fontWeight = FontWeight.bold,
  });

  final String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: 80.spMin,
        color: color,
        height: 1,
        shadows: shadow,
      ),
    );
  }
}

class Text16normal extends StatelessWidget {
  const Text16normal({
    super.key,
    this.text = 'Enter text',
    this.color = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.shadow = true,
  });

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final bool shadow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.spMin,
        color: color,
        fontWeight: fontWeight,
        shadows: shadow == false
            ? null
            : const [
                Shadow(
                  color: Colors.black12,
                  offset: Offset(3, 5),
                ),
              ],
      ),
    );
  }
}

class Text14normal extends StatelessWidget {
  const Text14normal({
    super.key,
    this.text = 'Enter text',
    this.color = Colors.white,
    this.shadow = true,
    this.fontWeight = FontWeight.normal,
  });

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.spMin,
        color: color,
        fontWeight: fontWeight,
        shadows: shadow == false
            ? null
            : const [
                Shadow(
                  color: Colors.black12,
                  offset: Offset(3, 5),
                ),
              ],
      ),
    );
  }
}

class Text12normal extends StatelessWidget {
  const Text12normal({
    super.key,
    this.text = 'Enter text',
    this.color = Colors.white,
    this.fontWeight = FontWeight.normal,
  });

  final String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 12.spMin,
          color: color,
          fontWeight: fontWeight,
          height: 1.h,
          shadows: shadow),
    );
  }
}

class Text20normal extends StatelessWidget {
  const Text20normal({
    super.key,
    this.text = 'Enter text',
    this.color = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.shadow = true,
  });

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final bool shadow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          color: color,
          shadows: shadow == false
              ? null
              : const [
                  Shadow(
                    color: Colors.black12,
                    offset: Offset(3, 3),
                  ),
                ],
          fontWeight: fontWeight),
    );
  }
}
