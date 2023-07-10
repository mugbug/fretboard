// ignore_for_file: prefer_const_constructors

import 'dart:ui';

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
            child: Fretboard(
              size: Size(400, 200),
              notesMatrix: const [
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
