import 'package:flutter/material.dart';
import 'package:pin_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _pin = '2541';
  int firstOnPin = -1;
  int secondOnPin = -1;
  int thirdOnPin = -1;
  int fourthOnPin = -1;

  void _setNumber(int number) {
    setState(() {
      if (number == -2) {
        _checkPin();
      }
      if (firstOnPin < 0) {
        firstOnPin = number;
      } else if (secondOnPin < 0) {
        secondOnPin = number;
      } else if (thirdOnPin < 0) {
        thirdOnPin = number;
      } else if (fourthOnPin < 0) {
        fourthOnPin = number;
      }
    });
  }

  void _checkPin() {
    if (firstOnPin == int.parse(_pin[0]) &&
        secondOnPin == int.parse(_pin[1]) &&
        thirdOnPin == int.parse(_pin[2]) &&
        fourthOnPin == int.parse(_pin[3])) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Home(),
        ),
      );
    } else {
      firstOnPin = -1;
      secondOnPin = -1;
      thirdOnPin = -1;
      fourthOnPin = -1;
    }
  }

  void _deleteNumberOnPin() {
    setState(() {
      if (fourthOnPin > 0) {
        fourthOnPin = -1;
      } else if (fourthOnPin < 0 && thirdOnPin > 0) {
        thirdOnPin = -1;
      } else if (thirdOnPin < 0 && secondOnPin > 0) {
        secondOnPin = -1;
      } else if (secondOnPin < 0) {
        firstOnPin = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.lock_outlined,
            size: 50,
            color: Colors.black54,
          ),
          const SizedBox(height: 25),
          const Text(
            'Wprowadź kod PIN',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              circlePin(firstOnPin),
              circlePin(secondOnPin),
              circlePin(thirdOnPin),
              circlePin(fourthOnPin),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button('1'),
              button('2'),
              button('3'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button('4'),
              button('5'),
              button('6'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button('7'),
              button('8'),
              button('9'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button('-1'),
              button('0'),
              button('-2'),
            ],
          ),
        ],
      ),
    );
  }

  Padding circlePin(int number) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: number > 0 ? Colors.black26 : Colors.transparent,
            border: Border.all(
              color: Colors.black12,
              width: 2,
            ),
          ),
        ),
      );

  Padding button(String number) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () => number == '-1'
            ? _deleteNumberOnPin()
            : _setNumber(int.parse(number)),
        style: ElevatedButton.styleFrom(
          primary: int.parse(number) >= 0 ? Colors.white : Colors.black12,
          elevation: 1,
          fixedSize: const Size(75, 75),
          shape: const CircleBorder(),
          shadowColor: Colors.black54,
          side: const BorderSide(
            width: 2,
            color: Colors.black12,
          ),
        ),
        child: number == '-1'
            ? const Icon(
                Icons.backspace_outlined,
                color: Colors.black54,
              )
            : number == '-2'
                ? const Icon(
                    Icons.check,
                    color: Colors.black54,
                  )
                : Text(
                    number,
                    style: const TextStyle(color: Colors.black54, fontSize: 24),
                  ),
      ),
    );
  }
}
