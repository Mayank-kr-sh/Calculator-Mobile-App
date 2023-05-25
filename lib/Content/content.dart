import 'dart:math';

import 'package:calculator/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double firstNum = 0.0;
  double secNum = 0.0;
  var input = '';
  var output = '';
  var oper = '';
  var hideInput = false;

  onButtonClicked(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == 'CE') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        userInput = input.replaceAll("÷", "/");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cntx = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cntx);
        output = finalValue.toString();
        if (output.endsWith('0.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
      }
    } else {
      input = input + value;
      hideInput = false;
    }
    setState(() {});
  }

  Widget button({
    text,
    tColor = Colors.white,
    bgColor = buttColor,
  }) {
    return Expanded(
      child: Container(
        height: 80,
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            padding: const EdgeInsets.all(20),
            backgroundColor: bgColor,
            //foregroundColor: Colors.white,
          ),
          onPressed: () => onButtonClicked(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 22,
              color: tColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 28, bottom: 22),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 8, 8, 8),
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? '' : input,
                      style: const TextStyle(
                        fontSize: 48,
                        color: Color.fromARGB(255, 234, 234, 234),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      output,
                      style: const TextStyle(
                        fontSize: 35,
                        color: Color.fromARGB(255, 81, 80, 80),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                button(text: "AC", bgColor: operColor, tColor: orangeColor),
                button(text: "CE", bgColor: operColor),
                button(text: "+/-", bgColor: operColor),
                button(text: "÷", bgColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "7"),
                button(text: "8"),
                button(text: "9"),
                button(text: "x", bgColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "4"),
                button(text: "5"),
                button(text: "6"),
                button(text: "-", bgColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "1"),
                button(text: "2"),
                button(text: "3"),
                button(text: "+", bgColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "%", bgColor: operColor),
                button(text: "0", bgColor: operColor),
                button(text: ".", bgColor: operColor),
                button(text: "=", bgColor: orangeColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
