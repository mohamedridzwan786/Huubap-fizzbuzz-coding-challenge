import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fizzbuzz/main.dart';

class FizzBuzzPage extends StatefulWidget {
  FizzBuzzPage({Key? key}) : super(key: key);

  @override
  _FizzBuzzPageState createState() => _FizzBuzzPageState();
}

class _FizzBuzzPageState extends State<FizzBuzzPage> {
  final _formKey = GlobalKey<FormState>();
  String fizz = 'Fizz';
  String buzz = 'Buzz';
  String fizzBuzz = "Fizz Buzz";
  int? number = 0;
  String value = "1";

  TextEditingController integerController = TextEditingController();

  bool is_fizz = false;
  bool is_buzz = false;
  bool is_fizz_buzz = false;
  bool is_full_series = false;

  void fullSeries() {
    setState(
      () {
        is_full_series = true;
        is_buzz = false;
        is_fizz_buzz = false;
        is_fizz = false;
      },
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  void fizz_1() {
    setState(
      () {
        is_fizz = true;
        is_fizz_buzz = false;
        is_buzz = false;
        is_full_series = false;
      },
    );
  }

  void buzz_1() {
    setState(
      () {
        is_buzz = true;
        is_fizz_buzz = false;
        is_fizz = false;
        is_full_series = false;
      },
    );
  }

  void fizz_buzz_1() {
    setState(
      () {
        is_fizz_buzz = true;
        is_buzz = false;
        is_fizz = false;
        is_full_series = false;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    integerController = TextEditingController(text: '0');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> full_series = [];
    List<Widget> fizz = [];
    List<Widget> buzz = [];
    List<Widget> fizzBuzz = [];

    for (var i = 1; i <= num.parse(integerController.text); i++) {
      if (i % 3 == 0 && i % 5 == 0) {
        full_series.add(
          ListView(context, 'Fizz Buzz'),
        );
      } else if (i % 3 == 0) {
        full_series.add(
          ListView(context, 'Fizz'),
        );
      } else if (i % 5 == 0) {
        full_series.add(
          ListView(context, 'Buzz'),
        );
      } else {
        full_series.add(ListView(context, i.toString()));
      }
    }

    for (var i = 1; i <= num.parse(integerController.text); i++) {
      if (i % 3 == 0) {
        fizz.add(ListView(context, i.toString()));
      }
    }

    for (var i = 1; i <= num.parse(integerController.text); i++) {
      if (i % 5 == 0) {
        buzz.add(ListView(context, i.toString()));
      }
    }

    for (var i = 1; i <= num.parse(integerController.text); i++) {
      if (i % 3 == 0 && i % 5 == 0) {
        fizzBuzz.add(ListView(context, i.toString()));
      }
    }
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/huubap.jpeg',
                scale: 6,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Huubap's FizzBuzz",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  MyApp.themeNotifier.value =
                      MyApp.themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                })
          ],
          backgroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                InputField(),
                FizzBuzzButton1(),
                FizzBuzzButton2(),
                FizzBuzzView(full_series, fizz, buzz, fizzBuzz),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Padding InputField() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 12, right: 5),
      child: TextFormField(
        style: Theme.of(context).scaffoldBackgroundColor == Colors.black
            ? TextStyle(color: Colors.white)
            : TextStyle(color: Colors.black),
        cursorColor: Theme.of(context).scaffoldBackgroundColor == Colors.black
            ? Colors.white
            : Colors.red,
        onChanged: (text) {
          value = text;
        },
        keyboardType: TextInputType.number,
        validator: (input) {
          final isDigitsOnly = int.tryParse(input ?? "");
          if (input == null || input.isEmpty || isDigitsOnly == null) {
            return 'Field is empty, Please enter the integer to proceed!';
          }
          return null;
        },
        controller: integerController,
        decoration: Theme.of(context).scaffoldBackgroundColor == Colors.black
            ? InputDecoration(
                filled: true,
                hoverColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700]!)),
                border: OutlineInputBorder(),
                labelText: 'Enter the Integer number',
                labelStyle: TextStyle(color: Colors.white),
              )
            : InputDecoration(
                border: OutlineInputBorder(),
                hoverColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  //<-- SEE HERE
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                labelText: 'Enter the Integer number',
                labelStyle: TextStyle(color: Colors.black),
              ),
      ),
    );
  }

  Column FizzBuzzView(List<Widget> full_series, List<Widget> fizz,
      List<Widget> buzz, List<Widget> fizzBuzz) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (is_full_series == true)
          Column(
            children: full_series,
          ),
        if (is_fizz == true)
          Column(
            children: fizz,
          ),
        if (is_buzz == true)
          Column(
            children: buzz,
          ),
        if (is_fizz_buzz == true)
          Column(
            children: fizzBuzz,
          )
      ],
    );
  }

  Padding ListView(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 3, right: 5),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 25,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid), //Border.all
        ),
        child: Text(
          name,
          style: Theme.of(context).scaffoldBackgroundColor == Colors.black
              ? TextStyle(color: Colors.white)
              : TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Padding FizzBuzzButton1() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              child: Text('Full series'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  return fullSeries();
                }
              },
            ),
          ),
          SizedBox(width: 3),
          Expanded(
            child: ElevatedButton(
              child: Text('Fizz Buzz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  return fizz_buzz_1();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding FizzBuzzButton2() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 3, right: 5),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              child: Text('Fizz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  return fizz_1();
                }
              },
            ),
          ),
          SizedBox(width: 3),
          Expanded(
            child: ElevatedButton(
              child: Text('Buzz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  return buzz_1();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
