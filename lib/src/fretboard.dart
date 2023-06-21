// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// {@template fretboard}
/// Song writing toolkit for Flutter
/// {@endtemplate}
class Fretboard extends StatelessWidget {
  /// {@macro fretboard}
  const Fretboard({
    super.key,
    required this.notesMatrix,
    required this.size,
  });

  final Size size;

  final List<List<String>> notesMatrix;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: CustomPaint(
          painter: FretboardPainter(
            notesMatrix: notesMatrix,
          ),
        ),
      ),
    );
  }
}

/// Draws the fretboard
class FretboardPainter extends CustomPainter {
  FretboardPainter({required this.notesMatrix});

  final List<List<String>> notesMatrix;

  int get _numberOfFrets => notesMatrix.first.length;

  @override
  void paint(Canvas canvas, Size size) {
    _drawStrings(canvas, size);
    _drawFrets(canvas, size);
    _drawNotes(canvas, size);
  }

  void _drawStrings(Canvas canvas, Size size) {
    final stringPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 3;

    const x0 = .0;
    final x1 = size.width;

    const numberOfStrings = 6;

    final spacing = size.height / (numberOfStrings - 1);
    final spacingList =
        List.generate(numberOfStrings, (index) => index * spacing);

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

    final spacing = size.width / _numberOfFrets;
    final spacingList =
        List.generate(_numberOfFrets + 1, (index) => index * spacing);

    for (final x in spacingList) {
      canvas.drawLine(
        Offset(x, y0),
        Offset(x, y1),
        stringPaint,
      );
    }
  }

  void _drawNotes(Canvas canvas, Size size) {
    const numberOfStrings = 6;

    final xSpacing = size.width / _numberOfFrets;
    final ySpacing = size.height / (numberOfStrings - 1);

    /// we need this offset to place the notes between frets
    final leadingOffset = xSpacing / 2;

    final noteMapping = notesMatrix.asMap().entries.map((stringListEntry) {
      final yIndex = stringListEntry.key;
      return stringListEntry.value.asMap().entries.map(
        (noteEntry) {
          final xIndex = noteEntry.key;
          final currentPosition = Offset(
            xIndex * xSpacing + leadingOffset,
            yIndex * ySpacing,
          );

          return switch (noteEntry.value) {
            'o' => Note(type: NoteType.normal, position: currentPosition),
            '0' => Note(type: NoteType.tonic, position: currentPosition),
            _ => Note(type: NoteType.none, position: currentPosition),
          };
        },
      );
    });

    for (final notes in noteMapping) {
      for (final note in notes) {
        final tonicPaint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;

        final notePaint = Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;

        final paint = switch (note.type) {
          NoteType.tonic => tonicPaint,
          NoteType.normal => notePaint,
          _ => null
        };

        if (paint == null) continue;

        canvas.drawCircle(
          note.position,
          10,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

enum NoteType { none, normal, tonic }

class Note {
  Note({
    required this.position,
    required this.type,
  });

  final Offset position;
  final NoteType type;
}
