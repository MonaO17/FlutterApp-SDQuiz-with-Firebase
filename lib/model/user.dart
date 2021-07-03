/* code partly inspired by
       - https://www.youtube.com/watch?v=t39VV2XyqR0&list=PLDQl6gZtjvFu5l20K5KTEBLCjfRjHowLj&index=6
*/

/// model class for user-object

class User {
  /// unique ID of user
  int _id;
  /// name of user
  String _name;
  /// password of user
  String _password;
  /// score of user
  int _counter;

  /// constructor [User]
  User(this._name, this._password, this._counter);

  /// named constructor
  User.withID(this._name, this._password, this._counter);

  /// getters
  /// returns user ID
  int get id => _id;
  /// returns user name
  String get name => _name;
  /// returns user password
  String get password => _password;
  /// returns user score
  int get counter => _counter;

  /// setters
  /// sets user name
  set name(String newName) {this._name = newName;}
  /// sets user password
  set password(String newPW) {this._password = newPW;}
  /// sets user score
  set counter(int newCounter) {
    if (newCounter >= 1 && newCounter <= 2) {
      this._counter = newCounter;
    }
  }

  /// converts a user-object into a map-object
  Map<String, dynamic> toMap() {
    //map['id'] etc are all Strings ('id', 'title', 'description'...) but on the right as a value we have Strings and ints => therefore we use dynamic.
    //if we would only have values of type int, we could define the Map as "Map<String, int> to Map()"
    var map = Map<String, dynamic>();     //instanciate map object

    map['id'] = _id;
    if (_id != null) { // check if id is null or not, depending on if it is used for insert or update
      map['id'] = _id;
    }
    map['name'] = _name;
    map['password'] = _password;
    map['counter'] = _counter;

    return map;
  }

  /// extracts a user-object from a map-object
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._password = map['password'];
    this._counter = map['counter'];
  }
}
