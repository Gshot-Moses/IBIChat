import 'package:drift/web.dart';
import 'package:drift_dev/moor_generator.dart';
import 'intern_db.dart';

InternDb openConnection() {
  return InternDb(WebDatabase("intern"));
}