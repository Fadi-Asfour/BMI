import 'package:bmi/home_provider.dart';
import 'package:bmi/result_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double heightVal = 150;
  @override
  Widget build(BuildContext context) {
    heightVal = Provider.of<HomeProvider>(context).heightVal;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI'),
      ),
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(children: [
                    maleAndFemale(context, 'Male'),
                    SizedBox(
                      width: 15,
                    ),
                    maleAndFemale(context, 'Female'),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Consumer<HomeProvider>(
                                builder: (BuildContext, value, child) => Text(
                                  value.heightVal.toStringAsFixed(1),
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              Text(
                                'CM',
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ]),
                        Slider(
                          min: 10,
                          max: 310,
                          value: heightVal,
                          divisions: 3000,
                          // activeColor: Colors.yellow,
                          // inactiveColor: Colors.red,
                          // label: 'LENGTH',
                          onChanged: (double newVal) =>
                              Provider.of<HomeProvider>(context, listen: false)
                                  .changeHeightVal(newVal),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(children: [
                    expanded2(context, 'weight'),
                    SizedBox(
                      width: 15,
                    ),
                    expanded2(context, 'age')
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.teal,
                  height: MediaQuery.of(context).size.height / 16,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        Provider.of<HomeProvider>(context, listen: false)
                            .Health();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Result()));
                      },
                      child: Text(
                        'Calculate',
                        style: Theme.of(context).textTheme.headline2,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded maleAndFemale(BuildContext context, String type) {
    bool isMale = Provider.of<HomeProvider>(context).isMale;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Consumer<HomeProvider>(builder: (BuildContext,value,child)=>)
          Provider.of<HomeProvider>(context, listen: false).changeIsMale(type);
        },
        /*onDoubleTap: () {
          print('ggggggggggg00');
        },*/

        child: Container(
          decoration: BoxDecoration(
              color: (isMale && type == 'Male' || !isMale && type == 'Female')
                  ? Colors.teal
                  : Colors.white70,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                type == 'Male' ? Icons.male : Icons.female,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(type == 'Male' ? 'Male' : 'Female',
                  style: Theme.of(context).textTheme.headline2)
            ],
          ),
        ),
      ),
    );
  }

  Expanded expanded2(BuildContext context, String type) {
    int age = Provider.of<HomeProvider>(context).age;
    double weight = Provider.of<HomeProvider>(context).weight;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(type == 'weight' ? 'weight' : 'age',
                style: Theme.of(context).textTheme.headline2),
            Text(type == 'weight' ? '$weight' : '$age',
                style: Theme.of(context).textTheme.headline2),
            // SizedBox(
            //   height: 10,
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age--' : 'weight--',
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .decreaseAgeOrWeight(type);
                  },
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age++' : 'weight++',
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .increaseAgeOrWeight(type);
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
