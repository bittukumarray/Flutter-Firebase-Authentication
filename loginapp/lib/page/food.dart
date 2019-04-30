import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/sweets.jpg"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text("Sweets"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/curd.jpg"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text("Curd"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/milk.jpg"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text("Milk"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/eggs.jpg"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text("Eggs"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/bakery.jpeg"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text("Bakery"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
