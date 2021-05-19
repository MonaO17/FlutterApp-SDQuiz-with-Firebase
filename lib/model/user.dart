class User {
  int _id;
  String _name;
  String _password;
  int _counter;

  // constructor
  User(this._name, this._password, this._counter); // [] makes the description optional!

  // named constructor
  User.withID(this._name, this._password, this._counter);                     // MIT ID ??????

  // getters
  int get id => _id;
  String get name => _name;
  String get password => _password;
  int get counter => _counter;

  // setters
  //id is generated automatically
  set name(String newName) {
    //if (newTitle.length <= 255 {
    this._name = newName;
    //}
  }

  set password(String newPW) {
    this._password = newPW;
  }

  set counter(int newCounter) {
    if (newCounter >= 1 && newCounter <= 2) {
      this._counter = newCounter;
    }
  }

  //Convert a User object into a Map object
  Map<String, dynamic> toMap() {
    //map['id] etc are all Strings ('id', 'title', 'description'...) but on the right as a value we have Strings and ints => therefore we use dynamic.
    //if we would only have values of type int, we could define the Map as "Map<String, int> to Map()"
    //instanciate map object
    var map = Map<String, dynamic>();

    map['id'] = _id;
    if (id != null) {
      // check if id is null or not, depending on if it is used for insert or update
      map['id'] = _id;
    }
    map['name'] = _name;
    map['password'] = _password;
    map['counter'] = _counter;

    return map;
  }

  //Extract a User object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._password = map['password'];
    this._counter = map['counter'];
  }
}
