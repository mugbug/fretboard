import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// {@template fretboard}
/// Song writing toolkit for Flutter
/// {@endtemplate}
class Fretboard extends StatelessWidget {
  /// {@macro fretboard}
  const Fretboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 300,
        child: CustomPaint(
          painter: FretboardPainter(),
        ),
      ),
    );
  }
}

/// Draws the fretboard
class FretboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawStrings(canvas, size);
    _drawFrets(canvas, size);
  }

  void _drawStrings(Canvas canvas, Size size) {
    final stringPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 3;

    const x0 = .0;
    final x1 = size.width;

    final spacing = size.height / 5;
    final spacingList = List.generate(6, (index) => index * spacing);

    for (final y in spacingList) {
      canvas.drawLine(
        Offset(x0, y),
        Offset(x1, y),
        stringPaint,
      );
    }
  }

  void _drawFrets(Canvas canvas, Size size) {
    final stringPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;

    const y0 = .0;
    final y1 = size.height;

    const numberOfFrets = 5;

    final spacing = size.width / (numberOfFrets - 1);
    final spacingList =
        List.generate(numberOfFrets, (index) => index * spacing);

    for (final x in spacingList) {
      canvas.drawLine(
        Offset(x, y0),
        Offset(x, y1),
        stringPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
