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
              List<Challenge>? data = snapshot.data;
              return ListView.separated(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${data[index].date} ${data[index].name}'),
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

Future<List<Challenge>> fetchAthletes() async {
  final response = await http
      .get(Uri.parse('https://spendynode.herokuapp.com/challenge-run'));
  final responseJson = json.decode(response.body);
  List<Challenge> result = [];
  List<dynamic> data = responseJson["data"];
  data.forEach((element) {
    result.add(Challenge.fromJson(element));
  });
  return result;
}

class Challenge {
  final String date;
  final String name;

  Challenge({required this.date, required this.name});

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      date: json['date'],
      name: json['name'],
    );
  }
}
