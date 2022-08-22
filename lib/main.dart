//import 'dart:html';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 10, 5),
            child: Text(textAlign: TextAlign.right, "By Rob Britton")),
      ),
      appBar: AppBar(
        title: const Text('First Route'),
      ), //    (:
      body: Center(
        child: Text(
          "Your GPA: " + Main.gpa.toStringAsFixed(2),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});
  static double gpa = 0.0;
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
    return 0;
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
      child: Text("On Level"),
      value: 1,
    ),
    const DropdownMenuItem(
      child: Text("Honors/AP"),
      value: 2,
    ),
    const DropdownMenuItem(
      child: Text("Art/Free"),
      value: 0,
    )
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            gpa = gpaCalculator(classGrade, classType);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FirstRoute()),
            );
          },
          child: Text("Calculate")),
      appBar: AppBar(
        title: Text("EHS GPA Calculator"),
      ),
      body: GridView.count(
          crossAxisSpacing: 5.0,
          childAspectRatio: 1.6,
          crossAxisCount: 3,
          children: [
            Text("Class 1"),
            TextField(
              onChanged: (i) {
                classGrade[0] = double.parse(i);
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
            Text("Class 2"),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (i) {
                classGrade[1] = double.parse(i);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
            Text("Class 3"),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (i) {
                classGrade[2] = double.parse(i);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
            Text("Class 4"),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (i) {
                classGrade[3] = double.parse(i);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
            Text("Class 5"),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (i) {
                classGrade[4] = double.parse(i);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
            Text("Class 6"),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (i) {
                classGrade[5] = double.parse(i);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
            Text("Class 7"),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (i) {
                classGrade[6] = double.parse(i);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
    );
  }
}
