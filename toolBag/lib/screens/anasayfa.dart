import 'package:flutter/material.dart';
import 'package:phonebook/screens/ShoppingList.dart';
import 'package:phonebook/screens/calculator.dart';
import 'package:phonebook/screens/phoneBook.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.all(60),
              child: Form(
                child: ListView(
                  children: [
                    Container(
                      width: 20,
                      height: 100,
                      child: Center(
                        child: Text(
                          "My Tool Bag",
                          style: TextStyle(fontSize: 25.0, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KategoriListesi()));
                          },
                          child: Text(
                            "Shopping List",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                          splashColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.white),
                          )),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      height: 30,
                      child: RaisedButton(
                          onPressed: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HesapMakinesi()));
                          },
                          child: Text(
                            "Calculator",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                          splashColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.white),
                          )),
                    ),
                     Divider(
                      color: Colors.white,
                    ),
                    Container(
                      height: 30,
                      child: RaisedButton(
                          onPressed: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KisiListesi()));
                          
                          },
                          child: Text(
                            "Phone Book",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                          splashColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
