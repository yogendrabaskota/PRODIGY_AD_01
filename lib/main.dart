import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "×":
          _output = (num1 * num2).toString();
          break;
        case "÷":
          _output = (num1 / num2).toString();
          break;
        default:
          return;
      }

      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(24.0), backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: textColor),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                child: Text(
                  output,
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      buildButton("7", Colors.grey.shade800, Colors.white),
                      buildButton("8", Colors.grey.shade800, Colors.white),
                      buildButton("9", Colors.grey.shade800, Colors.white),
                      buildButton("÷", Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton("4", Colors.grey.shade800, Colors.white),
                      buildButton("5", Colors.grey.shade800, Colors.white),
                      buildButton("6", Colors.grey.shade800, Colors.white),
                      buildButton("×", Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton("1", Colors.grey.shade800, Colors.white),
                      buildButton("2", Colors.grey.shade800, Colors.white),
                      buildButton("3", Colors.grey.shade800, Colors.white),
                      buildButton("-", Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton(".", Colors.grey.shade800, Colors.white),
                      buildButton("0", Colors.grey.shade800, Colors.white),
                      buildButton("00", Colors.grey.shade800, Colors.white),
                      buildButton("+", Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton("CLEAR", Colors.red, Colors.white),
                      buildButton("=", Colors.green, Colors.white),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
