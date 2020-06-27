import 'package:flutter/material.dart';

class MyGridView {
  GestureDetector getStructuredGridCell(name, icon) {
    // Wrap the child under GestureDetector to setup a on click action
    return GestureDetector(
      onTap: () {
        print("onTap called.");
      },
      child: Card(
        elevation: 1.5,
        child: new InkWell(
          onTap: () {
            print("tapped");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              //Image(image: AssetImage('data_repo/img/' + image)),
              Icon(
                icon,
                color: Colors.lightBlue,
                size: 150.0,
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

  GridView build() {
    return GridView.count(
      primary: true,
      padding: const EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        getStructuredGridCell("Team", Icons.person),
        getStructuredGridCell("Eventi", Icons.favorite),
        getStructuredGridCell("Challenge run", Icons.directions_run),
        getStructuredGridCell("Gare", Icons.people),
        getStructuredGridCell("Condividi", Icons.local_see),
        getStructuredGridCell("Negozio", Icons.shop),
      ],
    );
  }
}
