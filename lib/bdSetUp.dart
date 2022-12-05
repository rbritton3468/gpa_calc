import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'year.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE Year(id INTEGER PRIMARY KEY,cl1 REAl, cln1 INTEGER,cl2 REAl, cln2 INTEGER,cl3 REAl, cln3 INTEGER,cl4 REAl, cln4 INTEGER,cl5 REAl, cln5 INTEGER,cl6 REAl, cln6 INTEGER,cl7 REAl, cln7 INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
  Future<void> insertYear(Year year) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'Year',
      year.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  var y1 = const Year(
      id: 1,
      cl1: 2,
      cln1: 4,
      cl2: 6,
      cln2: 7,
      cl3: 8,
      cln3: 8,
      cl4: 8,
      cln4: 9,
      cl5: 6,
      cln5: 6,
      cl6: 4,
      cln6: 3,
      cl7: 4,
      cln7: 3);

  await insertYear(y1);
}

class Year {
  final int id;
  final int cl1;
  final int cln1;
  final int cl2;
  final int cln2;
  final int cl3;
  final int cln3;
  final int cl4;
  final int cln4;
  final int cl5;
  final int cln5;
  final int cl6;
  final int cln6;
  final int cl7;
  final int cln7;

  const Year({
    required this.id,
    required this.cl1,
    required this.cln1,
    required this.cl2,
    required this.cln2,
    required this.cl3,
    required this.cln3,
    required this.cl4,
    required this.cln4,
    required this.cl5,
    required this.cln5,
    required this.cl6,
    required this.cln6,
    required this.cl7,
    required this.cln7,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cl1': cl1,
      'cln1': cln1,
      'cl2': cl2,
      'cln2': cln2,
      'cl3': cl3,
      'cln3': cln3,
      'cl4': cl4,
      'cln4': cln4,
      'cl5': cl5,
      'cln5': cln5,
      'cl6': cl6,
      'cln6': cln6,
      'cl7': cl7,
      'cln7': cln7,
    };
  }
}
