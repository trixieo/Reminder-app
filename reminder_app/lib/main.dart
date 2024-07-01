// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  //Ensures Flutter Bindings are initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  //Retrieves the stored theme mode from shared preferences
  final prefs = await SharedPreferences.getInstance();

  //if no theme mode is stored, default to the system's theme mode which is index: 0
  final themeMode =ThemeMode.values[prefs.getInt('themeMode')?? 0];

  //Run the app with the initial theme mode
  runApp(MyApp(themeMode: themeMode));
}



class MyApp extends StatefulWidget{

  final ThemeMode themeMode;

  //constructor to accept the initial theme mode
  MyApp({required this.themeMode});
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late ThemeMode _themeMode;
  @override
  void initState() {
    super.initState();
    //set the initial theme mode from the widget
    _themeMode = widget.themeMode;
  }
  //save the selected theme mode to preferences
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
  }
  
 
  // Toggle between light and dark theme modes
  void _onToggleTheme() {
    setState(() {
      // Switch between light and dark modes
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
      // Save the new theme mode
      saveThemeMode(_themeMode);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => MyAppState(),
      child:  MaterialApp(
        title: 'Reminder',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
           primaryColor: Colors.teal[800],
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Colors.grey[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.teal[600],),
        textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.grey)
      ),
      

      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
         primaryColor: Colors.teal[800],
        scaffoldBackgroundColor: Colors.black,
        dividerColor: Colors.grey[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.teal[600],
          textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.white)
      ),
      
      
    ),
    themeMode: _themeMode,
    home: MyHomePage(
      onToggleTheme: _onToggleTheme,
    ),
    ));
    
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
  final VoidCallback onToggleTheme;
  MyHomePage({required this.onToggleTheme});
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> MainPage(onToggleTheme: () { widget.onToggleTheme; },)));
    });
  }

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
        color: theme.colorScheme.primary,
        ),),
    ),
   );
  }}

class MainPage extends StatefulWidget{
  final VoidCallback onToggleTheme;
  MainPage({required this.onToggleTheme});
  @override
  State<MainPage> createState() => _MainPageState();
  }

class _MainPageState extends State<MainPage>{
  
  
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final date =appState.now;
    final buttonTheme = theme.buttonTheme;

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
                      Text(formattedDay, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55), ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                formattedMonth, 
                                style: TextStyle(fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(formattedYear, style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          Text(formattedDayOfWeek, style: TextStyle(fontWeight: FontWeight.bold),)
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
                      child: Icon(Icons.add, size: 30,),
                      
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
                            color: Color.fromARGB(255, 204, 220, 225), fontSize: 20,
                          )), Icon(Icons.more_vert,color: Color.fromARGB(255, 204, 220, 225), )],
                      ), Text('number of Scheduled' ,style: TextStyle(color: Color.fromARGB(255, 204, 220, 225)),)//TODO:Connect the length of the list of Schduled items to that part of the page
                      ],
                      )  
                      ),
                  ),
                )
                
              ],
              
            ), 
            ElevatedButton(onPressed: widget.onToggleTheme, child: Icon(Icons.dark_mode_rounded))
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