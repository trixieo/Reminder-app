import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => MyAppState(),
      child:  MaterialApp(
        title: 'Reminder',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.teal,
        ).copyWith(
            secondary: Colors.blue, // Green as the accent color
        ),
          scaffoldBackgroundColor: Color(0xFFF8F9FA),
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.black),
       ),
       
       
      ),home: MyHomePage(),
    ),
    );
    
  }
}
class MyAppState extends ChangeNotifier{
  

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: Center(
      child: Text("The Reminder", 
      style: TextStyle(
        fontSize: 36, 
        fontWeight: FontWeight.bold, 
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(255, 5, 126, 150)),),
    ),
   );
  }}

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}