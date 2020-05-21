import 'dart:math';

import 'package:flutter/material.dart';

class BreathWidget extends StatefulWidget {
  @override
  _BreathWidgetState createState() => _BreathWidgetState();
}

class _BreathWidgetState extends State<BreathWidget> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 3), vsync: this)..repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 280,
        width: 280,
        child: CustomPaint(
          painter: BreathePainter(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOutQuart,
              reverseCurve: Curves.easeOutQuart,
            ),
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class BreathePainter extends CustomPainter {
  BreathePainter(this.animation, {this.count = 6, this.color})
      : circlePaint = Paint()
          ..color = Colors.blue
          ..blendMode = BlendMode.modulate,
        super(repaint: animation);

  final Animation<double> animation;
  final int count;
  final Paint circlePaint;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.25) * animation.value;
    for (int i = 0; i < count; i++) {
      final indexAngle = (i * pi / count * 2);
      final angle = indexAngle + (pi * 1.5 * animation.value);
      final offset = Offset(sin(angle), cos(angle)) * radius * 0.985;
      canvas.drawCircle(center + (offset * animation.value), radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(BreathePainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
