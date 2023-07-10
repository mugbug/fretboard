import 'package:example/app/app.dart';
import 'package:example/song/song_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders SongPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(SongPage), findsOneWidget);
    });
  });
}
