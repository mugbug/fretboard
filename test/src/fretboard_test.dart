import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fretboard/fretboard.dart';

void main() {
  group('Fretboard', () {
    goldenTest(
      'renders correctly',
      fileName: 'fretboard',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 600,
        ),
        children: [
          GoldenTestScenario(
            name: 'basic',
            child: const Fretboard(
              size: Size(400, 200),
              notesMatrix: [
                ['', 'o', '', '', 'o', ''],
                ['', 'o', '', '', 'o', ''],
                ['', 'o', '', 'o', '', ''],
                ['', 'o', '', '0', '', ''],
                ['', 'o', '', '', 'o', ''],
                ['', '0', '', '', 'o', ''],
              ],
            ),
          ),
          GoldenTestScenario(
            name: 'custom theme',
            child: const Fretboard(
              size: Size(400, 200),
              theme: FretboardTheme(
                tonicColor: Colors.green,
                noteColor: Colors.pink,
                fretColor: Colors.grey,
                stringColor: Colors.black,
              ),
              notesMatrix: [
                ['', 'o', '', '', 'o', ''],
                ['', 'o', '', '', 'o', ''],
                ['', 'o', '', 'o', '', ''],
                ['', 'o', '', '0', '', ''],
                ['', 'o', '', '', 'o', ''],
                ['', '0', '', '', 'o', ''],
              ],
            ),
          )
        ],
      ),
    );
  });
}
