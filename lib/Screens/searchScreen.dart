
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_practice/db/functions/db_functions.dart';
import 'package:sqflite_practice/db/models/data_model.dart';

final _SearchController = TextEditingController();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
List<StudentModel> studentlist = [];

void _searchstudent(String query) async{
  final results = await searchStudents(query);
  setState(() {
    studentlist = results;
  });
}

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Student"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: 
        
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _SearchController,
                  onChanged: (query) {
                    _searchstudent(query);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                    labelText: "Enter Student Name",
                  ),
                ),
              ),
              Expanded(child: ListView.builder(
                itemCount: studentlist.length,
                itemBuilder: (context, index) {
                  final student = studentlist[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(context: context, builder: (ctx1){
                        return Container(
                             child: Column(
                              children: [
                                CloseButton(color: Colors.red,),
                                Text("Name: "+student.name,
                                style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              
                            ),
                            ),

                            SizedBox(height: 15),
    
                            Text("Age: "+ student.age,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              
                            ),
                            ),
    
                            SizedBox(height: 15),
    
                            Text("Class: "+ student.cls,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              
                            ),
                            ),
    
                            SizedBox(height: 15),
    
                            Text("Address: " + student.address,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              
                            ),
                            ),

                              ],
                             ),
                        );
                      });
                    },
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.black38,
                      color: Colors.grey[300],
                        child: ListTile(
                        title: Text(student.name),
                        leading: CircleAvatar(backgroundImage: FileImage(File(student.img!)),),
                      ),
                    ),
                  );
                },))
            ],
          ),
          
        )
        
        
        )

      
    );

  }

}