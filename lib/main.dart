import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main(){
  runApp(
    MaterialApp(
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final url = 'https://swapi.co/api/starships/';
  List data;

  Future <String> getSWData() async{
    var res = await http
        .get(Uri.encodeFull(url),headers: {'Accept':'application/json'});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody['results'];
    });
    return 'Success!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spaceship'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context,int index){
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Name: '),
                        Text(
                          data[index]['name'],
                          style: TextStyle(
                            color: Colors.blueAccent
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Model: '),
                        Text(
                          data[index]['model'],
                          style: TextStyle(
                            color: Colors.red
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}