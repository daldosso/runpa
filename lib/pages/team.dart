import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team'),
      ),
      body: Center(
        child: FutureBuilder<List<Athlete>>(
          future: fetchAthletes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Athlete> data = snapshot.data;
              return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      //backgroundImage: AssetImage('data_repo/img/logo_top.png'),
                      backgroundImage: CachedNetworkImageProvider(data[index]
                          .photo) /*CachedNetworkImage(
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        imageUrl: data[index].photo,
                      )*/
                      ,
                    ),
                    title: Text(
                        '${data[index].firstName} ${data[index].lastName}'),
                    onTap: () {},
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

Future<List<Athlete>> fetchAthletes() async {
  final response = await http.get(
    Uri.parse(
        'https://www.podisticaarona.it/wp-json/pa2wp/mypa/v1/getteam/all'),
    headers: {"authToken": "487d159c-6232-11ea-b350-b026281f6c28"},
  );
  final responseJson = json.decode(response.body);
  List<Athlete> result = [];
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
  final String photo;

  Athlete({this.lastName, this.id, this.firstName, this.photo});

  factory Athlete.fromJson(Map<String, dynamic> json) {
    return Athlete(
      id: json['ip_id'],
      lastName: json['ip_cognome'],
      firstName: json['ip_nome'],
      photo: json['foto_400x400'],
    );
  }
}
