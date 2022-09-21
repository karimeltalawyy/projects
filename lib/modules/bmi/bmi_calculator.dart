import 'package:flutter/material.dart';
import 'package:test_one/modules/bmi/bmi_result.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        title: const Text(
          'BMI Calculator',
          style: TextStyle(color: Color.fromARGB(255, 119, 0, 255)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromARGB(255, 68, 67, 67),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.search,
                            size: 36,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Male',
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromARGB(255, 68, 67, 67),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.search,
                            size: 36,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Male',
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color.fromARGB(255, 68, 67, 67),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Height',
                      style: TextStyle(color: Colors.black, fontSize: 28),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: const [
                        Text(
                          '180',
                          style: TextStyle(color: Colors.black, fontSize: 28),
                        ),
                        Text(
                          'CM',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    Slider(
                      value: 120,
                      max: 220,
                      min: 60,
                      onChanged: (value) => print(value.round()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromARGB(255, 68, 67, 67),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Age',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              '180',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'remove',
                                  onPressed: () {},
                                  mini: true,
                                  child: const Icon(Icons.remove),
                                ),
                                FloatingActionButton(
                                  heroTag: 'add',
                                  onPressed: () {},
                                  mini: true,
                                  child: const Icon(Icons.add),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromARGB(255, 68, 67, 67),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Age',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              '180',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'Age remove',
                                  onPressed: () {},
                                  mini: true,
                                  child: const Icon(Icons.remove),
                                ),
                                FloatingActionButton(
                                  heroTag: 'Age Add',
                                  onPressed: () {},
                                  mini: true,
                                  child: const Icon(Icons.add),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.deepPurple,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BmiResultScreen()));
              },
              child: const Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
