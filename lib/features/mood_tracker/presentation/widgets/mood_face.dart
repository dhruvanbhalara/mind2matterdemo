import 'package:flutter/material.dart';

import '../../domain/entities/mood.dart';

class MoodFace extends StatelessWidget {
  const MoodFace({required this.mood, required this.size, super.key});

  final Mood mood;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: MoodFacePainter(mood: mood),
    );
  }
}

class MoodFacePainter extends CustomPainter {
  MoodFacePainter({required this.mood});

  final Mood mood;

  @override
  void paint(Canvas canvas, Size size) {
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

    final double eyeY = size.height * 0.38;
    final double eyeSpread = size.width * 0.18;
    final double eyeRadius = size.width * 0.04;

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

    _drawEyebrows(canvas, size, featurePaint);
    _drawMouth(canvas, size, featurePaint);
  }

  void _drawEyebrows(Canvas canvas, Size size, Paint paint) {
    final Path leftPath = Path();
    final Path rightPath = Path();

    switch (mood) {
      case Mood.happy:
        leftPath
          ..moveTo(size.width * 0.25, size.height * 0.26)
          ..quadraticBezierTo(
            size.width * 0.32,
            size.height * 0.20,
            size.width * 0.38,
            size.height * 0.26,
          );
        rightPath
          ..moveTo(size.width * 0.62, size.height * 0.26)
          ..quadraticBezierTo(
            size.width * 0.68,
            size.height * 0.20,
            size.width * 0.75,
            size.height * 0.26,
          );
      case Mood.excited:
        leftPath
          ..moveTo(size.width * 0.25, size.height * 0.24)
          ..lineTo(size.width * 0.38, size.height * 0.18);
        rightPath
          ..moveTo(size.width * 0.62, size.height * 0.18)
          ..lineTo(size.width * 0.75, size.height * 0.24);
      case Mood.calm:
        leftPath
          ..moveTo(size.width * 0.25, size.height * 0.26)
          ..quadraticBezierTo(
            size.width * 0.32,
            size.height * 0.23,
            size.width * 0.38,
            size.height * 0.26,
          );
        rightPath
          ..moveTo(size.width * 0.62, size.height * 0.26)
          ..quadraticBezierTo(
            size.width * 0.68,
            size.height * 0.23,
            size.width * 0.75,
            size.height * 0.26,
          );
      case Mood.neutral:
        leftPath
          ..moveTo(size.width * 0.25, size.height * 0.24)
          ..lineTo(size.width * 0.38, size.height * 0.24);
        rightPath
          ..moveTo(size.width * 0.62, size.height * 0.24)
          ..lineTo(size.width * 0.75, size.height * 0.24);
      case Mood.anxious:
        leftPath
          ..moveTo(size.width * 0.25, size.height * 0.30)
          ..lineTo(size.width * 0.38, size.height * 0.22);
        rightPath
          ..moveTo(size.width * 0.62, size.height * 0.22)
          ..lineTo(size.width * 0.75, size.height * 0.30);
      case Mood.sad:
        leftPath
          ..moveTo(size.width * 0.25, size.height * 0.24)
          ..lineTo(size.width * 0.38, size.height * 0.29);
        rightPath
          ..moveTo(size.width * 0.62, size.height * 0.29)
          ..lineTo(size.width * 0.75, size.height * 0.24);
      case Mood.tired:
        leftPath
          ..moveTo(size.width * 0.24, size.height * 0.28)
          ..lineTo(size.width * 0.39, size.height * 0.28);
        rightPath
          ..moveTo(size.width * 0.61, size.height * 0.28)
          ..lineTo(size.width * 0.76, size.height * 0.28);
    }

    canvas.drawPath(leftPath, paint);
    canvas.drawPath(rightPath, paint);
  }

  void _drawMouth(Canvas canvas, Size size, Paint paint) {
    switch (mood) {
      case Mood.happy:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * 0.58),
            width: size.width * 0.42,
            height: size.height * 0.28,
          ),
          0.2,
          2.7,
          false,
          paint,
        );
      case Mood.excited:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * 0.60),
            width: size.width * 0.44,
            height: size.height * 0.36,
          ),
          0.15,
          2.85,
          false,
          paint,
        );
      case Mood.calm:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * 0.63),
            width: size.width * 0.40,
            height: size.height * 0.16,
          ),
          0.45,
          2.3,
          false,
          paint,
        );
      case Mood.neutral:
        final Path neutralMouth = Path()
          ..moveTo(size.width * 0.35, size.height * 0.62)
          ..lineTo(size.width * 0.65, size.height * 0.62);
        canvas.drawPath(neutralMouth, paint);
      case Mood.anxious:
        final Path anxiousMouth = Path()
          ..moveTo(size.width * 0.35, size.height * 0.65)
          ..lineTo(size.width * 0.42, size.height * 0.60)
          ..lineTo(size.width * 0.50, size.height * 0.66)
          ..lineTo(size.width * 0.58, size.height * 0.60)
          ..lineTo(size.width * 0.65, size.height * 0.65);
        canvas.drawPath(anxiousMouth, paint);
      case Mood.sad:
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * 0.72),
            width: size.width * 0.42,
            height: size.height * 0.25,
          ),
          3.5,
          2.6,
          false,
          paint,
        );
      case Mood.tired:
        final Path tiredMouth = Path()
          ..moveTo(size.width * 0.35, size.height * 0.67)
          ..lineTo(size.width * 0.65, size.height * 0.67);
        canvas.drawPath(tiredMouth, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood;
  }
}
