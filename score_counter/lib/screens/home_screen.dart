import 'dart:math';

import 'package:flutter/material.dart';
import 'package:score_counter/data/storage.dart';
import 'package:score_counter/modal/constants.dart';
import 'package:score_counter/modal/game.dart';
import 'package:score_counter/objectbox.g.dart';
import 'package:score_counter/screens/score_screen.dart';

final gamebox=objectbox.store.box<Game>() ;
final playerbox=objectbox.store.box<Player>();

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreen();
  }
  
}

class _HomeScreen extends State<HomeScreen>{
  List<Game> games=gamebox.getAll();
  late TextEditingController name_controlller=TextEditingController();
  late TextEditingController number_controller=TextEditingController();
  List<TextEditingController> players=[];

  @override
  dispose(){
    super.dispose();
    name_controlller.dispose();
    number_controller.dispose();
    players.map((p) => p.dispose());
  }

  int uniqueId(){
    int r=Random().nextInt(20);
    Game? g=gamebox.get(r);
    if(g!=null|| r==0) r=uniqueId();
    print(r);
    return r;
  }

  addNewGame(){
    showDialog(
      context: context, 
      builder: (ctx){
        return Dialog(
          child: Padding(
            padding:const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                  child: Center(child: Text("New Game")),
                ),
                Row(
                  children: [
                    const Text("Name:   "),
                    Expanded(
                      child: TextField(
                        controller: name_controlller,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Number of Players:   "),
                    Expanded(
                      child: TextField(
                        controller: number_controller,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.of(ctx).pop();
                      }, 
                      child:const Text("Cancel") ,
                    ),
                    const SizedBox(width: 5),
                    FilledButton(
                      onPressed: (){
                        int id=uniqueId();
                        Game g=Game(
                          name: name_controlller.text,
                          numberOfPlayers:int.tryParse(number_controller.text)!, 
                          note: '', 
                          isAscend: true,
                        );
                        gamebox.put(g);
                        gameDetails(ctx,g.id,name_controlller.text,int.tryParse(number_controller.text)!);
                      }, 
                      child:const Text("Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void gameDetails(BuildContext ctx,int gameId,String name,int n){
    for(int i=0;i<n;i++){
      var t=TextEditingController(text:"Player${i+1}");
      players.add(t);
    }
    showDialog(
      context: ctx, 
      builder: (cntx){
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                  child: Center(child: Text(name)),
                ),
                for(int i=1;i<=n;i++)
                  Row(
                    children: [
                      Text("Player$i:  "),
                      Expanded(
                        child: TextField(
                          controller: players[i-1],
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(cntx).pop();
                          setState(() {
                            gamebox.remove(gameId);
                          });
                        }, 
                        child:const Text("Back") ,
                      ),
                      const SizedBox(width: 5),
                      FilledButton(
                        onPressed: (){
                          for(int i=1;i<=n;i++){
                            Player p=Player(gameId: gameId, player: players[i-1].text, score: 0);
                            playerbox.put(p);
                          }
                          Navigator.of(cntx).pop();
                          Navigator.of(ctx).pop();
                          setState(() {});
                        }, 
                        child:const Text("Save"),
                      ),
                    ],
                ),
              ],
            ),
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    games=gamebox.getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Score Counter"),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.refresh), onPressed: () => setState(() {}),),
      ),
      floatingActionButton:FilledButton(
        onPressed: addNewGame,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: games.map((game) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              margin: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => ScoreScreen(game.id)))) ;
                },
                child: Row(
                  children: [
                    Text(game.name),
                    const Spacer(),
                    Text("${game.numberOfPlayers} players"),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: (){
                        print(game.id);
                        gamebox.remove(game.id);
                        getPlayers.param(Player_.gameId).value = game.id;
                        List<Player> p = getPlayers.find();
                        if(p!=null){p.map((e) => playerbox.remove(e.pid));}
                        setState(() {});
                      }, 
                      icon:const Icon(Icons.delete)
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }
  
}