import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> button = [
    'C',
    '*',
    '/',
    '<--',
    '1',
    '2',
    '3',
    '-',
    '4',
    '5',
    '6',
    '%',
    '7',
    '8',
    '9',
    '%',
    '+',
    '0',
    '.',
    '=',
  ];
  final numberController = TextEditingController();
  String currentOperator = '';
  double firstOperand = 0.0;

  void handleButtonPress(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          numberController.text = '';
          currentOperator = '';
          firstOperand = 0.0;
          break;
        case '<--':
          if (numberController.text.isNotEmpty) {
            numberController.text = numberController.text
                .substring(0, numberController.text.length - 1);
          }
          break;
        case '=':
          if (currentOperator.isNotEmpty && numberController.text.isNotEmpty) {
            double secondOperand = double.parse(numberController.text);
            double result =
                performOperation(firstOperand, secondOperand, currentOperator);
            numberController.text = result.toString();
            currentOperator = '';
          }
          break;
        case '*':
        case '/':
        case '+':
        case '-':
        case '%':
          if (numberController.text.isNotEmpty) {
            firstOperand = double.parse(numberController.text);
            currentOperator = buttonText;
            numberController.text = '';
          }
          break;
        default:
          numberController.text += buttonText;
      }
    });
  }

  double performOperation(
      double firstOperand, double secondOperand, String operator) {
    switch (operator) {
      case '*':
        return firstOperand * secondOperand;
      case '/':
        return firstOperand / secondOperand;
      case '+':
        return firstOperand + secondOperand;
      case '-':
        return firstOperand - secondOperand;
      case '%':
        return firstOperand % secondOperand;
      default:
        throw Exception('Invalid operator: $operator');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: numberController,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "",
              ),
              validator: (value) =>
                  value!.isEmpty ? "Please enter first name" : null,
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(8),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: 4,
              children: [
                for (int i = 0; i < button.length; i++) ...{
                  SizedBox(
                    child: ElevatedButton(
                      child: Text(
                        button[i],
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () => {handleButtonPress(button[i])},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}
