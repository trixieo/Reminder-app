// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main(){
  
  runApp(const MyApp());
}
final darknotifier = ValueNotifier<bool>(false);



class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: ValueListenableBuilder<bool>(
        valueListenable: darknotifier,
        builder: (BuildContext context , bool isDark, Widget? child){
          return MaterialApp(
            title: 'Reminder',
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              primaryColor: Colors.teal,
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  iconColor: Color.fromARGB(255, 204, 220, 225),
                  foregroundColor: Color.fromARGB(255, 204, 220, 225)
                  
                )
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.teal,
                foregroundColor: Color.fromARGB(255, 204, 220, 225),
                
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              )
            ),
            darkTheme: ThemeData.dark().copyWith(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Color.fromARGB(255, 204, 220, 225),
                  iconColor: Color.fromARGB(255, 204, 220, 225),
                )
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.teal,
              )
            ),
            
            
            home: MyHomePage()
              );
        })
      );
        }
      
    
  
}
class MyAppState extends ChangeNotifier{
  final reminders=[];
  void addNew(){
    reminders.add(NewReminder());
  }
  DateTime now = DateTime.now();
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> MainPage()));
    });
  }

  //this is the start of the build of the first page

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    
   return Scaffold(
    backgroundColor: theme.scaffoldBackgroundColor,
    body: Center(
      child: Text("The Reminder", 
      style: TextStyle(
        fontSize: 36, 
        fontWeight: FontWeight.bold, 
        fontStyle: FontStyle.italic,
        color: theme.primaryColor,
        ),),
    ),
   );
  }}

class MainPage extends StatefulWidget{

  @override
  State<MainPage> createState() => _MainPageState();
  }

class _MainPageState extends State<MainPage>{
  @override
  void dispose(){
    darknotifier.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final date =appState.now;
    bool isDark = darknotifier.value;

    String formattedDay = DateFormat('dd').format(date);
    String formattedMonth = DateFormat('MMMM').format(date);
    String formattedYear = DateFormat('yyyy').format(date);
    String formattedDayOfWeek = DateFormat('EEEE').format(date);  


    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Text(formattedDay, style: theme.textTheme.bodyLarge,
                         ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                formattedMonth, 
                                style: theme.textTheme.bodyMedium,),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(formattedYear, style: theme.textTheme.bodyMedium,),
                              ),
                            ],
                          ),
                          Text(formattedDayOfWeek, style: theme.textTheme.bodyMedium, )
                        ],
                      ),
                      
                    ],
                  ),
                ),
                
                
                // The below part adds a button which will be used to redirect to another page
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: 
                    FloatingActionButton(onPressed: ()
                      {Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => myNewreminder(),));
                          
                      }, 
                      child: Icon(Icons.add, size: 30, color: Colors.white,),
                      
                      ),
                      
                )
                ]
                ),
                //This is the point at which the buttons for the completed and the scheduled pages are added
                //the first is the completed
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(top:20 , left: 15),
                  child: SizedBox(
                    width: 180,
                    height:150,
                    child: ElevatedButton(
                      onPressed: (){
                     
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CompletedReminder()));
                                  
                    }, style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 17),
                      alignment: Alignment.topLeft,
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ), child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          
                          children: [Text('Completed', style: TextStyle(
                            color: Color.fromARGB(255, 204, 220, 225), fontSize: 20,
                          )), Icon(Icons.more_vert,color: Color.fromARGB(255, 204, 220, 225), )],
                      ), Text('number of completed' ,style: TextStyle(color: Color.fromARGB(255, 204, 220, 225)),)//TODO:Connect the length of the list of completed items to that part of the page
                      ],
                      )  
                      ),
                  ),


                //This is the part for the scheduled button
                ), Padding(
                  padding: const EdgeInsets.only(top:20 , left: 15, right: 15),
                  child: SizedBox(
                    width: 180,
                    height:150,
                    child: ElevatedButton(
                      onPressed: (){
                     
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScheduledReminder()));
                                  
                    }, style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 17),
                      alignment: Alignment.topLeft,
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ), child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          
                          children: [Text('Scheduled', style: TextStyle(
                             fontSize: 20,
                          )), Icon(Icons.more_vert,color: Color.fromARGB(255, 204, 220, 225), )],
                      ), Text('number of Scheduled' ,style: TextStyle(color: Color.fromARGB(255, 204, 220, 225)),)//TODO:Connect the length of the list of Schduled items to that part of the page
                      ],
                      )  
                      ),
                  ),
                )
                
              ],
              
            ),
            
            //This sized box is to generate space between the two parts and the all reminders button
            SizedBox(
              height: 10,
            ), 
            
            //this is the section for the all reminders button
            SizedBox(
              height: 40,
              width: 380,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> Allreminders()));
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All reminders", style: TextStyle(fontSize: 20),),
                    Icon(Icons.arrow_forward_sharp, size: 30,)
                ],
              ))),
            ElevatedButton(onPressed: (){
              isDark = !isDark;
              darknotifier.value = isDark;
            }, style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white
            ), child: Icon(isDark? Icons.wb_sunny_outlined : Icons.wb_sunny_rounded),)
           
            ])
          )
          );
    
  }

}
class myNewreminder extends StatefulWidget{
  @override
  State<myNewreminder> createState() => NewReminder();
}

class NewReminder extends State<myNewreminder>{
  
  final reminder = [];
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
 Widget build(BuildContext context) {
  // ignore: unused_local_variable
  var appState = context.watch<MyAppState>();
  
  String date = DateFormat('dd-MMMM-yyyy').format(selectedDate.toLocal());
  

   return Scaffold(
    body: Column(
      
      children: [
        //This is the title of the reminder field
        Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Title',
              
            ),
          ),
        ),
        //The description part
             Flexible(
              flex: 250,
                      // ignore: sized_box_for_whitespace, avoid_unnecessary_containers
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),

                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Description',
                          
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
   );


  }
}
class CompletedReminder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          // TODO: implement build

    );
  }
}
class ScheduledReminder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

    );
  }
}
class Allreminders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}