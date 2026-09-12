import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_cpr/database.dart';
import 'package:auto_cpr/main.dart';

void main() {
  testWidgets('App renders successfully and connects to test database',
      (WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(MyApp(database: db));
    await tester.pumpAndSettle();

    expect(find.text('Drift Database Test'), findsOneWidget);
    expect(find.text('Koneksi Database Berhasil!'), findsOneWidget);

    await db.close();
  });
}
