import 'package:flutter/material.dart';
import 'dart:math';


class Perceptron {
  int p;
  double r;
  Perceptron(this.p, this.r);

  double w1 = 0;
  double w2 = 0;

  calculateSignal(point) {
    double x1 = point[0].toDouble();
    double x2 = point[1].toDouble();
    return this.w1 * x1 + w2 * x2;
  }

  getDelta(y) {
    double delta = this.p - y;
    if (delta > 0) {
      return delta;
    }
    return 0;
  }

  weightAdjustment(point, delta) {
    double x1 = point[0].toDouble();
    double x2 = point[1].toDouble();
    this.w1 += delta * x1 * this.r;
    this.w2 += delta * x2 * this.r;
  }

  learn(input, maxIterations, maxTime) {
    double time = 0;
    int iterations = 0;

    while (maxIterations > iterations && maxTime > time) {
      var startDate = DateTime.now().microsecondsSinceEpoch;
      for (final value in input) {
        var y = this.calculateSignal(value);
        var delta = this.getDelta(y);

        this.weightAdjustment(value, delta);
      }
      var endDate = DateTime.now().microsecondsSinceEpoch;
      time += (endDate - startDate) / 1000;
      iterations++;
    }
    return [w1, w2, time, iterations];
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomePage> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Perceptron'),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      PerceptionPage(),
    ];
    return IndexedStack(
      index: page,
      children: pages,
    );
  }
}

class PerceptionPage extends StatefulWidget {
  PerceptionPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __PerceptionPageState();
  }
}

class __PerceptionPageState extends State<PerceptionPage> {
  double w1;
  double w2;
  int iterations;
  double time;

  final iterationsTextController = TextEditingController();
  final maxTimeTextController = TextEditingController();
  final learningRateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  Widget getBody() {
    return Center(
      child: ListView
        (children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 80.0),
        ),
        Container(
          width: 300,
          child: TextField(
            controller: iterationsTextController,
            decoration: InputDecoration(
              hintText: 'Iterations',
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          width: 300,
          child: TextField(
            controller: maxTimeTextController,
            decoration: InputDecoration(
              hintText: 'Deadline',
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          width: 300,
          child: TextField(
            controller: learningRateTextController,
            decoration: InputDecoration(
              hintText: 'Learning speed',
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Calculate'),
          onPressed: ()  {
              var rng = new Random();

              void randomValues(){


                var learningRate = rng.nextInt(10).toDouble();
                var maxTime = rng.nextInt(10).toDouble();
                var maxIterations = rng.nextInt(10).toDouble();

                var result = new Perceptron(4, learningRate).learn([
                  [0, 6],
                  [1, 5],
                  [3, 3],
                  [2, 4]
                ], maxIterations, maxTime);


              }
              while(true) {
                var timeStart = DateTime.now().millisecondsSinceEpoch;
                var iterations = 0;
                randomValues();
                if(DateTime.now().millisecondsSinceEpoch - timeStart > 3000)
                  return;

                iterations++;
              }
              AlertDialog(
                  title : Text("Iterations"),
                  content: Text("$iterations"),
                  actions: [
                  ]);


            },

          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child:
              Text('W1: ${this.w1 ?? ' '}', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child:
              Text('W2: ${this.w2 ?? ' '}', style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Time: ${this.time ?? ' '}',
                  style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Iterations: ${this.iterations ?? ' '}',
                  style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ]),
    );
  }
}