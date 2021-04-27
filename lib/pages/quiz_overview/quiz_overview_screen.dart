import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/quiz_overview/drawer_navigation.dart';


// Quelle https://www.youtube.com/watch?v=qQ75cxc5q8o&t=34s

// Sprachflaggen/Icons oben links?

class QuizOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // total height and with from device
    return Scaffold(
      appBar: AppBar(
        //title: Text('Guten Tag Spieler'), Text oben anzeigen?


        backgroundColor: Colors.teal[900],
      ),


      drawer: DrawerNavigation(), // bessere Platzierung, vlt AppBar raus nehmen?
      body:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: SafeArea(

              child: Column(
                children: [
                  Center( // nochmal anpassen
                    child: Text('Guten Tag Spieler', // Hier könnte der personalisierte Spielername stehen
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.teal[900],
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 120,),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      //childAspectRatio: .95,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                      children: [
                        CategoryCard(
                          title: 'Digitalisierung',
                          image: 'assets/digital.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),
                        CategoryCard(
                          title: 'Social Media',
                          image: 'assets/social_media.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),CategoryCard(
                          title: 'It Sicherheit',
                          image: 'assets/digital.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),
                        CategoryCard(
                          title: 'Aktuelle Trends',
                          image: 'assets/trend.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),
                        CategoryCard(
                          title: 'Aktuelle Trends',
                          image: 'assets/trend.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),
                        CategoryCard(
                          title: 'Aktuelle Trends',
                          image: 'assets/trend.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

      //),

    );
  }
}

// Initial Kategorie Feld /
class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final Function press;
  const CategoryCard({
    Key key, this.image, this.title, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      //borderRadius: BorderRadius.circular(13),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              boxShadow: [ //Schatten für die Kategorie Boxen (Spielerei kann man auch weg lassen)
                BoxShadow(
                  offset: Offset(0,17),
                  blurRadius: 17,
                  spreadRadius: -23,
                  color: Colors.teal[900],
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: press,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Spacer(),
                      Expanded(
                        child: Image.asset(image),
                        flex: 6,
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.teal[900],
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


    );
  }
}
