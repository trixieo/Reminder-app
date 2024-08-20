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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reminders", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                IconButton(onPressed: (){
                  
                }, icon: Icon(Icons.more_horiz, size: 40, color: Colors.black,)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    onTap: (){
                      
                    },
                    title: Text(reminders[index].title, style: TextStyle(color: Colors.black),),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

