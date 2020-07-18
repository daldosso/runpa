import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final List<String> items = List<String>.generate(10000, (i) => "Item $i");
    List<Athlete> items = new List<Athlete>();
    fetchAthletes().then((value) => items = value);

    return Scaffold(
      appBar: AppBar(
        title: Text('Team'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${items[index]}'),
              );
            }),
      ),
    );
  }
}

Future<List<Athlete>> fetchAthletes() async {
  final response = await http.get(
    'https://www.podisticaarona.it/wp-json/pa2wp/mypa/v1/getteam/all',
    headers: {"authToken": "487d159c-6232-11ea-b350-b026281f6c28"},
  );
  final responseJson = json.decode(response.body);
  List<Athlete> result = new List<Athlete>();
  List<dynamic> data = responseJson["data"];
  data.forEach((element) {
    result.add(Athlete.fromJson(element));
  });
  return result;
}

class Athlete {
  final String lastName;
  final String id;
  final String firstName;

  Athlete({this.lastName, this.id, this.firstName});

  factory Athlete.fromJson(Map<String, dynamic> json) {
    return Athlete(
      id: json['ip_id'],
      lastName: json['ip_cognome'],
      firstName: json['ip_nome'],
    );
  }
}
