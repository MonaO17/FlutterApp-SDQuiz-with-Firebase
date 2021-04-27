import 'package:flutter/material.dart';
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
                      backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2020/12/20/10/52/flower-5846658_1280.jpg'),
                    ),
                    accountName: Text('Spielername'), accountEmail: Text('Punktestand: 90'),
                    decoration: BoxDecoration( color: Colors.teal[900],),

                  ),
                ),
                ListTile( //Auswahl Menü führt zu entsprechenden Seite
                  leading: Icon(Icons.home,
                  size: 30,),
                  title: Text('Startseite',
                    style: TextStyle(
                        fontSize: 17
                    ),),

                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=>QuizOverviewScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.auto_awesome,
                    size: 30,),
                  title: Text('Pokale',
                  style: TextStyle(
                    fontSize: 17
                  ),),
                  onTap: () {},//=> Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomeScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.construction,
                    size: 30,),
                  title: Text('Einstellungen',
                    style: TextStyle(
                        fontSize: 17
                    ),),
                  onTap: () {},//=> Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomeScreen())),
                ),
              ],
            )
        )
    );
  }
}
