import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_cpr/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    // Gunakan in-memory database agar cepat dan terisolasi untuk testing
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('Koneksi dan operasi CRUD dasar database Drift berhasil', () async {
    // 1. Pastikan tabel awalnya kosong
    final initialItems = await db.select(db.testItems).get();
    expect(initialItems, isEmpty);

    // 2. Insert data test
    await db.into(db.testItems).insert(
          TestItemsCompanion.insert(content: 'Test Entry 1'),
        );

    // 3. Verifikasi data berhasil tersimpan
    final itemsAfterInsert = await db.select(db.testItems).get();
    expect(itemsAfterInsert.length, 1);
    expect(itemsAfterInsert.first.content, 'Test Entry 1');

    // 4. Hapus data
    await db.delete(db.testItems).go();
    final itemsAfterDelete = await db.select(db.testItems).get();
    expect(itemsAfterDelete, isEmpty);
  });
}
