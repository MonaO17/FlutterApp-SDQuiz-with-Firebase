import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/loading.dart';
import '../../settings/language_screen.dart';
import '../quiz_overview_screen.dart';

/// DrawerNavigation is the menu, where the user can see his [score] and set the language
class DrawerNavigation extends StatefulWidget {
  final int idCurrentUser;

  /// constructor DrawerNavigation
  DrawerNavigation({Key key, @required this.idCurrentUser}) : super(key: key);

  /// calls _DrawerNavigationState, hands over variable [idCurrentUser]
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState(idCurrentUser);
}

/// private class called by DrawerNavigation, can change state
class _DrawerNavigationState extends State<DrawerNavigation> {
  /// identifies user
  int idCurrentUser;
  /// instance of [DatabaseHelper]
  DatabaseHelper helper = DatabaseHelper();
  // user-object
  User user;
  /// future variable, needed for future-builder
  Future userFuture;

  /// constructor_DrawerNavigationState
  _DrawerNavigationState(this.idCurrentUser);

  /// initState is called first, initializes [userFuture] with return value of method [_getUser()]
  @override
  void initState() {
    super.initState();
    userFuture = _getUser(idCurrentUser);
  }

  /// initializes [user] with return value of [DatabaseHelper]-method [getCurrentUser], returns [user]
  _getUser(idCurrentUser) async {
    print('DrawerNavigation user $idCurrentUser');
    user = await helper.getCurrentUser(idCurrentUser);
    print(user.name);
    return user;
  }

  /// builds screen with Scaffold-Widget, contains image, [score] and [name] of [user], 2 ListTiles
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
                          accountEmail: Text('Punktestand: ${snapshot.data.counter}'),
                          decoration: BoxDecoration(color: mainColorSD,),
                        ),
                      ),
                      ListTile( //Auswahl Menü führt zu entsprechenden Seite
                        leading: Icon(Icons.home,
                          size: 30,),
                        title: Text('start',
                          style: textStyle2,
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
                          style: textStyle2,
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
            return Loading();
          }
        }
    );
  }
}
