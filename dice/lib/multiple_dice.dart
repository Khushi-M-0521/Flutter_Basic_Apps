import 'package:dice/dice_roller.dart';
import 'package:dice/main.dart';
import 'package:flutter/material.dart';

class MultipleDice extends StatefulWidget {
  MultipleDice(this.n, {super.key});

  int n;

  @override
  State<StatefulWidget> createState() {
    return _MultipleDice();
  }
}

class _MultipleDice extends State<MultipleDice> {
  bool isSingle = false;
  List<int> currDiceRoll = [];
  List<Image> dice = [];
  int AxisCount=2;

  @override
  void initState() {
    super.initState();

    calculateAxisCount(widget.n);

    for (int i = 0; i < widget.n; i++) {
      currDiceRoll.add(3);
      dice.add(Image.asset(
        "assests/dice-images/dice-${currDiceRoll[i]}.png",
        width: 200,
      ));
    }
  }

  void calculateAxisCount(int n){
    var fill=(n/AxisCount) *(300/AxisCount);
    if(fill>700 && AxisCount<10){
      AxisCount++;
      calculateAxisCount(n);
    }
    return;
  }

  void rollSingleDice(int index) {
    currDiceRoll[index] = randomizer.nextInt(6) + 1;
    setState(() {
      dice[index]=Image.asset(
        "assests/dice-images/dice-${currDiceRoll[index]}.png",
        width: 200,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => DiceApp()));
                    },
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      if (!isSingle) {
                        for(int i=0;i<widget.n;i++){
                          rollSingleDice(i);
                        }
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Rolled!!")));
                      }
                    },
                    child: Text("Roll all dice")),
                Spacer(),
                Text("single dice:"),
                Switch(
                    value: isSingle,
                    onChanged: (change) {
                      setState(() {
                        isSingle=change;
                      });
                    }),
              ],
            ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AxisCount, childAspectRatio: 1),
          children: [
            for (int i = 0; i < widget.n; i++)
              TextButton(
                onPressed: () {
                  if (isSingle) {
                    rollSingleDice(i);
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Rolled!!")));
                  }
                },
                child: dice[i],
              ),
          ],
        ),
      ),
    );
  }
}
