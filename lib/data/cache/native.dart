import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'intern_db.dart';

InternDb openConnection() {
  final db = LazyDatabase(() async {
    final folder = await getApplicationDocumentsDirectory();
    final file = File(p.join(folder.path, "intern.sqlite"));
    return NativeDatabase(file);
  });
  return InternDb(db);
}