
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() =>
      _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final firstNumberController = TextEditingController();
  final secondNumberController = TextEditingController();

  String result = '0';
  String operationLabel = 'Enter two numbers';

  // CALCULATION FUNCTION
  void calculate(String operation) {
    final first =
        double.tryParse(firstNumberController.text.trim());

    final second =
        double.tryParse(secondNumberController.text.trim());

    if (first == null ||
        second == null ||
        !first.isFinite ||
        !second.isFinite) {
      setState(() {
        result = 'Invalid input';
        operationLabel = 'Please enter two valid numbers';
      });
      return;
    }

    if (operation == '÷' && second == 0) {
      setState(() {
        result = 'Cannot divide by zero';
        operationLabel = 'Please change the second number';
      });
      return;
    }

    double answer;

    switch (operation) {
      case '+':
        answer = first + second;
        break;
      case '-':
        answer = first - second;
        break;
      case '×':
        answer = first * second;
        break;
      case '÷':
        answer = first / second;
        break;
      default:
        return;
    }

    setState(() {
      result = answer.toString();
      operationLabel = '$first $operation $second';
    });
  }

  // CLEAR FUNCTION
  void clearCalculator() {
    firstNumberController.clear();
    secondNumberController.clear();

    setState(() {
      result = '0';
      operationLabel = 'Enter two numbers';
    });
  }

  // RELEASE CONTROLLERS
  @override
  void dispose() {
    firstNumberController.dispose();
    secondNumberController.dispose();
    super.dispose();
  }

  // OPERATION BUTTON
  Widget operationButton(String symbol) {
    return SizedBox(
      width: 88,
      height: 52,
      child: ElevatedButton(
        onPressed: () => calculate(symbol),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE8EAF6),
          foregroundColor: Colors.indigo,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          symbol,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // MAIN DESIGN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),

      // APP BAR
      appBar: AppBar(
        title: const Text('My Stateful Calculator'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 950,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // CALCULATOR ICON
                const Icon(
                  Icons.calculate,
                  size: 64,
                  color: Colors.indigo,
                ),

                const SizedBox(height: 28),

                // TITLE
                const Text(
                  'BASIC CALCULATOR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                  ),
                ),

                const SizedBox(height: 38),

                // FIRST NUMBER
                TextField(
                  controller: firstNumberController,
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'First Number',
                    prefixIcon: Icon(Icons.looks_one),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // SECOND NUMBER
                TextField(
                  controller: secondNumberController,
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Second Number',
                    prefixIcon: Icon(Icons.looks_two),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // FOUR OPERATION BUTTONS
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    operationButton('+'),
                    operationButton('-'),
                    operationButton('×'),
                    operationButton('÷'),
                  ],
                ),

                const SizedBox(height: 28),

                // RESULT DISPLAY
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 38,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFF90CAF9),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [

                      Text(
                        operationLabel,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF555555),
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'RESULT',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF555555),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        result,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // CLEAR BUTTON
                SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: clearCalculator,
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      'Clear',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                      side: const BorderSide(
                        color: Color(0xFF90A4AE),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // STUDENT INFORMATION
                const Text(
                  'Created by:Gerude Ordonio'
                  
                ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF555555),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
