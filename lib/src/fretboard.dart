// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// {@template fretboardtheme}
/// The theme used to draw the fretboard and the notes.
/// 
/// {@endtemplate}
class FretboardTheme {
  /// {@macro fretboardtheme}
  const FretboardTheme({
    required this.tonicColor,
    required this.noteColor,
    required this.fretColor,
    required this.stringColor,
  });

  /// The color to draw the circle that represents
  /// the tonic `'0'` note.
  final Color tonicColor;

  /// The color to draw the circle that represents
  /// a normal `'o'` note.
  final Color noteColor;

  /// The color to draw the line that represents
  /// the guitar frets.
  final Color fretColor;

  /// The color to draw the line that represents
  /// the guitar strings.
  final Color stringColor;
}

/// {@template fretboard}
/// A highly customizable guitar fretboard layout
/// that can be built using a string matrix.
///
/// {@macro fretboard.notesMatrix}
///
/// {@endtemplate}
class Fretboard extends StatelessWidget {
  /// {@macro fretboard}
  const Fretboard({
    required this.size,
    required this.notesMatrix,
    this.theme = const FretboardTheme(
      tonicColor: Colors.red,
      noteColor: Colors.blue,
      fretColor: Colors.black,
      stringColor: Colors.grey,
    ),
    super.key,
  });

  /// {@template fretboard.size}
  /// The layout space to use when drawing the fretboard.
  /// {@endtemplate}
  final Size size;

  /// {@template fretboard.notesMatrix}
  /// ```dart
  /// Fretboard(
  ///   size: Size(200, 200),
  ///   notesMatrix: [
  ///     ['', '', 'o', '', ],
  ///     ['', '', 'o', '', ],
  ///     ['', '', '', '', ],
  ///     ['', '', '', '', ],
  ///     ['', 'o', '', '', ],
  ///     ['', '', 'o', '', ],
  ///   ],
  /// ),
  /// ```
  ///
  /// * `''`: will draw empty frets.
  /// * `'0'` and `'o'`: will draw a circle on the fret,
  /// but with different colors.
  /// {@endtemplate}
  final List<List<String>> notesMatrix;

  /// {@macro fretboardtheme}
  final FretboardTheme theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: CustomPaint(
          painter: _FretboardPainter(
            notesMatrix: notesMatrix,
            theme: theme,
          ),
        ),
      ),
    );
  }
}

/// Draws the fretboard
class _FretboardPainter extends CustomPainter {
  _FretboardPainter({
    required this.notesMatrix,
    required this.theme,
  });

  final List<List<String>> notesMatrix;

  final FretboardTheme theme;

  int get _numberOfFrets => notesMatrix.first.length;

  @override
  void paint(Canvas canvas, Size size) {
    _drawStrings(canvas, size);
    _drawFrets(canvas, size);
    _drawNotes(canvas, size);
  }

  void _drawStrings(Canvas canvas, Size size) {
    final stringPaint = Paint()
      ..color = theme.stringColor
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
      ..color = theme.fretColor
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
          ..color = theme.tonicColor
          ..style = PaintingStyle.fill;

        final notePaint = Paint()
          ..color = theme.noteColor
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
