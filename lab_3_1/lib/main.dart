import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

  List<int> fermatsMethod(int n) {
    int x = sqrt(n).ceil();

    int y2 = x * x - n;
    int y = sqrt(y2).toInt();

    while(y2 != y * y)
    {
      x++;
      y2 = x * x - n;
      y = sqrt(y2).toInt();
    }
    return [x - y, x + y];
}



class _State extends State<MyApp> {
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Fermat\'s Factorization'),
        ),
        body:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: numberController,
                    obscureText: false,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter number',
                      hintText: 'Number',
                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Calculate'),
                  onPressed: () {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        String content;
                        try {
                          int number = int.parse(numberController.text);
                          var fermatResult = fermatsMethod(number);
                          content = "${fermatResult[0]} \* ${fermatResult[1]}";
                        } catch (e) {
                          content = "Invalid input";
                        }
                        var dialog = AlertDialog(
                          title: Text("Result"),
                          content: new Text(content),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                        return dialog;
                      },
                    );
                  },
                )
              ],
            ));
  }
}