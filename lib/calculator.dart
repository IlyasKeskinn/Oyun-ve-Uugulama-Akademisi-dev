import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = '';
  String result = '';
  List<String> buttons = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff374352),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: ResultWidget(userInput: userInput, result: result),
            ),
            Expanded(
              flex: 2,
              child: buttonsWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget buttonsWidget() {
    return GridView.builder(
        itemCount: buttons.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return button(buttons[index]);
        });
  }

  Container button(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            pressButton(text);
          });
        },
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Colors.white30,
          elevation: 8,
          backgroundColor: const Color(0xff374352),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  void pressButton(String text) {
    if (text == 'AC') {
      result = '';
      userInput = '';
      return;
    }
    if (text == 'C') {
      userInput = userInput.substring(0, userInput.length - 1);
      return;
    }
    if (text == '=') {
      result = calculate();
      if (result.endsWith('.0')) {
        result = result.replaceAll('.0', ' ');
      }
      return;
    }
    userInput += text;
  }

  calculate() {
    try {
      var exp = Parser().parse(userInput);
      var eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      return eval.toString();
    } catch (e) {
      return 'ERROR';
    }
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({
    Key? key,
    required this.userInput,
    required this.result,
  }) : super(key: key);

  final String userInput;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
