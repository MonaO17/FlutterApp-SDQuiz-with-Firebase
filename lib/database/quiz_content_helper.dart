class QuizContentHelper {

  String questionID;
  String quizID;
  String question;
  String ansOne;
  //String sourceUrl;

  QuizContentHelper({this.questionID, this.quizID, this.question, this.ansOne});

  factory QuizContentHelper.fromJson(dynamic json) {
    return QuizContentHelper(
      questionID: "${json['QuestionID']}",
      quizID: "${json['QuizID']}",
      question: "${json['Question']}",
      ansOne: "${json['Ans1']}",
    );
  }



}