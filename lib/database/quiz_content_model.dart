class QuizContentModel {

  int questionID, quizID, ansID;
  String question, ansOne, ansTwo, ansThree, ansFour;
  //String sourceUrl;

  QuizContentModel({this.questionID, this.quizID, this.question, this.ansOne, this.ansTwo, this.ansThree, this.ansFour, this.ansID});

  // convert JSON that we get into this model(=QuizContentHelper) in this class (seperate Strings etc.),
  // so that we can create a list of this model and then show the details in a list view
  factory QuizContentModel.fromJson(dynamic json) {
    return QuizContentModel(
      questionID: json['questionID'],
      quizID: json['quizID'],
      question: "${json['question']}",
      ansOne: "${json['ans1']}",
      ansTwo: "${json['ans2']}",
      ansThree: "${json['ans3']}",
      ansFour: "${json['ans4']}",
      ansID: json['answerID']
    );
  }
}