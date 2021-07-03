/* code partly inspired by
       - https://www.youtube.com/watch?v=LJH8UI8E1Lw&list=PLDQl6gZtjvFu5l20K5KTEBLCjfRjHowLj&index=5
       - https://www.youtube.com/watch?v=RjQuPzn3dsg
       - https://www.youtube.com/watch?v=xke5_yGL0uk&list=PLDQl6gZtjvFu5l20K5KTEBLCjfRjHowLj&index=9
*/

// Generelle Funktionsweise SQLite in Flutter
// SQLite Database: SQLite is an in-process library that implements a
//      - self-contained (= minimal support from external libraries, good for platform-independent application),
//      - serverless (= reads & writes directly from the db files on disk/file system of Android or iOS device),
//      - zero-configuration (= requires no installation and no setup),
//      - transactional (= all changes in a transaction occur completely or not at all)
// SQL database engine.

// SQFlite DB: To use a SQlite DB in Flutter there is a Plugin called "SQFlite" that allows you to access SQLite DB in both Android and iOS.
// To use SQFlite you have to include it's dependency in the pubspec.yaml file

// The SQFlite plugin only deals with MAP objects!!!
//      - you can only save data to the SQLite DB in the form of a map object  => before saving data to the DB, you need to convert the data into a MAP!!!
//      - the plugin also just retrieves the data from the SQLite DB in form of a map object => when you retrieve data from the DB you get a MAP object. You need to convert it to a simple object before using it!!!
// SQLite Requirement:
//      - Model Class (To represent the (user/quiz/topic) object),
//      - Database helper (to perform CRUD(Insert, Update, Query, Delete) operation),
//      - Put it all together (connect DB to UI)

import 'package:sd_quiz/model/quiz.dart';
import 'package:sd_quiz/model/topic.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

