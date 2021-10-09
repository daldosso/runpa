import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuItem>>(
      future: fetchMenu(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //List<MenuItem> data = snapshot.data;
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Username'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ExpansionTile(
                title: Text("Expansion Title"),
                children: <Widget>[
                  ListTile(
                    title: Text('Children 1'),
                    contentPadding: EdgeInsets.only(left: 30),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Children 2'),
                    contentPadding: EdgeInsets.only(left: 30),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container();
        //CircularProgressIndicator();
      },
    );
  }

  Future<List<MenuItem>> fetchMenu() async {
    {
      final response = await http
          .get(Uri.parse('https://spendynode.herokuapp.com/challenge-run'));
      final responseJson = json.decode(response.body);
      List<MenuItem> result = [];
      List<dynamic> data = responseJson["data"];

      data.forEach((element) {
        var challengeRun = MenuItem.fromJson(element);
        result.add(challengeRun);
      });

      return result;
    }
  }
}

class MenuItem {
  final String id;
  final String title;

  MenuItem({this.id, this.title});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      title: json['title'],
    );
  }
}
