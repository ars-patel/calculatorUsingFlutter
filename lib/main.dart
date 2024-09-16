import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class AppColors {
  static const Color primaryColor = Color(0xFF212224);
  static const Color secondaryColor = Color(0xFF317AF7);
  static const Color secondary2Color = Color(0xFF26282D);
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: AppColors.primaryColor,
          filled: true,
        ),
        style: const TextStyle(fontSize: 50),
        readOnly: true,
        showCursor: true,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  String _input = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _onButtonPressed(String label) {
    setState(() {
      if (label == 'C') {
        _input = '';
      } else if (label == 'AC') {
        _input = '';
      } else if (label == '=') {
        try {
          _input = _calculateResult(_input);
        } catch (e) {
          _input = 'Error';
        }
      } else if (label == '%') {
        _input += '/100';
      } else {
        _input += label;
      }
      _controller.text = _input;
    });
  }

  String _calculateResult(String input) {
    try {
      final expression = input
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('√', 'sqrt');
      final expressionToEval = Expression.parse(expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expressionToEval, {});
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 30);
    final decoration = BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(child: Text("Calculator App")),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          CustomTextField(controller: _controller),
          const Spacer(),
          Container(
            height: screenHeight * 0.6,
            width: double.infinity,
            padding: padding,
            decoration: decoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buttonList.sublist(0, 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buttonList.sublist(4, 8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buttonList.sublist(8, 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buttonList.sublist(12, 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buttonList.sublist(16, 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  const Button1({super.key, required this.label, this.textColor = Colors.white});

  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final state = context.findAncestorStateOfType<_HomeScreenState>();
        state?._onButtonPressed(label);
      },
      child: Material(
        elevation: 3,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          backgroundColor: AppColors.secondary2Color,
          radius: 36,
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// Updated buttonList with correct structure
List<Widget> buttonList = [
  const Button1(label: "C", textColor: AppColors.secondaryColor),
  const Button1(label: "/", textColor: AppColors.secondaryColor),
  const Button1(label: "*", textColor: AppColors.secondaryColor),
  const Button1(label: "AC", textColor: AppColors.secondaryColor),
  const Button1(label: "7"),
  const Button1(label: "8"),
  const Button1(label: "9"),
  const Button1(label: "-", textColor: AppColors.secondaryColor),
  const Button1(label: "4"),
  const Button1(label: "5"),
  const Button1(label: "6"),
  const Button1(label: "+", textColor: AppColors.secondaryColor),
  const Button1(label: "1"),
  const Button1(label: "2"),
  const Button1(label: "3"),
  const Button1(label: "%", textColor: AppColors.secondaryColor),
  const Button1(label: "0"),
  const Button1(label: "."),
  const Button1(label: "√", textColor: AppColors.secondaryColor),
  const Button1(label: "=",),
];
