import 'package:dice/gradient_container.dart';
import 'package:dice/multiple_dice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceApp(),
    ),
  );
}

class DiceApp extends StatefulWidget {
  
  @override
  State<DiceApp> createState() {
    return _DiceApp();
  }
}

class _DiceApp extends State<DiceApp> {
  TextEditingController n = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    n.dispose();
  }

  void addDice() {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Add Dice Set"),
                    Row(
                      children: [
                        Text("Dice required: "),
                        Expanded(
                          child: TextField(
                            controller: n,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Cancel")),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        MultipleDice(int.tryParse(n.text)!))));
                          },
                          child: Text("Add"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          ElevatedButton(onPressed: addDice, child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: GradientContainer(clr: [
        Color.fromARGB(255, 28, 27, 27),
        Color.fromARGB(255, 58, 57, 57),
      ]),
    );
  }
}
