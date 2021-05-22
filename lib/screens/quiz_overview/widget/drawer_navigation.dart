import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import '../../settings/language_screen.dart';
import '../quiz_overview_screen.dart';


class DrawerNavigation extends StatefulWidget {
  int idCurrentUser;

  //constructor
  DrawerNavigation({Key key, @required this.idCurrentUser}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState(idCurrentUser);
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  //variables
  int idCurrentUser;
  DatabaseHelper helper = DatabaseHelper();
  User user;
  Future userFuture;

  //constructor
  _DrawerNavigationState(this.idCurrentUser);

  @override
  void initState() {
    super.initState();
    userFuture = _getUser(idCurrentUser);
  }

  _getUser(idCurrentUser) async {
    print('user $idCurrentUser');
    user = await helper.getCurrentUser(idCurrentUser);
    print(user.name);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Drawer(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,),
                        child: UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: // Profilbild vom User einfügen
                            NetworkImage(
                                'https://cdn.pixabay.com/photo/2016/12/21/00/36/woman-1921883_1280.jpg'),
                          ),
                          accountName: Text('${snapshot.data.name}'),
                          accountEmail: Text(
                              'Punktestand: ${snapshot.data.counter}'),
                          decoration: BoxDecoration(color: Colors.teal[800],),
                        ),
                      ),
                      ListTile( //Auswahl Menü führt zu entsprechenden Seite
                        leading: Icon(Icons.home,
                          size: 30,),
                        title: Text('start',
                          style: TextStyle(
                              fontSize: 17
                          ),
                        ).tr(),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    QuizOverviewScreen(
                                        idCurrentUser: idCurrentUser))),
                      ),
                      ListTile(
                        leading: Icon(Icons.language,
                          size: 30,),
                        title: Text('sprache',
                          style: TextStyle(
                              fontSize: 17
                          ),
                        ).tr(),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LanguageScreen())),
                      ),
                    ],
                  )
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
