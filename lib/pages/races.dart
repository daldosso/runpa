import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gare'),
      ),
      body: Center(
        child: FutureBuilder<List<Challenge>>(
          future: fetchAthletes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Challenge> data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${data[index].date} ${data[index].title}'),
                    );
                  });
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

Future<List<Challenge>> fetchAthletes() async {
  final response =
      await http.get('https://spendynode.herokuapp.com/challenge-run');
  final responseJson = json.decode(response.body);
  List<Challenge> result = new List<Challenge>();
  List<dynamic> data = responseJson["data"];
  data.forEach((element) {
    result.add(Challenge.fromJson(element));
  });
  return result;
}

class Challenge {
  final String date;
  final String title;

  Challenge({this.date, this.title});

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      date: json['date'],
      title: json['title'],
    );
  }
}
