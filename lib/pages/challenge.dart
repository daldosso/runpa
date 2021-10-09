import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:runpa/model/challenge_run.dart';
import 'package:runpa/util/dbhelper.dart';

class ChallengeRunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenge Run'),
      ),
      body: Center(
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
                    title: Text("""
                      ${item.date}\n${item.name}\n${item.distance}\n${item.type}\n${item.place}\n${item.score}  
                    """
                        .trim()),
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
    );
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
    final response = await http
        .get(Uri.parse('https://spendynode.herokuapp.com/challenge-run'));
    final responseJson = json.decode(response.body);
    List<dynamic> data = responseJson["data"];

    data.forEach((element) {
      var challengeRun = ChallengeRun.fromJson(element);
      helper.insertChallengeRun(challengeRun);
      result.add(challengeRun);
    });
  }

  return result;
}
