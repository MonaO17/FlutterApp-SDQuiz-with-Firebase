import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/language_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/pages/quiz_overview/quiz_overview_screen.dart';


class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Drawer(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,),
                  child: UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: // Profilbild vom User einfügen
                      NetworkImage('https://cdn.pixabay.com/photo/2017/11/29/09/15/paint-2985569_1280.jpg'),
                    ),
                    accountName: Text('Spielername'), accountEmail: Text('Punktestand: 90'),
                    decoration: BoxDecoration( color: Colors.teal[900],),

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

                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=>QuizOverviewScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.auto_awesome,
                    size: 30,),
                  title: Text('pokal',
                  style: TextStyle(
                    fontSize: 17
                  ),
                  ).tr(),
                  onTap: () {},//=> Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomeScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.language,
                    size: 30,),
                  title: Text('sprache',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ).tr(),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LanguageScreen())),
                ),
              ],
            )
        )
    );
  }
}
