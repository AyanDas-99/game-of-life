import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool playing = false;

  var data = List.generate(50, (index) {
    return List.generate(50, (i) {
      if (((index == 10 || index == 14 || index == 23 || index == 22 || index == 49 || index == 48) &&
          (i == 10 || i == 12 || i == 13 || i == 22 || i == 23 || i == 49))) {
        return 1;
      }
      return 0;
    });
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !playing
          ? Center(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      playing = true;
                      _periodicUpdate();
                    });
                  },
                  child: Text("Start")),
            )
          : Center(
              child: _buildTable(data),
            ),
    );
  }

  _periodicUpdate() {
    Timer.periodic(const Duration(milliseconds: 5), (timer) {
      nextGeneration();
    });
  }

  nextGeneration() {
    for (var i = 1; i < data.length - 1; i++) {
      for (var j = 1; j < data[0].length - 1; j++) {
        int neighboringOnes = 0;
        neighboringOnes += data[i][j - 1];
        neighboringOnes += data[i][j + 1];
        neighboringOnes += data[i - 1][j];
        neighboringOnes += data[i + 1][j];
        neighboringOnes += data[i - 1][j - 1];
        neighboringOnes += data[i + 1][j - 1];
        neighboringOnes += data[i + 1][j - 1];
        neighboringOnes += data[i + 1][j + 1];
        neighboringOnes += data[i - 1][j + 1];

        // rules
        if (neighboringOnes >= 4 || neighboringOnes <= 1) {
          //death of over population or loneliness
          data[i][j] = 0;
        } else if (neighboringOnes == 3) {
          // birth if 3 neighbours are alive
          data[i][j] = 1;
        }
      }
    }
    print("update");
    setState(() {});
  }

  Table _buildTable(List<List<int>> arr) {
    return Table(
      children: arr.map((row) {
        return TableRow(
            children: row
                .map((pixel) => AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          color: (pixel == 1) ? Colors.black : Colors.white,
                        ),
                        // height: 7,
                      ),
                    ))
                .toList());
      }).toList(),
    );
  }
}
