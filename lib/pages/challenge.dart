import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:runpa/model/challenge_run.dart';
import 'package:runpa/pages/team.dart';
import 'package:runpa/util/dbhelper.dart';

class ChallengeRunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Challenge Run'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Calendario', icon: Icon(Icons.calendar_view_month)),
                Tab(text: 'Classifica', icon: Icon(Icons.list)),
              ],
            ),
          ),
          body: TabBarView(children: [
            Center(
              child: FutureBuilder<List<ChallengeRun>>(
                future: fetchAthletes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ChallengeRun> data = snapshot.data;
                    return ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var item = data[index];
                        return ListTile(
                          title: Text(
                              """${item.date}\n\n${item.description}""".trim()),
                          contentPadding: EdgeInsets.all(20),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 5,
                          color: Colors.blue,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            Container(
              child: ListView(children: [
                Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                      top: 20,
                      right: 0,
                      bottom: 20,
                    ),
                    child: Text(
                      "Classifica Femminile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue.withOpacity(0.6),
                        fontSize: 40,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    )),
                FutureBuilder<List<ChallengeRun>>(
                  future: fetchAthletes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ChallengeRun> data = snapshot.data;
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var item = data[index];
                          return ListTile(
                            title: Text(
                                """${item.date}\n${item.description}""".trim()),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 5,
                            color: Colors.blue,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                      top: 20,
                      right: 0,
                      bottom: 20,
                    ),
                    child: Text(
                      "Classifica Machile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue.withOpacity(0.6),
                        fontSize: 40,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    )),
                FutureBuilder<List<ChallengeRun>>(
                  future: fetchAthletes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ChallengeRun> data = snapshot.data;
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var item = data[index];
                          return ListTile(
                            title: Text(
                                """${item.date}\n${item.description}""".trim()),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 5,
                            color: Colors.blue,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                )
              ]),
            )
          ]),
        ));
  }
}

Future<List<ChallengeRun>> fetchAthletes() async {
  List<ChallengeRun> result = [];

  DbHelper helper = DbHelper();
  await helper.initializeDb();

  var challengeRuns = await helper.getChallengeRuns();
  if (challengeRuns.length > 0) {
    challengeRuns.forEach((element) {
      var challengeRun = ChallengeRun.fromMap(element);
      result.add(challengeRun);
    });
  } else {
    final response = await http.get(
      Uri.parse(
          'https://www.podisticaarona.it/wp-json/pa2wp/mypa/v1/getchallengerun/calendar'),
      headers: {"authToken": "487d159c-6232-11ea-b350-b026281f6c28"},
    );
    List<dynamic> data = json.decode(response.body);

    data.forEach((element) {
      var challengeRun = ChallengeRun.fromJson(element);
      helper.insertChallengeRun(challengeRun);
      result.add(challengeRun);
    });
  }

  return result;
}

Future<List<Athlete>> fetchFemaleChart() async {
  List<Athlete> result = [];

  final response = await http.get(Uri.parse(
      'https://www.podisticaarona.it/wp-json/pa2wp/mypa/v1/getchallengerun/calendar'));
  final responseJson = json.decode(response.body);
  List<dynamic> data = responseJson["data"];

  data.forEach((element) {
    var challengeRun = Athlete.fromJson(element);
    result.add(challengeRun);
  });

  return result;
}
