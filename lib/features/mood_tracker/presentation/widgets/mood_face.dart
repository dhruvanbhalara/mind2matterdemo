import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../domain/entities/mood.dart';

class MoodFace extends StatelessWidget {
  const MoodFace({
    required this.mood,
    required this.size,
    super.key,
    this.animationValue = 0,
  });

  final Mood mood;
  final double size;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: MoodFacePainter(mood: mood, animationValue: animationValue),
    );
  }
}

class MoodFacePainter extends CustomPainter {
  MoodFacePainter({required this.mood, required this.animationValue});

  final Mood mood;
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final double t = animationValue.clamp(0.0, 1.0);
    final Offset center = size.center(Offset.zero);
    final double radius = size.width / 2;

    final Paint fillPaint = Paint()
      ..color = mood.accentColor.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = mood.accentColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final Paint featurePaint = Paint()
      ..color = mood.accentColor
      ..strokeWidth = 3.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 2, fillPaint);
    canvas.drawCircle(center, radius - 2, strokePaint);

    final double eyeY = size.height * (0.38 - (0.015 * t));
    final double eyeSpread = size.width * 0.18;
    final double eyeRadius = size.width * (0.04 + (0.006 * t));

    canvas.drawCircle(
      Offset(center.dx - eyeSpread, eyeY),
      eyeRadius,
      featurePaint,
    );
    canvas.drawCircle(
      Offset(center.dx + eyeSpread, eyeY),
      eyeRadius,
      featurePaint,
    );

    _drawEyebrows(canvas, size, featurePaint, t);
    _drawMouth(canvas, size, featurePaint, t);
  }

  void _drawEyebrows(Canvas canvas, Size size, Paint paint, double t) {
    final Path leftPath = Path();
    final Path rightPath = Path();

    switch (mood) {
      case Mood.happy:
        leftPath
          ..moveTo(size.width * 0.25, size.height * (0.26 - (0.012 * t)))
          ..quadraticBezierTo(
            size.width * 0.32,
            size.height * (0.20 - (0.01 * t)),
            size.width * 0.38,
            size.height * (0.26 - (0.012 * t)),
          );
        rightPath
          ..moveTo(size.width * 0.62, size.height * (0.26 - (0.012 * t)))
          ..quadraticBezierTo(
            size.width * 0.68,
            size.height * (0.20 - (0.01 * t)),
            size.width * 0.75,
            size.height * (0.26 - (0.012 * t)),
          );
      case Mood.excited:
        leftPath
          ..moveTo(size.width * 0.25, size.height * (0.24 - (0.014 * t)))
          ..lineTo(size.width * 0.38, size.height * (0.18 - (0.018 * t)));
        rightPath
          ..moveTo(size.width * 0.62, size.height * (0.18 - (0.018 * t)))
          ..lineTo(size.width * 0.75, size.height * (0.24 - (0.014 * t)));
      case Mood.calm:
        leftPath
          ..moveTo(size.width * 0.25, size.height * (0.26 - (0.004 * t)))
          ..quadraticBezierTo(
            size.width * 0.32,
            size.height * (0.23 - (0.004 * t)),
            size.width * 0.38,
            size.height * (0.26 - (0.004 * t)),
          );
        rightPath
          ..moveTo(size.width * 0.62, size.height * (0.26 - (0.004 * t)))
          ..quadraticBezierTo(
            size.width * 0.68,
            size.height * (0.23 - (0.004 * t)),
            size.width * 0.75,
            size.height * (0.26 - (0.004 * t)),
          );
      case Mood.neutral:
        leftPath
          ..moveTo(size.width * 0.25, size.height * (0.24 - (0.004 * t)))
          ..lineTo(size.width * 0.38, size.height * (0.24 - (0.004 * t)));
        rightPath
          ..moveTo(size.width * 0.62, size.height * (0.24 - (0.004 * t)))
          ..lineTo(size.width * 0.75, size.height * (0.24 - (0.004 * t)));
      case Mood.anxious:
        leftPath
          ..moveTo(size.width * 0.25, size.height * (0.30 + (0.006 * t)))
          ..lineTo(size.width * 0.38, size.height * (0.22 - (0.006 * t)));
        rightPath
          ..moveTo(size.width * 0.62, size.height * (0.22 - (0.006 * t)))
          ..lineTo(size.width * 0.75, size.height * (0.30 + (0.006 * t)));
      case Mood.sad:
        leftPath
          ..moveTo(size.width * 0.25, size.height * (0.24 + (0.005 * t)))
          ..lineTo(size.width * 0.38, size.height * (0.29 + (0.008 * t)));
        rightPath
          ..moveTo(size.width * 0.62, size.height * (0.29 + (0.008 * t)))
          ..lineTo(size.width * 0.75, size.height * (0.24 + (0.005 * t)));
      case Mood.tired:
        leftPath
          ..moveTo(size.width * 0.24, size.height * (0.28 + (0.01 * t)))
          ..lineTo(size.width * 0.39, size.height * (0.28 + (0.01 * t)));
        rightPath
          ..moveTo(size.width * 0.61, size.height * (0.28 + (0.01 * t)))
          ..lineTo(size.width * 0.76, size.height * (0.28 + (0.01 * t)));
    }

    canvas.drawPath(leftPath, paint);
    canvas.drawPath(rightPath, paint);
  }

  void _drawMouth(Canvas canvas, Size size, Paint paint, double t) {
    switch (mood) {
      case Mood.happy:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * (0.58 - (0.01 * t))),
            width: size.width * 0.42,
            height: size.height * (0.28 + (0.06 * t)),
          ),
          0.2,
          2.7 + (0.2 * t),
          false,
          paint,
        );
      case Mood.excited:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * (0.60 - (0.01 * t))),
            width: size.width * 0.44,
            height: size.height * (0.36 + (0.08 * t)),
          ),
          0.15,
          2.85 + (0.28 * t),
          false,
          paint,
        );
      case Mood.calm:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(
              size.width * 0.5,
              size.height * (0.63 - (0.004 * t)),
            ),
            width: size.width * 0.40,
            height: size.height * (0.16 + (0.02 * t)),
          ),
          0.45,
          2.3,
          false,
          paint,
        );
      case Mood.neutral:
        final Path neutralMouth = Path()
          ..moveTo(size.width * 0.35, size.height * (0.62 - (0.004 * t)))
          ..lineTo(size.width * 0.65, size.height * (0.62 - (0.004 * t)));
        canvas.drawPath(neutralMouth, paint);
      case Mood.anxious:
        final double jitter = ui.lerpDouble(0, size.height * 0.01, t)!;
        final Path anxiousMouth = Path()
          ..moveTo(size.width * 0.35, size.height * (0.65 + jitter))
          ..lineTo(size.width * 0.42, size.height * (0.60 - jitter))
          ..lineTo(size.width * 0.50, size.height * (0.66 + jitter))
          ..lineTo(size.width * 0.58, size.height * (0.60 - jitter))
          ..lineTo(size.width * 0.65, size.height * (0.65 + jitter));
        canvas.drawPath(anxiousMouth, paint);
      case Mood.sad:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * (0.72 + (0.01 * t))),
            width: size.width * 0.42,
            height: size.height * (0.25 + (0.03 * t)),
          ),
          3.5,
          2.6,
          false,
          paint,
        );
      case Mood.tired:
        final Path tiredMouth = Path()
          ..moveTo(size.width * 0.35, size.height * (0.67 + (0.008 * t)))
          ..lineTo(size.width * 0.65, size.height * (0.67 + (0.008 * t)));
        canvas.drawPath(tiredMouth, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood ||
        oldDelegate.animationValue != animationValue;
  }
}
