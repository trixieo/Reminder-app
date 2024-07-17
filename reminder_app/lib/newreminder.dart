// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class reminder{
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;

  const reminder({ required this.description, required this.date, required this.time, 
    required this.title,  
  });
  }

class myNewreminder extends StatefulWidget{
  @override
  State<myNewreminder> createState() => NewReminder();
}

class NewReminder extends State<myNewreminder>{
    
  final GlobalKey<FormState> _reminderkey = GlobalKey<FormState>();
  final titlecontroller= TextEditingController();
  final desccontroller = TextEditingController();
  final List<reminder> reminders =[];
  String? title;
  
  
  DateTime selectedDate = DateTime.now();

  Future<void> DateSelection(context) async{
    //date picker dialog
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2197));
    
    if (picked != null && picked!=selectedDate){
      setState(() {
        selectedDate=picked;
      });
      
      
    }
  }
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> Timeselection(context) async{
    final TimeOfDay? timePicked = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now());
      
      if (timePicked !=null){
        setState(() {
          selectedTime=timePicked;
        });
      }
  }
  @override
  void dispose() {
    // cleans up the controller when the widget is disposed
    titlecontroller.dispose();
    super.dispose();
  }
  
  

  
 @override
 Widget build(BuildContext context) {
  // ignore: unused_local_variable
  var appState = context.watch<MyAppState>();
  
  String date = DateFormat('dd-MMMM-yyyy').format(selectedDate.toLocal());

   return Scaffold(
     body:  Form(
      key: _reminderkey,
      child: Column(
        
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 300, top: 30, right: 0),
            child: FloatingActionButton(
              onPressed: (){
                
              }, 
              child: Icon(Icons.check_sharp),
              ),
          ),
          //This is the title of the reminder field
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: TextFormField(
              controller: titlecontroller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Title',
                focusColor: Colors.black,
                hintStyle: TextStyle(color: Colors.black)
                
              ),
              onChanged: (value) {
                title = value;
              },
            ),
          ),
          //The description part

          Flexible(
            flex: 250,
            // ignore: sized_box_for_whitespace, avoid_unnecessary_containers
            child:
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: desccontroller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.black),
                    ),
                    maxLines: null,
                ),
              ),
            ),
           //This is the date selection button section    
                     
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 13 ),
            child: ElevatedButton(onPressed: (){
              DateSelection(context);
            }, child: Row(
              children:  [ 
                Icon(
                  Icons.calendar_month, 
                  color: Colors.white,), 
                SizedBox(
                  width: 10,),
                  Text(
                    date, 
                    style: TextStyle(
                      color: Colors.white),)],
                    
            ),
            ),
          ),
     
          //this is the section for the time section picker
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, ),
            child: ElevatedButton(onPressed: (){
              Timeselection(context);
            
            }, child: 
            
            Row(
              children: [ Icon(Icons.access_alarm, color: Colors.white,),
              // ignore: unnecessary_string_interpolations
                Text('${selectedTime.format(context)}', style: TextStyle(color: Colors.white),),
              ],
            )),
          ),
          
        ],
      ),
     ),
   );


  }
}