import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   @override
  MyAppState createState()=> MyAppState();
}

class MyAppState extends State<MyApp>{
  TextEditingController etnum1 = new TextEditingController();
  TextEditingController etnum2 = new TextEditingController();
  
  int num1=0;
  int num2=0;
  int result=0;
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [TextField(
            controller: etnum1,
          decoration: InputDecoration(
            
            hintText:"Enter a num1"
          )),
                TextField(
                   controller: etnum2,
          decoration: InputDecoration(
            
            hintText:"Enter a num2"
          )), 
                     
                 Row(
                   children:[
                     Container(
                       padding:EdgeInsets.fromLTRB(20,10,20,0),
                   child:  RaisedButton(onPressed:(){
                       setState((){
                         num1=int.parse(etnum1.text);
                         num2=int.parse(etnum2.text);
                         result=num1+num2;
                       });
                     } ,child:Text("Add"))),
                      Container(
                       padding:EdgeInsets.fromLTRB(20,10,20,0),
                   child:RaisedButton(onPressed:(){
                       setState((){
                         num1=int.parse(etnum1.text);
                         num2=int.parse(etnum2.text);
                         result=num1-num2;
                       });
                     } ,child:Text("Sub"))),
                      Container(
                       padding:EdgeInsets.fromLTRB(20,10,20,0),
                   child:RaisedButton(onPressed:(){
                       setState((){
                         num1=int.parse(etnum1.text);
                         num2=int.parse(etnum2.text);
                         result=num1*num2;
                       });
                     },child:Text("multi"))),
                     
                   
                    ]
                   ),
                      Text("$result"), 
              ]    )
          ));
        
  }
}

