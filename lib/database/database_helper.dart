//https://www.youtube.com/watch?v=LJH8UI8E1Lw&list=PLDQl6gZtjvFu5l20K5KTEBLCjfRjHowLj&index=5

// SQLite Database: SQLite is an in-process library that implements a
//      - self-contained (= minimal support from external libraries, good for platform-independent application),
//      - serverless (= reads & writes directly from the db files on disk/file system of Android or iOS device),
//      - zero-configuration (= requieres no installation and no setup),
//      - transactional (= all changes in a transaction occur completely or not at all)
// SQL database engine.

// SQFlite DB: To use a SQlite DB in Flutter there is a Plugin called "SQFlite" that allows you to access SQLite DB in both Android and iOS.
// To use SQFlite you have to include it's dependency in the pubspec.yaml file

// The SQFlite plugin only deals with MAP objects!!!
//      - you can only save data to the SQLite DB in the form of a map object  => before saving data to the DB, you need to convert the data into a MAP!!!
//      - the plugin also just retrieves the data from the SQLite DB in form of a map object => when you retrieve data from the DB you get a MAP object. You need to convert it to a simple object before using it!!!
// SQLite Requirement:
//      - Model Class (To represent the (Note) object),
//      - Database helper (to perform CRUD(Insert, Update, Query, Delete) operation),
//      - Put it all together (connect DB to UI)

import 'package:sd_quiz/model/quiz.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  //Table & columns for table 'userTable'
  static final String userTable = 'userTable';
  static final String colId = 'id';
  static final String colName = 'name';
  static final String colPassword = 'password';
  static final String colCounter = 'counter';

  //Table & columns for table 'quizTable'
  static final String quizTable = 'quizTable';
  static final String colItemID = 'itemID';
  static final String colQuizID = 'quizID';
  static final String colAnswerID = 'answerID';
  static final String colQuestion = 'question';
  static final String colAnswerOne = 'answerOne';
  static final String colAnswerTwo = 'answerTwo';
  static final String colAnswerThree = 'answerThree';
  static final String colAnswerFour = 'answerFour';

  //Table & columns for table 'topicTable'
  static final String topicTable = 'topicTable';
  static final String colTopicTableID = 'ttID';
  static final String colTopicID = 'topicID';
  static final String colTopic = 'topic';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'quizzz.db';

    // Open/create the database at a given path
    var notesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE $userTable(
    $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
    $colName TEXT NOT NULL,
    $colPassword TEXT NOT NULL, 
    $colCounter INTEGER
    )''');
    await db.execute('''
    CREATE TABLE $quizTable (
    $colItemID INTEGER PRIMARY KEY AUTOINCREMENT,
    $colQuizID INTEGER NOT NULL,
    $colAnswerID INTEGER NOT NULL,
    $colQuestion TEXT NOT NULL,
    $colAnswerOne TEXT NOT NULL,
    $colAnswerTwo TEXT NOT NULL,
    $colAnswerThree TEXT,
    $colAnswerFour TEXT
    )''');
    await db.execute('''
    CREATE TABLE $topicTable (
    $colTopicTableID INTEGER PRIMARY KEY AUTOINCREMENT,
    $colTopicID INTEGER NOT NULL,
    $colTopic TEXT NOT NULL
    )''');
  }

  //****************          METHODS REGARDING USER          ****************//
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $userTable');
    return result;
  }

  Future<int> insertUser(String name, String pw, int counter) async {
    var db = await this.database;

    //Get Quiz data at new registration
    await _getDataFromGoogleSheet();

    var result = await db.rawInsert('''
      INSERT INTO $userTable (
      $colName, $colPassword, $colCounter
      ) VALUES (?,?,?)
    ''', [name, pw, counter]);
    print('insert: $result');

    return result;
  }

  //Check for registration, whether a username is already taken
  Future<bool> userExistsAlreadyCheck (String name) async {
    bool userExists = false;
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count = userMapList.length; // Count the number of map entries in db table

    List<User> userList = List<User>();  // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      User user = User.fromMapObject(userMapList[i]);
      if(user.name == name){
        userExists = true;
      }
    }
    return userExists;
  }

  //check for login, whether username & password match
  Future<int> userExistsCheck(String name, String pw) async{
    int userExists = null;
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count = userMapList.length; // Count the number of map entries in db table

    List<User> userList = List<User>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      User user = User.fromMapObject(userMapList[i]);
      if(user.name == name && user.password == pw){
        userExists = user.id;
      }
    }
    return userExists;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'User List' [ List<User> ]
  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count = userMapList.length; // Count the number of map entries in db table

    List<User> userList = List<User>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  Future<User> getCurrentUser(int id) async {
    final db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $userTable WHERE id = $id');
    print("user with id $id");
    return result.isNotEmpty ? User.fromMapObject(result.first) : Null;
  }

  Future<int> updateScore(int id, int quizScore) async {
    final db = await this.database;
    User user = await getCurrentUser(id);

    int score = user.counter + quizScore;
    print('score: $score');

    var res = await db.rawUpdate('UPDATE $userTable SET $colCounter = ? WHERE id = ?', [score, id]);
    print('update: $res');

    return score;
  }

  //****************          METHODS REGARDING QUIZ          ****************//
  Future _getDataFromGoogleSheet() async {
    //get Data from Google Sheet
    var url = 'https://script.google.com/macros/s/AKfycbw_6uvHxG5QNXiOrGMCX-F1qFUF2v6xERPEucVQoI5nJeA7K_uN/exec';
    http.Response raw = await http.get(url);

    var jsonSDQuizAppContent = convert.jsonDecode(raw.body);

    jsonSDQuizAppContent.forEach((element) {
      print('$element THIS IS NEXT!!');
      Quiz quizContentHelper = new Quiz();
      quizContentHelper.quizID = element['quizID'];
      quizContentHelper.answerID = element['answerID'];
      quizContentHelper.question = element['question'];
      quizContentHelper.answerOne = element['ans1'];
      quizContentHelper.answerTwo = element['ans2'];
      quizContentHelper.answerThree = element['ans3'];
      quizContentHelper.answerFour = element['ans4'];

      _addDataToDB(quizContentHelper);

    });
  }

  Future _addDataToDB(Quiz quiz) async {
    Database db = await this.database;
    var result = await db.rawInsert('''
      INSERT INTO quizTable (
      quizID, answerID, question, answerOne, answerTwo, answerThree, answerFour
      ) VALUES (?,?,?,?,?,?,?)
    ''', [quiz.quizID, quiz.answerID, quiz.question, quiz.answerOne, quiz.answerTwo, quiz.answerThree, quiz.answerFour]);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Quiz List' [ List<Quiz> ]
  Future<List<Quiz>> getQuizList(quizID) async {
    var quizMapList = await getQuizMapList(quizID); // Get 'Map List' from database
    int count = quizMapList.length; // Count the number of map entries in db table

    List<Quiz> quizList = List<Quiz>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      quizList.add(Quiz.fromMapObject(quizMapList[i]));
    }
    return quizList;
  }

  Future<List<Map<String, dynamic>>> getQuizMapList(quizID) async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $quizTable WHERE quizID = $quizID');
    // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

}
