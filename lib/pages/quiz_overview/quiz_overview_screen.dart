import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/language_screen.dart';
import 'package:sd_quiz/pages/quiz_overview/widget/drawer_navigation.dart';
import 'package:easy_localization/easy_localization.dart';





class QuizOverviewScreen extends StatelessWidget {

  String dropdownValue = 'Deutsch - DE';
  String icon = "uk.png";




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // total height and with from device
    return Scaffold(
      appBar: AppBar(
        //title: Text('Guten Tag Spieler'), Text oben anzeigen?

        //Sprachauswahl
        actions:[
          Padding(padding:EdgeInsets.all(8.0),
            child:   IconButton(
           icon: Icon(Icons.language),
            color:Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LanguageScreen()));
              },

    ),
    ),
    ],





//hier actions ende
        backgroundColor: Colors.teal[900],
      ),
// hier Appbar Ende

      drawer: DrawerNavigation(), // bessere Platzierung, vlt AppBar raus nehmen?
      body:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,),

            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: Text( 'guten_tag'.tr(),
                          // Hier könnte der personalisierte Spielername stehen
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.teal[900],
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60,),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      //childAspectRatio: .95,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                      children: [
                        CategoryCard(
                          title: ('digitalisierung'.tr()),
                          image: 'assets/digital.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),
                        CategoryCard(
                          title: ('social_media'.tr()),
                          image: 'assets/social_media.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),CategoryCard(
                          title: ('digitalisierung'.tr()),
                          image: 'assets/digital.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),
                        CategoryCard(
                          title: ('it'.tr()),
                          image: 'assets/trend.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),
                        CategoryCard(
                          title: ('aktuell'.tr()),
                          image: 'assets/trend.jpg',
                          press: () {}, //Verlinkung zu Quizfragen
                        ),
                        CategoryCard(
                          title: ('digitalisierung'.tr()),
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
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(13),
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
