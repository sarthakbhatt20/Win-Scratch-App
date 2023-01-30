// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage rupee = AssetImage("images/rupee.png");
  AssetImage sad = AssetImage("images/sadFace.png");

  List<String> itemArray = [];
  int luckyNumber = 0;

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandom();
  }

  generateRandom() {
    setState(() {
      luckyNumber = Random().nextInt(25);
    });
  }

  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateRandom();
  }

  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return rupee;
      case "unlucky":
        return sad;
    }
    return circle;
  }

  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
  }

  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            itemCount: itemArray.length,
            itemBuilder: (context, index) => SizedBox(
              width: 50.0,
              height: 50.0,
              child: MaterialButton(
                onPressed: () {
                  this.playGame(index);
                },
                child: Image(
                  image: this.getImage(index),
                ),
              ),
            ),
          )),
          Container(
            margin: EdgeInsets.all(15.0),
            child: MaterialButton(
              color: Color.fromARGB(255, 246, 144, 28),
              onPressed: resetGame,
              child: Text('Reset',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              minWidth: 200.0,
              height: 50.0,
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: MaterialButton(
              color: Color.fromARGB(255, 246, 144, 28),
              onPressed: showAll,
              child: Text('Show All',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              minWidth: 200.0,
              height: 50.0,
            ),
          )
        ],
      ),
    );
  }
}
