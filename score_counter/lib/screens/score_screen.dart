import 'package:flutter/material.dart';
import 'package:score_counter/data/storage.dart';
import 'package:score_counter/modal/constants.dart';
import 'package:score_counter/modal/game.dart';
import 'package:score_counter/objectbox.g.dart';
import 'package:score_counter/screens/home_screen.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen(this.gameId, {super.key});

  final int gameId;

  @override
  State<ScoreScreen> createState() {
    return _ScoreScreen();
  }
}

class _ScoreScreen extends State<ScoreScreen> {
  late List<TextEditingController> next_score_controller=[];
  late TextEditingController noteController;
  late Game game;
  late List<Player> players;
  late final int n;

  @override
  void initState(){
    super.initState();
    game = gamebox.get(widget.gameId)!;
    getPlayers.param(Player_.gameId).value = game.id;
    players = getPlayers.find();
    n = players.length;
    for (int i = 0; i <= n; i++) {
      var t = TextEditingController(text: "0");
      next_score_controller.add(t);
    }
    noteController=TextEditingController(text: game.note);
    
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
    next_score_controller.map((e) => e.dispose());
  }

  @override
  Widget build(BuildContext context) {
    if(game.isAscend) {
      players.sort(ascend);
    } else {
      players.sort(desend);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(game.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          padding:const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border:const TableBorder(
                    horizontalInside: BorderSide(), verticalInside: BorderSide()),
                children: [
                  TableRow(
                    // decoration: BoxDecoration(
                    //     color: Color.fromARGB(115, 90, 89, 89),
                    //     border: Border.all(color: Colors.white)),
                    children: [
                      Center(child: const Text("Player Name")),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Points"),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text("Desend",style: TextStyle(fontSize: 8),),
                                Switch(
                                  value: game.isAscend,
                                  onChanged: (order) {
                                    setState(() {
                                      game.isAscend = order;
                                    });
                                  },
                                ),
                                const Text("Ascend",style: TextStyle(fontSize: 8),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Next Point"),
                          const SizedBox(height: 5),
                          FilledButton(
                            onPressed: () {
                              for(int i=0;i<n;i++){
                                players[i].score+=int.tryParse( next_score_controller[i].text)!;
                                next_score_controller[i].text="0";
                                playerbox.remove(players[i].pid);
                                playerbox.put(players[i]);
                              }
                              setState(() {});
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  for (int i = 0; i < n; i++)
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(players[i].player),
                      ),
                      Center(child: Text("${players[i].score}")),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5,left: 5,right: 5),
                        child: TextField(
                          controller: next_score_controller[i],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.bottom,
                        ),
                      ),
                    ]),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                color: Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      const Text("Note:"),
                      SizedBox(width: 10,),
                      IconButton(
                        onPressed: () {
                          game.note=noteController.text;
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Updated")));
                          gamebox.remove(game.id);
                          setState(() {
                            gamebox.put(game);
                          });
                          
                        },
                        icon:const  Icon(Icons.check),
                      )
                        ],
                      ),
                      TextField(
                        controller: noteController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        minLines: 4,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
