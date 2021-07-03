/* code partly inspired by
       - https://www.youtube.com/watch?v=xke5_yGL0uk&list=PLDQl6gZtjvFu5l20K5KTEBLCjfRjHowLj&index=9
*/

/// model class for topic-object

class Topic {
  /// unique topic ID
  int topicTableID;
  /// topic ID from Google Sheet
  int topicID;
  /// topic name
  String topic;
  /// topic picture (in form of a link)
  String topicPic;

  /// constructor [Topic]
  Topic({this.topicID, this.topic, this.topicPic});

  /// convert a topic-object into a map-object
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

  /// extracts a quiz-object from a map-object
  Topic.fromMapObject(Map<String, dynamic> map) {
    this.topicTableID = map['topicTableID'];
    this.topic = map['topic'];
    this.topicID = map['topicID'];
    this.topicPic = map['topicPic'];
  }

  /// receives [json], converts [json] into topic-object
  factory Topic.fromJson(dynamic json) {
    return Topic(
        topicID: json['topicID'],
        topic: "${json['topicName']}",
        topicPic: "${json['topicPicture']}");
  }
}
