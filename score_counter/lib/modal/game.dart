import 'package:objectbox/objectbox.dart';

@Entity()
class Game{
  @Id()
  int id=0;
  String name;
  int numberOfPlayers;
  String note;
  bool isAscend;
  Game({
    required this.name,
    required this.numberOfPlayers,
    required this.note,
    required this.isAscend
  });
}

@Entity()
class Player{
  @Id()
  int pid=0;
  int gameId;
  String player;
  int score;
  Player({
    required this.gameId,
    required this.player,
    required this.score
  });
}