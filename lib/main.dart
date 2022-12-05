import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    'year.db',
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

/*Future<List<Year>> year() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('Year');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Year(
      id: maps[i]['id'],
      cl1: maps[i]['cl1'],
      cl2: ,
      cl3: ,

    );
  });
}*/

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calc(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static double gpatotal = 0;
  static bool feild1 = false;
  static bool feild2 = false;
  static bool feild3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
      ),
      body: Column(children: [
        DropdownButton(
            items: [
              const DropdownMenuItem(
                child: Text("Freshman"),
                value: 1,
              ),
              const DropdownMenuItem(
                child: Text("Softmore"),
                value: 2,
              ),
              const DropdownMenuItem(
                child: Text("Junior"),
                value: 3,
              ),
              const DropdownMenuItem(
                child: Text("Senior"),
                value: 4,
              ),
            ],
            onChanged: (value) {
              if (value == 1) {
                feild1 = true;
                false;
              } else {
                feild1 = false;
              }
            }),
        TextField(
          enabled: feild1,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          onChanged: (i) {
            gpatotal = double.parse(i);
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Year 2',
          ),
        ),
      ]),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        elevation: 50,
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
            child: Text(textAlign: TextAlign.right, "By Rob Britton")),
      ),
      appBar: AppBar(
        title: const Text('GPA'),
      ), //    (:
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Your Overall GPA: " + Calc.allgpa.toStringAsFixed(2),
            style: const TextStyle(fontSize: 25),
          ),
          Text(
            "Your Acadmic GPA: " + Calc.gpa.toStringAsFixed(2),
            style: const TextStyle(fontSize: 25),
          ),
        ]),
      ),
    );
  }
}

class Calc extends StatelessWidget {
  const Calc({super.key});
  static double gpa = 0.0;
  static double allgpa = 0.0;
  static List<double> classGrade = List.filled(7, 0, growable: false);
  static var classType = List.filled(7, 0, growable: false);
  int objToInt(x) {
    if (x == 1) {
      return (1);
    }
    if (x == 2) {
      return (2);
    }
    if (x == 0) {
      return (0);
    }
    if (x == 3) {
      return (3);
    }
    if (x == 4) {
      return (4);
    }
    return 0;
  }

  double gpaCalculatorAll(List<double> classGrade, List<int> classType) {
    List<double> classGradeF = List.filled(7, 0, growable: false);
    double preDiv = 0;
    int classCount = 0;
    double gpaF = 0.0;
    int Hclass = 0;
    int pos = 0;
    for (double i in classGrade) {
      if (i >= 93) {
        classGradeF[pos] = 4.0;
      } else if (i >= 90) {
        classGradeF[pos] = 3.7;
      } else if (i >= 87) {
        classGradeF[pos] = 3.3;
      } else if (i >= 83) {
        classGradeF[pos] = 3.0;
      } else if (i >= 80) {
        classGradeF[pos] = 2.7;
      } else if (i >= 77) {
        classGradeF[pos] = 2.3;
      } else if (i >= 73) {
        classGradeF[pos] = 2.0;
      } else if (i >= 70) {
        classGradeF[pos] = 1.7;
      } else if (i >= 67) {
        classGradeF[pos] = 1.3;
      } else if (i >= 63) {
        classGradeF[pos] = 1.0;
      } else if (i >= 60) {
        classGradeF[pos] = 0.7;
      } else {
        classGradeF[pos] = 0.0;
      }
      pos += 1;
    }

    pos = 0;
    for (int i in classType) {
      if (i == 1 || i == 3 || i == 4) {
        classCount += 1;
        preDiv = preDiv + classGradeF[pos];
      }
      if (i == 2) {
        classCount += 1;
        preDiv = preDiv + classGradeF[pos];
        Hclass += 1;
      }
      pos += 1;
    }
    double m1 = preDiv + Hclass;
    return m1 / classCount;
  }

