/// model class for quiz-object

class Quiz {
  /// unique quiz ID
  int itemID;
  /// quiz ID from Google Sheet
  int quizID;
  /// topic ID
  int qTopicID;
  /// answer ID, contains numer of right answer
  int answerID;
  /// question
  String question;
  /// answer 1
  String answerOne;
  /// answer 2
  String answerTwo;
  /// answer 3
  String answerThree;
  /// answer 4
  String answerFour;

  /// constructor [Quiz]
  Quiz(
      {this.quizID,
      this.qTopicID,
      this.answerID,
      this.question,
      this.answerOne,
      this.answerTwo,
      this.answerThree,
      this.answerFour});

  /// converts a quiz-object into a map-object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>(); //instanciate map object

    map['itemID'] = itemID;
    if (itemID != null) {
      map['itemID'] = itemID;
    }
    map['quizID'] = quizID;
    map['qTopicID'] = qTopicID;
    map['answerID'] = answerID;
    map['question'] = question;
    map['answerOne'] = answerOne;
    map['answerTwo'] = answerTwo;
    map['answerThree'] = answerThree;
    map['answerFour'] = answerFour;

    return map;
  }

  /// extracts a quiz-object from a map-object
  Quiz.fromMapObject(Map<String, dynamic> map) {
    this.itemID = map['itemID'];
    this.quizID = map['quizID'];
    this.qTopicID = map['qTopicID'];
    this.answerID = map['answerID'];
    this.question = map['question'];
    this.answerOne = map['answerOne'];
    this.answerTwo = map['answerTwo'];
    this.answerThree = map['answerThree'];
    this.answerFour = map['answerFour'];
  }

  /// receives [json], converts [json] into quiz-object
  factory Quiz.fromJson(dynamic json) {
    return Quiz(
        quizID: json['quizID'],
        qTopicID: json['topicID'],
        answerID: json['answerID'],
        question: "${json['question']}",
        answerOne: "${json['ans1']}",
        answerTwo: "${json['ans2']}",
        answerThree: "${json['ans3']}",
        answerFour: "${json['ans4']}");
  }
}
