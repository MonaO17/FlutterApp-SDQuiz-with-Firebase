import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../language_screen.dart';
import '../../quiz/podium_screen.dart';
import '../../quiz/quiz_end.dart';
import '../quiz_overview_screen.dart';


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
                    decoration: BoxDecoration( color: Colors.teal[800],),

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

                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=>QuizOverview())),
                ),
                ListTile(
                  leading: Icon(Icons.auto_awesome,
                    size: 30,),
                  title: Text('podium',
                  style: TextStyle(
                    fontSize: 17
                  ),
                  ).tr(),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=>QuizPodiumScreen())),
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
                //nur zur Überprüfung, später entfernen
                ListTile(
                  leading: Icon(Icons.language,
                    size: 30,),
                  title: Text('meine_Seite',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ).tr(),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=>QuizEndScreen())),
                ),


              ],
            )

        )
    );
  }
}