  double gpaCalculator(List<double> classGrade, List<int> classType) {
    List<double> classGradeF = List.filled(7, 0, growable: false);
    double preDiv = 0;
    int classCount = 0;
    double gpaF = 0.0;
    int Hclass = 0;
    int pos = 0;
    for (double i in classGrade) {
      if (i >= 93) {
        classGradeF[pos] = 4.0;
      } else if (i >= 90) {
        classGradeF[pos] = 3.7;
      } else if (i >= 87) {
        classGradeF[pos] = 3.3;
      } else if (i >= 83) {
        classGradeF[pos] = 3.0;
      } else if (i >= 80) {
        classGradeF[pos] = 2.7;
      } else if (i >= 77) {
        classGradeF[pos] = 2.3;
      } else if (i >= 73) {
        classGradeF[pos] = 2.0;
      } else if (i >= 70) {
        classGradeF[pos] = 1.7;
      } else if (i >= 67) {
        classGradeF[pos] = 1.3;
      } else if (i >= 63) {
        classGradeF[pos] = 1.0;
      } else if (i >= 60) {
        classGradeF[pos] = 0.7;
      } else {
        classGradeF[pos] = 0.0;
      }
      pos += 1;
    }

    pos = 0;
    for (int i in classType) {
      if (i == 1) {
        classCount += 1;
        preDiv = preDiv + classGradeF[pos];
      }
      if (i == 2) {
        classCount += 1;
        preDiv = preDiv + classGradeF[pos];
        Hclass += 1;
      }
      pos += 1;
    }
    double m1 = preDiv + Hclass;
    return m1 / classCount;
  }

  static List<DropdownMenuItem<Object>> dropDownItems = [
    const DropdownMenuItem(
      child: Text("Art"),
      value: 4,
    ),
    const DropdownMenuItem(
      child: Text("Religon"),
      value: 3,
    ),
    const DropdownMenuItem(
      child: Text("On Level"),
      value: 1,
    ),
    const DropdownMenuItem(
      child: Text("Honors/AP"),
      value: 2,
    ),
    const DropdownMenuItem(
      child: Text("Free Period"),
      value: 0,
    )
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /*onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },*/
      child: Scaffold(
        floatingActionButton: FloatingActionButton.large(
            onPressed: () {
              allgpa = gpaCalculatorAll(classGrade, classType);
              gpa = gpaCalculator(classGrade, classType);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FirstRoute()),
              );
            },
            child: const Text("Calculate")),
        appBar: AppBar(
          title: const Text("EHS GPA Calculator"),
        ),
        body: GridView.count(
            crossAxisSpacing: 5.0,
            childAspectRatio: 1.6,
            crossAxisCount: 3,
            children: [
              const Center(child: Text("Class 1", textScaleFactor: 1.5)),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                onChanged: (i) {
                  classGrade[0] = double.parse(i);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grade %',
                ),
              ),
              DropdownButtonFormField(
                  value: 0,
                  items: dropDownItems,
                  onChanged: (value) {
                    classType[0] = objToInt(value);
                  }),
              const Center(child: Text("Class 2", textScaleFactor: 1.5)),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                onChanged: (i) {
                  classGrade[1] = double.parse(i);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grade %',
                ),
              ),
              DropdownButtonFormField(
                  value: 0,
                  items: dropDownItems,
                  onChanged: (value) {
                    classType[1] = objToInt(value);
                  }),
              const Center(child: Text("Class 3", textScaleFactor: 1.5)),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                onChanged: (i) {
                  classGrade[2] = double.parse(i);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grade %',
                ),
              ),
              DropdownButtonFormField(
                  value: 0,
                  items: dropDownItems,
                  onChanged: (value) {
                    classType[2] = objToInt(value);
                  }),
              const Center(child: Text("Class 4", textScaleFactor: 1.5)),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                onChanged: (i) {
                  classGrade[3] = double.parse(i);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grade %',
                ),
              ),
              DropdownButtonFormField(
                  value: 0,
                  items: dropDownItems,
                  onChanged: (value) {
                    classType[3] = objToInt(value);
                  }),
              const Center(
                  child: Text(
                "Class 5",
                textScaleFactor: 1.5,
              )),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                onChanged: (i) {
                  classGrade[4] = double.parse(i);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grade %',
                ),
              ),
              DropdownButtonFormField(
                  value: 0,
                  items: dropDownItems,
                  onChanged: (value) {
                    classType[4] = objToInt(value);
                  }),
              const Center(child: Text("Class 6", textScaleFactor: 1.5)),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                onChanged: (i) {
                  classGrade[5] = double.parse(i);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grade %',
                ),
              ),
              DropdownButtonFormField(
                  value: 0,
                  items: dropDownItems,
                  onChanged: (value) {
                    classType[5] = objToInt(value);
                  }),
              const Center(child: Text("Class 7", textScaleFactor: 1.5)),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                onChanged: (i) {
                  classGrade[6] = double.parse(i);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Grade %',
                ),
              ),
              DropdownButtonFormField(
                  value: 0,
                  items: dropDownItems,
                  onChanged: (value) {
                    classType[6] = objToInt(value);
                  }),
            ]),
      ),
    );
  }
}
