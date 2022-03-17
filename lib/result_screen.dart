import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class Result extends StatelessWidget {
  Result({Key? key}) : super(key: key);
  bool isMale = false;
  int age = 1;

/*
  Text myText(String txt) {
    return Text(
      'Gender:$txt',
    );
    //   style: Theme.of(context).textTheme.headline2,);
  }
  */

  @override
  Widget build(BuildContext context) {
    isMale = Provider.of<HomeProvider>(context).isMale;
    age = Provider.of<HomeProvider>(context).age;
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Gender:${isMale ? 'Male' : 'Female'}',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Age:$age',
                style: Theme.of(context).textTheme.headline2,
              ),
              Consumer<HomeProvider>(
                builder: (BuildContext, value, child) => Text(
                  'Result:${value.result.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
              Consumer<HomeProvider>(
                builder: (BuildContext, value, child) => Text(
                  'Health:${value.resultText}',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
