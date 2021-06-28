class Topic {
  int topicTableID;
  int topicID;
  String topic;
  String topicPic;

  // constructor
  Topic({this.topicID, this.topic, this.topicPic});

  //Convert a Topic object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>(); //instanciate map object

    map['topicTableID'] = topicTableID;
    if (topicTableID != null) {
      map['topicTableID'] = topicTableID;
    }
    map['topicID'] = topicID;
    map['topic'] = topic;
    map['topicPic'] = topicPic;

    return map;
  }

  //Extract a Quiz object from a Map object
  Topic.fromMapObject(Map<String, dynamic> map) {
    this.topicTableID = map['topicTableID'];
    this.topic = map['topic'];
    this.topicID = map['topicID'];
    this.topicPic = map['topicPic'];
  }

  // convert JSON that we get into this model(=QuizContentHelper) in this class (seperate Strings etc.)
  factory Topic.fromJson(dynamic json) {
    return Topic(
        topicID: json['topicID'],
        topic: "${json['topicName']}",
        topicPic: "${json['topicPicture']}");
  }
}
