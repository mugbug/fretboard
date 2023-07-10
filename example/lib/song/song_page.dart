import 'package:flutter/material.dart';
import 'package:fretboard/fretboard.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Fretboard(
          size: Size(400, 240),
          theme: FretboardTheme(
            tonicColor: Color.fromARGB(255, 208, 83, 74),
            noteColor: Color.fromARGB(255, 69, 140, 198),
            fretColor: Colors.black,
            stringColor: Colors.grey,
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
      ),
    );
  }
}
