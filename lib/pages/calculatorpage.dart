import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String statement = "";
  String result = "";
  List<String> buttonList=[
    'C','(',')','/',
    '7','8','9',
    '*','4','5','6',
    '+','1','2','3','-','AC','0','.', '='
  ];
  Widget buttonWidget(){
    return GridView.builder(
        itemCount: buttonList.length,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4)
        , itemBuilder: (BuildContext context,int index){
      return button(buttonList[index]);
    }
    );
  }
  Widget resultWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            statement,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
  Widget button(String text){
    return Container(
        margin: EdgeInsets.all(8),
        child: MaterialButton(onPressed: (){setState(() {
          handleButtonTap(text);
        });}
          ,color:  Colors.white,

          textColor: Color(0xFF62707e) ,
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),

          ),
          shape: CircleBorder(),

        ));
  }
  handleButtonTap(String text) {
    if (text == "AC") {
      statement = "";
      result = "0";
      return;
    }
    if (text == "=") {
      result = calculate();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }

    if (text == "C") {
      statement = statement.substring(0, statement.length - 1);
      return;
    }
    statement = statement + text;
  }

  calculate() {
    try {
      var exp = Parser().parse(statement);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Err";
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: Color(0xFFf4c2c2),
          appBar: AppBar(
            title:const Text(
              'Calculator',
              style: TextStyle(color: Color(0xFF62707e)),
            ),
            backgroundColor: Color(0xFFf4c2c2),
          ),
          body:
          Column(
            children: [
              Flexible(flex: 2, child: resultWidget()),
              Expanded(flex: 4, child: buttonWidget()),
            ],
          ),

        ));


  }
}