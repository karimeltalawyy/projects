import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_one/modules/bmi_app/bmi/bmi_result.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  bool isMale = true;
  double height = 120;
  int age = 20;
  double weight = 60;
  Color containerColor = const Color.fromARGB(39, 238, 238, 238);
  Color defaultColor = const Color.fromARGB(255, 200, 80, 72);

  // var result = weight / pow(height / 100, 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        title: const Text(
          'BMI CALCULATOR',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: 'Satoshi',
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 18, 18, 18),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              isMale = true;
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isMale ? defaultColor : containerColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.male,
                                size: isMale ? 56 : 42,
                                color: isMale ? Colors.white : Colors.grey,
                              ),
                              Text(
                                'MALE',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w700,
                                  color: isMale ? Colors.white : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: !isMale ? defaultColor : containerColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.female,
                                size: !isMale ? 56 : 42,
                                color: !isMale ? Colors.white : Colors.grey,
                              ),
                              Text(
                                'FEMALE',
                                style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: !isMale ? Colors.white : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: containerColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Height',
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${height.round()}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontFamily: 'Satoshi medium',
                            ),
                          ),
                          const Text(
                            'CM',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontFamily: 'Satoshi reg',
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        activeColor: defaultColor,
                        inactiveColor: containerColor,
                        value: height,
                        onChanged: (value) {
                          print(value.round());
                          setState(() {
                            height = value;
                          });
                        },
                        max: 200,
                        min: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: containerColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Age',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$age',
                              style: const TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.w700,
                                color: Colors.grey,
                                fontFamily: 'Satoshi medium',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  heroTag: 'age++',
                                  mini: true,
                                  backgroundColor: defaultColor,
                                  child: const Icon(Icons.add),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                  heroTag: 'age--',
                                  mini: true,
                                  backgroundColor: defaultColor,
                                  child: const Icon(Icons.remove),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: containerColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'Satoshi',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${weight.round()}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontFamily: 'Satoshi medium',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                  heroTag: 'Weight++',
                                  mini: true,
                                  backgroundColor: defaultColor,
                                  child: const Icon(Icons.add),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                  heroTag: 'Weight--',
                                  mini: true,
                                  backgroundColor: defaultColor,
                                  child: const Icon(Icons.remove),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: defaultColor,
              child: MaterialButton(
                onPressed: () {
                  double result = weight / pow(height / 100, 2);
                  print(result.round());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BmiResultScreen(
                        result: result,
                        age: age,
                        isMale: isMale,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'CALCULATE',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
