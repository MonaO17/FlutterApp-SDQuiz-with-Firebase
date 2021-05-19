import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/view/quiz_overview/widget/drawer_navigation.dart';
import '../../database/database_helper.dart';
import '../language_screen.dart';

class QuizOverview extends StatefulWidget {
  int idCurrentUser;

  //constructor
  QuizOverview({Key key, @required this.idCurrentUser}) : super(key: key);

  @override
  _QuizOverviewState createState() => _QuizOverviewState(idCurrentUser);
}

class _QuizOverviewState extends State<QuizOverview> {
  int idCurrentUser;
  DatabaseHelper helper = DatabaseHelper();
  int userID;
  User user;
  Future userFuture;

  //constructor
  _QuizOverviewState(this.idCurrentUser);

  @override
  void initState() {
    super.initState();
    userFuture = _getUser(idCurrentUser);
  }

  _getUser(userID) async {
    print('user $userID');
    user = await helper.getCurrentUser(userID);
    print(user.name);
    return user;
  }

  String dropdownValue = 'Deutsch - DE';
  String icon = "uk.png";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // total height and with from device
    return Scaffold(
      appBar: AppBar(
        //title: Text('Guten Tag Spieler'), Text oben anzeigen?

        //Sprachauswahl
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.language),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LanguageScreen()));
              },
            ),
          ),
        ],

//hier actions ende
        backgroundColor: Colors.teal[800],
      ),
// hier Appbar Ende

      drawer: DrawerNavigation(),
      // bessere Platzierung, vlt AppBar raus nehmen?
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SafeArea(
          child: Column(
            children: [
              FutureBuilder(
                  future: userFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                            child: Text(
                              "guten_tag ${snapshot.data.name}".tr(),
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
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              SizedBox(
                height: 60,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  //childAspectRatio: .95,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  children: [
                    CategoryCard(
                      title: ('digitalisierung'.tr()),
                      image: 'assets/digital1.jpg',
                      press: () {}, //Verlinkung zu Quizfragen
                    ),
                    CategoryCard(
                      title: ('social_media'.tr()),
                      image: 'assets/android.jpg',
                      press: () {}, //Verlinkung zu Quizfragen
                    ),
                    CategoryCard(
                      title: ('digitalisierung'.tr()),
                      image: 'assets/digital1.jpg',
                      press: () {}, //Verlinkung zu Quizfragen
                    ),
                    CategoryCard(
                      title: ('it'.tr()),
                      image: 'assets/trend1.jpg',
                      press: () {}, //Verlinkung zu Quizfragen
                    ),
                    CategoryCard(
                      title: ('aktuell'.tr()),
                      image: 'assets/android.jpg',
                      press: () {}, //Verlinkung zu Quizfragen
                    ),
                    CategoryCard(
                      title: ('digitalisierung'.tr()),
                      image: 'assets/trend1.jpg',
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
    Key key,
    this.image,
    this.title,
    this.press,
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
