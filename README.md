# 🎸 fretboard

[![Pub](https://img.shields.io/pub/v/fretboard.svg)](https://pub.dev/packages/fretboard)
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Song writing toolkit for Flutter.

## Features

✅ Easily draw a fretboard layout with some note markers.

🚧 Show the note symbol with a letter notation.

🚧 Automatically generate a fretboard drawing based on a given scale name.

## Usage

To draw a simple guitar fretboard you can just instantiate the `Fretboard` widget passing some `Size` and a matrix that represents how the fretboard should be drawn:

```dart
class MyCustomWidget extends StatelessWidget {
  const MyCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Fretboard(
        size: Size(400, 240),
        notesMatrix: [
          ['', 'o', '', '', 'o', ''],
          ['', 'o', '', '', 'o', ''],
          ['', 'o', '', 'o', '', ''],
          ['', 'o', '', '0', '', ''],
          ['', 'o', '', '', 'o', ''],
          ['', '0', '', '', 'o', ''],
        ],
      ),
    );
  }
}
```

![Example Screenshot][screenshot]

## Advanced usage

### Custom theme

You can change the default theme colors by passing a custom `FretboardTheme`:

```dart
Fretboard(
  size: Size(400, 240),
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
```

## Dart Versions

* Dart 3 >= 3.0.0

## Maintainers

* [Pedro Zaroni](https://github.com/mugbug)

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[screenshot]: https://raw.githubusercontent.com/mugbug/fretboard/main/doc/assets/fretboard_demo.png