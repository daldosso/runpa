import 'package:flutter/material.dart';
import 'package:runpa/pages/events.dart';
import 'package:runpa/pages/team.dart';

class HomePage extends StatelessWidget {
  final MyGridView myGridView = MyGridView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Podistica Arona'), actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {},
        ),
      ]),
      body: myGridView.build(context),
    );
  }
}

class MyGridView {
  GestureDetector getStructuredGridCell(name, icon, onTap) {
    // Wrap the child under GestureDetector to setup a on click action
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1.5,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              //Image(image: AssetImage('data_repo/img/' + image)),
              Icon(
                icon,
                color: Colors.lightBlue,
                size: 100.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GridView build(BuildContext context) {
    return GridView.count(
      primary: true,
      padding: const EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 1,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        getStructuredGridCell("Team", Icons.person, () {
          print("onTap Team called.");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TeamPage()));
        }),
        getStructuredGridCell("Eventi", Icons.favorite, () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EventsPage()));
        }),
        getStructuredGridCell("Challenge run", Icons.directions_run, () {
          print("onTap called.");
          //Navigator.of(context).push(createRoute());
        }),
        getStructuredGridCell("Gare", Icons.people, () {
          print("onTap called.");
          //Navigator.of(context).push(createRoute());
        }),
        getStructuredGridCell("Condividi", Icons.local_see, () {
          print("onTap called.");
          //Navigator.of(context).push(createRoute());
        }),
        getStructuredGridCell("Negozio", Icons.shop, () {
          print("onTap called.");
          //Navigator.of(context).push(createRoute());
        }),
      ],
    );
  }
}
