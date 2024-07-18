// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'newreminder.dart';

class Allreminders extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Allreminders();
}


class _Allreminders extends State<Allreminders>{
  
  @override
  Widget build(BuildContext context) {
    
    // ignore: unnecessary_null_comparison
    if (reminders==null){
      return Center(
        child: Text('You have no reminders'),
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onTap: (){
                
              },
              title: Text(reminders[index].title, ),
            ),
          );
        },
      ),
    );
  }
}

