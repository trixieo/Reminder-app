import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
          scaffoldBackgroundColor: Color.fromARGB(255, 6, 23, 41),
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Color.fromARGB(255, 204, 220, 225)),
          
       ),
       elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
        ),
       ),
       
       
      ),home: MyHomePage(),
    ),
    );
    
  }
}
class MyAppState extends ChangeNotifier{
  final reminders=[];
  void addNew(){
    reminders.add(NewReminder());
  }


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
    Timer(Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> MainPage()));
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
  @override
  State<MainPage> createState() => _MainPageState();
  }

class _MainPageState extends State<MainPage>{
  DateTime now = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

     String formattedDay = DateFormat('dd').format(now);
     String formattedMonth = DateFormat('MMMM').format(now);
     String formattedYear = DateFormat('yyyy').format(now);
     String formattedDayOfWeek = DateFormat('EEEE').format(now);  
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
                              Text(formattedMonth, style: TextStyle(fontWeight: FontWeight.bold),),Padding(
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
                  child: FloatingActionButton(onPressed: ()
                  {Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => NewReminder(),));
                          
                  }, child: Icon(Icons.add, size: 30,),),
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
  ])
          )
          );
    
  }

}


class NewReminder extends StatelessWidget{
  final reminder = [];
  final date= DateFormat('dd-MMMM-yyyy').format(DateTime.now());
 @override
 Widget build(BuildContext context) {
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
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 250,
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
        ElevatedButton(onPressed: (){}, child: Row(
          children: [Text('Date')],
        ))
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