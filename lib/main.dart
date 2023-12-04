import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Image Generator',

      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String catImageURL='';
  requestCat() async{

    var result = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    var response =jsonDecode(result.body);
    print(result.body);
    print(response);
    print(response['message']);
    setState(() {
      catImageURL=response['message'];
    });
  }

  @override
  void initState() {
    requestCat();
    super.initState();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          requestCat();
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: Center(child: Text('Dog App')),
      ),
      body: Center(
        child: SizedBox(
          height: 350,
          width: 250,
          child: Card(
            elevation: 10,
            child: Column(
            children: [
              Text('How! How! How! ',style: TextStyle(fontSize: 20),),
              SizedBox(
                height: 20,
              ),
              catImageURL!="" ?
              Image(image: NetworkImage(catImageURL.toString()),height: 150,width: 200,):Text("loading"),

              Text("I'm loyal! "),
              Text('How! How! How! ',style: TextStyle(fontSize: 20),),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
