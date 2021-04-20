import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper {

  // CREATING & INITALIZING DB

  //creating variables
  //Underscore (_xyz) fields, classes and methods will only be available in the .dart file where they are defined.
  static final _dbName = 'sdquiz.db';
  static final _dbVersion = 1;

  //Table for Player
  static final _tablePlayer = '_tablePlayer';
  static final playerID = 'pID';
  static final playerName = 'pName';
  static final playerPassword = 'pPassword';
  static final playerCounter = 'pCounter';

  //Table with Quiz Names
  static final _tableQuiz = '_tableQuiz';
  static final quizID = 'quizID';
  static final quizName = 'quizName';

  //Table with Questions & Answers
  static final _tableQaA = '_tableQaA';
  static final qaAid = 'qaAid';
  static final question = 'question';
  static final answerOne = 'answerOne';
  static final answerTwo = 'answerTwo';
  static final answerThree = 'answerThree';
  static final answerFour = 'answerFour';
  static final rightAnswer = 'rightAnswer';


  //making it a singleton class => stellt sicher, dass von der Klasse genau ein Objekt existiert
  DatabaseHelper.privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  //create database
  static Database _database; //bis hierhin alles statisch, da bei der statischen Typisierung (im Gegensatz zur dynamischen Typisierung)
  //der Datentyp von Variablen und anderen Programmbausteinen schon während der Kompilierung festgelegt wird.
  //Das ist hier wichtig, da die DB das aller Erste Mal wenn sie läuft null ist/installiert wird.

  //initalizing database
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase(); //create new db and initalize with function _initiateDatabase (see below)
    return _database;
  }

  _initiateDatabase() async {
    //function sets path and opens db
    Directory directory = await getApplicationDocumentsDirectory(); //"Directory" part of dart:io library (dart:io library includes everything for input/output in dart)
    String path = join(directory.path, _dbName); //set path
    return await openDatabase(path, version: _dbVersion,
        onCreate: _onCreate); //open Database, version number differs in more complex programs
  }

  Future _onCreate(Database db, int version) async {
    //function creates table inside db
    await db.execute('''
      CREATE TABLE $_tablePlayer (
      $playerID INTEGER PRIMARY KEY,
      $playerName TEXT NOT NULL,
      $playerPassword TEXT NOT NULL,
      $playerCounter INTEGER)
      ''' //''' you can write a string in multiple lines within the 3 singe quotes '''
    );
    await db.execute('''
    CREATE TABLE $_tableQuiz (
    $quizID INTEGER PRIMARY KEY,
    $quizName TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE $_tableQaA(
    $qaAid INTEGER PRIMARY KEY,
    $quizID INTEGER FOREIGN KEY,
    $question BLOB NOT NULL,
    $answerOne TEXT NOT NULL,
    $answerTwo TEXT NOT NULL,
    $answerThree TEXT,
    $answerFour TEXT,
    $rightAnswer INTEGER NOT NULL
    )
    ''');
  }


  // WORKING WITH THE DB: insert, delete, update & query-commands

  //table values are getting returned in this structure (a map)
  //  {
  //    "_id":12,
  //  "name":"Anja"
  //  }

  Future<int> insert(Map<String, dynamic> row) async { //row is the value I pass
    Database db = await instance.database;
    return await db.insert(_tablePlayer, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tablePlayer);
  }

//   Future <int> update(Map<String, dynamic>row) async {
//     Database db = await instance.database;
//     int id = row[columnID];
//     return await db.update(
//         _tablePlayer, row, where: '$columnID=?', whereArgs: [id]);
// //Bsp:  _tableName, row, where: '$columnID=?' '$columnName=?', whereArgs: [1, 'mona']);
//   }
//
//   Future <int> delete(int id) async {
//     Database db = await instance.database;
//     return await db.delete(_tablePlayer, where: '$columnID =?', whereArgs: [id]);
//   }
// }


}
