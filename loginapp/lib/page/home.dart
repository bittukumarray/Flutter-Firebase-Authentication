import 'package:flutter/material.dart';
import './food.dart';

class HomePage extends StatefulWidget {
  bool token;
  HomePage(this.token);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Widget Welcome() {
    return Center(
      child: Text("Welcome"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.pink[100],
          appBar: AppBar(
            backgroundColor: Colors.pinkAccent,
            title: Text("Flutter Title"),
            bottom: TabBar(
              // isScrollable: true,
              tabs: <Widget>[
                Tab(child: Text("HOME")),
                Tab(
                  child: Text("FOODS"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Welcome(),
              widget.token ? FoodPage() : Container(),
            ],
          )),
    );
  }
}
