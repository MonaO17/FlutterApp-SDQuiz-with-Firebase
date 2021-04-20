import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper {

  // CREATING & INITALIZING DB

  //creating variables
  static final _dbName = 'sdquiz.db';
  static final _dbVersion = 1;

  static final _tablePlayer = '_spieler';
  static final _playerID = '_pID';
  static final _playerName = '_pName';
  static final _playerPassword = '_pPassword';
  static final _playerCounter = '_pCounter';

  static final _tableQuiz = '_quiz';
  static final _quizID = '_quizID';
  static final _quizName = '_quizName';
  static final _quizQuestion = '_quizQuestion';
  static final _quizAnswerOne = '_quizAnswerOne';
  static final _quizAnswerTwo = '_quizAnswerTwo';
  static final _quizAnswerThree = '_quizAnswerThree';
  static final _quizAnswerFour = '_quizAnswerFour';


  // static final columnName = '_name';

  //making it a singleton class => stellt sicher, dass von der Klasse genau ein Objekt existiert
  DatabaseHelper.privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  //create database
  static Database _database; //bis hierhin alles statisch, da bei der statischen Typisierung (im Gegensatz zur dynamischen Typisierung)
  //wird der Datentyp von Variablen und anderen Programmbausteinen schon während der Kompilierung festgelegt.
  //Das ist hier wichtig, da die DB das aller Erste Mal wenn sie läuft null ist/installiert wird.
  //initalizing database
  Future<Database> get database async {
    if (_database != null) return _database;

    _database =
    await _initiateDatabase(); //create new db and initalize with function _initiateDatabase (see below)
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
      $_playerID INTEGER PRIMARY KEY,
      $_playerName TEXT NOT NULL,
      $_playerPassword TEXT NOT NULL,
      $_playerCounter INTEGER)
      ''' //''' you can write a string in multiple lines within the 3 singe quotes '''
    );
    await db.execute('''
    CREATE TABLE $_tableQuiz (
    $_quizID INTEGER PRIMARY KEY,
    $_quizName TEXT NOT NULL,
    $_quizQuestion BLOB NOT NULL,
    $_quizAnswerOne TEXT NOT NULL,
    $_quizAnswerTwo TEXT NOT NULL,
    $_quizAnswerThree TEXT,
    $_quizAnswerFour TEXT
    )
    ''');
  }

}
