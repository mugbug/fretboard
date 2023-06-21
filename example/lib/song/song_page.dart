import 'package:flutter/material.dart';
import 'package:fretboard/fretboard.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Fretboard(),
      ),
    );
  }
}