/// Database is created, initialized and methods to perform CRUD(Create, Read, Update, Delete) operation are available
class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  /// Table & columns for table [userTable]
  /// table [userTable]
  static final String userTable = 'userTable';
  /// column-name for unique ID for user
  static final String colId = 'id';
  /// column-name for user name
  static final String colName = 'name';
  /// column-name for user password
  static final String colPassword = 'password';
  /// column-name for user score
  static final String colCounter = 'counter';

  /// Table & columns for table [quizTable]
  /// table [quizTable]
  static final String quizTable = 'quizTable';
  /// column-name for unique quiz ID
  static final String colItemID = 'itemID';
  /// column-name for quiz ID from Google Sheet
  static final String colQuizID = 'quizID';
  /// column-name for topic ID
  static final String colQTopicID = 'qTopicID';
  /// column-name for answer ID
  static final String colAnswerID = 'answerID';
  /// column-name for question
  static final String colQuestion = 'question';
  /// column-name for answer 1
  static final String colAnswerOne = 'answerOne';
  /// column-name for answer 2
  static final String colAnswerTwo = 'answerTwo';
  /// column-name for answer 3
  static final String colAnswerThree = 'answerThree';
  /// column-name for answer 4
  static final String colAnswerFour = 'answerFour';

  /// Table & columns for table [topicTable]
  /// table [topicTable]
  static final String topicTable = 'topicTable';
  /// column-name for unique topic ID
  static final String colTopicTableID = 'topicTableID';
  /// column-name for topic ID from Google Sheet
  static final String colTopicID = 'topicID';
  /// column-name for topic name
  static final String colTopic = 'topic';
  /// column-name for topic picture
  static final String colTopicPic = 'topicPic';

  DatabaseHelper._createInstance(); // Named constructor to create instance of db-helper

  /// constructor for DatabaseHelper
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  /// returns database
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  /// sets directory when initializing database, returns initialized database [notesDatabase]
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'sdquiz.db';
    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  /// creates database
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
    $colQTopicID INTEGER NOT NULL,
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
    $colTopic TEXT NOT NULL,
    $colTopicPic TEXT NOT NULL
    )''');
  }


  /// Methods regarding user-object

  /// returns all users in form of MapList
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $userTable');
    return result;
  }

  /// checks for login, whether username & password match, returns Integer with [userID] or 0
  Future<int> userExistsCheck(String name, String pw) async {
    int userExists = 0;
    var userMapList = await getUserMapList();
    int count = userMapList.length; // Count the number of map entries in db table

    for (int i = 0; i < count; i++) {
      User user = User.fromMapObject(userMapList[i]);
      if (user.name == name && user.password == pw) {
        userExists = user.id;
      }
    }
    return userExists;
  }

  /// inserts new user into database, returns [userID] of added user
  Future<int> insertUser(String name, String pw, int counter) async {
    var db = await this.database;

    var result = await db.rawInsert('''
      INSERT INTO $userTable (
      $colName, $colPassword, $colCounter
      ) VALUES (?,?,?)
    ''', [name, pw, counter]);
    print('insert: $result');

    return result;
  }

  /// checks during registration, whether a username is already taken, returns true if user exists or false if he dosen't
  Future<bool> userExistsAlreadyCheck(String name) async {
    bool userExists = false;
    var userMapList = await getUserMapList();
    int count = userMapList.length; // Count the number of map entries in db table

    for (int i = 0; i < count; i++) {
      User user = User.fromMapObject(userMapList[i]);
      if (user.name == name) {
        userExists = true;
      }
    }
    return userExists;
  }

  /// requests all users in form of a MapList and converts it into List<User> [userList], returns [userList]
  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count = userMapList.length; // Count the number of map entries in db table

    List<User> userList = List<User>(); // For loop to create a 'User List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  /// receives [id], returns user that belongs to [id] or Null if there is no corresponding user
  Future<User> getCurrentUser(int id) async {
    final db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $userTable WHERE id = $id');
    print("getCurrentUser: user with id $id");
    return result.isNotEmpty ? User.fromMapObject(result.first) : Null;
  }

  /// receives [id] and [quizScore], updates [score] for user with corresponding [id] in database and returns new [score]
  Future<int> updateScore(int id, int quizScore) async {
    final db = await this.database;
    User user = await getCurrentUser(id);

    int score = user.counter + quizScore;

    var res = await db.rawUpdate('UPDATE $userTable SET $colCounter = ? WHERE id = ?', [score, id]);
    print('update: $res');

    return score;
  }

  /// Methods regarding quiz-object

  /// requests data from GoogleSheet
  Future getDataFromGoogleSheet() async {
    var url = 'https://script.google.com/macros/s/AKfycbw_6uvHxG5QNXiOrGMCX-F1qFUF2v6xERPEucVQoI5nJeA7K_uN/exec';
    http.Response raw = await http.get(url);

    var jsonSDQuizAppContent = convert.jsonDecode(raw.body);

    jsonSDQuizAppContent.forEach((element) {
      Quiz quizContentHelper = new Quiz();
      quizContentHelper.quizID = element['quizID'];
      quizContentHelper.qTopicID = element['topicID'];
      quizContentHelper.answerID = element['answerID'];
      quizContentHelper.question = element['question'];
      quizContentHelper.answerOne = element['ans1'];
      quizContentHelper.answerTwo = element['ans2'];
      quizContentHelper.answerThree = element['ans3'];
      quizContentHelper.answerFour = element['ans4'];

      _addDataToDB(quizContentHelper);
    });
  }

  /// receives quiz-object [quiz], checks if [quizID] already exists in database, if not the quiz is added to the database
  Future _addDataToDB(Quiz quiz) async {
    Database db = await this.database;
    bool exists = false;

    //check if QuizID already exists
    List<Quiz> existingQuiz = await allGetQuizList();
    for (int i = 0; i < existingQuiz.length; i++) {
      if (existingQuiz[i].quizID == quiz.quizID) {
        exists = true;
      }
    }
    if (exists == false) {
      print("NEW QUIZ: ${quiz.quizID} , ${quiz.question}");
      await db.rawInsert(''' INSERT INTO quizTable (
        quizID, qTopicID, answerID, question, answerOne, answerTwo, answerThree, answerFour
    ) VALUES (?,?,?,?,?,?,?,?)
    ''', [
        quiz.quizID,
        quiz.qTopicID,
        quiz.answerID,
        quiz.question,
        quiz.answerOne,
        quiz.answerTwo,
        quiz.answerThree,
        quiz.answerFour
      ]);
    }
  }

  /// requests all quizzes in form of a MapList and converts the MapList into a List<Quiz> [quizList], returns [quizList]
  Future<List<Quiz>> allGetQuizList() async {
    var quizMapList = await allGetQuizMapList(); // Get 'Map List' from database
    int count = quizMapList.length; // Count the number of map entries in db table

    List<Quiz> quizList = List<Quiz>();
    for (int i = 0; i < count; i++) {
      quizList.add(Quiz.fromMapObject(quizMapList[i]));
    }
    return quizList;
  }

  /// returns all quiz-objects in form of a MapList
  Future<List<Map<String, dynamic>>> allGetQuizMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $quizTable');
    return result;
  }

  /// receives [quizID], requests all quizzes with that [quizID] in form of a MapList and converts the MapList into a List<Quiz> [quizList], returns [quizList]
  Future<List<Quiz>> getQuizList(quizID) async {
    var quizMapList = await getQuizMapList(quizID); // Get 'Map List' from database
    int count =  quizMapList.length; // Count the number of map entries in db table

    List<Quiz> quizList = List<Quiz>();
    for (int i = 0; i < count; i++) {
      quizList.add(Quiz.fromMapObject(quizMapList[i]));
    }
    return quizList;
  }

  /// receives [topicID], return all quiz-objects in form of a MapList where [topicID] matches
  Future<List<Map<String, dynamic>>> getQuizMapList(topicID) async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $quizTable WHERE qTopicID = $topicID');
    return result;
  }


  /// Methods regarding topic-object

  /// requests Data from Google Sheet
  Future getTopicFromGoogleSheet() async {
    var urlTopic ='https://script.google.com/macros/s/AKfycby0RtLCk4hMHKupykeguCESPVnLeCKdbgiV9jbzHmrEVVg0iGCE/exec';
    http.Response raw = await http.get(urlTopic);

    var jsonSDTopicAppContent = convert.jsonDecode(raw.body);

    jsonSDTopicAppContent.forEach((element) {
      Topic topicContentHelper = new Topic();
      topicContentHelper.topicID = element['topicID'];
      topicContentHelper.topic = element['topicName'];
      topicContentHelper.topicPic = element['topicPicture'];

      _addTopicDataToDB(topicContentHelper);
    });
  }

  /// receives topic-object [topic], checks whether the topic already exists in database, if not the topic is added to the database
  Future _addTopicDataToDB(Topic topic) async {
    Database db = await this.database;
    bool exists = false;

    //check if topicID already exists
    List<Topic> existingTopics = await getTopicList(); //List with existing Quizzes
    for (int i = 0; i < existingTopics.length; i++) {
      if (existingTopics[i].topicID == topic.topicID) {
        exists = true;
      }
    }
    if (exists == false) {
      print("NEW TOPIC: ${topic.topicID} , ${topic.topic}");
      //add new topics to database
      await db.rawInsert(''' INSERT INTO topicTable (
        topicID, topic, topicPic
    ) VALUES (?,?,?)
    ''', [topic.topicID, topic.topic, topic.topicPic]);
    }
  }

  /// requests all topics in form of MapList and converts MapList into List<Topic> [topicList], returns [topicList]
  Future<List<Topic>> getTopicList() async {
    var topicMapList = await getTopicMapList(); // Get 'Map List' from database
    int count = topicMapList.length; // Count the number of map entries in db table

    List<Topic> topicList = List<Topic>();
    for (int i = 0; i < count; i++) {
      topicList.add(Topic.fromMapObject(topicMapList[i]));
    }
    return topicList;
  }

  /// returns all topics from database
  Future<List<Map<String, dynamic>>> getTopicMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $topicTable');
    return result;
  }
}
