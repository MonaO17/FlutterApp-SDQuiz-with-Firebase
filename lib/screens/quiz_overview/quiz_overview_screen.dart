/* code partly inspired by
       - https://www.youtube.com/watch?v=NEiy6-XWO8o
*/
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

/// QuizOverviewScreen shows all quizzes available
class QuizOverviewScreen extends StatefulWidget {
  final int idCurrentUser;

  /// constructor QuizOverviewScreen
  QuizOverviewScreen({Key key, @required this.idCurrentUser}) : super(key: key);

  /// calls _QuizOverviewScreenState, hands over variables
  @override
  _QuizOverviewScreenState createState() =>
      _QuizOverviewScreenState(idCurrentUser);
}

/// private class called by QuizOverviewScreen, can change state
class _QuizOverviewScreenState extends State<QuizOverviewScreen> {
  int idCurrentUser;
  DatabaseHelper helper = DatabaseHelper();
  User user;
  List<Topic> topic;
  Future userFuture;

  /// constructor _QuizOverviewScreenState
  _QuizOverviewScreenState(this.idCurrentUser);

  /// initState is called first, calls method [_getTopics()] and initializes [userFuture] with return value of method [_getUser()]
  @override
  void initState() {
    super.initState();
    _getTopics();
    userFuture = _getUser(idCurrentUser);
  }

  /// initializes [topic] with return value of  [DatabaseHelper]-method [getTopicList()]
  _getTopics() async {
    print('get Topics');
    topic = await helper.getTopicList();
  }

  /// initializes [user] with return value of [DatabaseHelper]-method [getCurrentUser], returns [user]
  _getUser(idCurrentUser) async {
    print('user $idCurrentUser');
    user = await helper.getCurrentUser(idCurrentUser);
    print(user.name);
    return user;
  }

  /// builds screen with Scaffold-Widget, contains welcome-text, list of quizzes
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
