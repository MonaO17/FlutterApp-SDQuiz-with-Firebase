import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/model/topic.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/screens/quiz/quiz_screen.dart';
import 'package:sd_quiz/screens/quiz_overview/widget/drawer_navigation.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/loading.dart';
import 'package:sd_quiz/screens/shared/text_button_app_bar.dart';
import 'package:sd_quiz/screens/welcome/welcome_screen.dart';
import '../../database/database_helper.dart';
import '../settings/language_screen.dart';
import 'widget/category_card.dart';

class QuizOverviewScreen extends StatefulWidget {
  final int idCurrentUser;

  //constructor
  QuizOverviewScreen({Key key, @required this.idCurrentUser}) : super(key: key);

  @override
  _QuizOverviewScreenState createState() =>
      _QuizOverviewScreenState(idCurrentUser);
}

class _QuizOverviewScreenState extends State<QuizOverviewScreen> {
  //variables
  int idCurrentUser;
  DatabaseHelper helper = DatabaseHelper();
  User user;
  List<Topic> topic;
  Future userFuture;

  //constructor
  _QuizOverviewScreenState(this.idCurrentUser);

  @override
  void initState() {
    super.initState();
    _getTopics();
    userFuture = _getUser(idCurrentUser);
  }

  //method gets relevant data from db
  _getTopics() async {
    print('get Topics');
    topic = await helper.getTopicList();
  }

  //method gets relevant data from db
  _getUser(idCurrentUser) async {
    print('user $idCurrentUser');
    user = await helper.getCurrentUser(idCurrentUser);
    print(user.name);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButtonAppBar(
              iconAppBar: Icons.language,
              title: 'Sprache',
              nextPage: LanguageScreen()),
          TextButtonAppBar(
              iconAppBar: Icons.person,
              title: 'Logout',
              nextPage: WelcomeScreen()),
        ],
        backgroundColor: mainColorSD,
      ),
      drawer: DrawerNavigation(idCurrentUser: idCurrentUser),


      body: FutureBuilder(
          future: userFuture,
          //body waits for this Future-variable until it appears
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),

                //Welcome Text
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                            child: Text(
                              'willkommen'.tr() + " ${snapshot.data.name}",
                              textAlign: TextAlign.center,
                              style: textStyle4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //List of quizzes to choose from
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2, // crossAxisCount is the number of columns
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          children: List.generate(topic.length, (index) {
                            return CategoryCard(
                              title: ('${topic[index].topic}'),
                              image: topic[index].topicPic,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return QuizScreen(
                                          topicID: topic[index].topicID,
                                          idCurrentUser: idCurrentUser);
                                    },
                                  ),
                                ); // Navigator
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Loading(); //while data is loading
            }
          }),
    );
  }
}
