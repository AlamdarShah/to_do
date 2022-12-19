import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_application/repository/DBHelper.dart';
import 'displayItems.dart';
import 'model/model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

String itemName = "";
String description = "";
int id = 0;

TextEditingController _item = TextEditingController();
TextEditingController _description = TextEditingController();

class _HomePageState extends State<HomePage> {
  _showDialoge(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: Text("Add Item"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    //keyboardType: TextInputType.number,
                    controller: _item,
                    onChanged: (value) {
                      setState(() {
                        itemName = _item.text;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "item name", labelText: "item name"),
                  ),
                  TextField(
                    controller: _description,
                    onChanged: (value) {
                      setState(() {
                        description = _description.text;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Description", labelText: "Description"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        child: Text("Cancel"),
                        color: Colors.red,
                      ),
                      MaterialButton(
                        onPressed: (() async {
                          await DBhelper.insert(
                            MyItem(
                              id: id,
                              name: itemName,
                              description: description,
                            ),
                          );

                          Navigator.pop(context);
                          _item.clear();
                          _description.clear();
                        }),
                        child: Text("Add"),
                        color: Colors.green,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-do"),
        centerTitle: true,
      ),
      body: Center(
        child:
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
  GestureDetector(
  
                          onTap: () {
  
                            // Navigator.push(context,
  
                            //     MaterialPageRoute(builder: (context) => MyHomePage()));
  
                             _showDialoge(context);
  
                          },
  
                          child: Container(
  
                            alignment: Alignment.center,
  
                            height: 50,
  
                            width: double.infinity,
  
                            decoration: BoxDecoration(
  
                                //border: Border.all(width: 2,color: Colors.white),
  
                                color: Colors.blue[700],
  
                                borderRadius: BorderRadius.circular(30)),
  
                            child: const Text(
  
                              "Add Item",
  
                              textAlign: TextAlign.center,
  
                              style: TextStyle(
  
                                color: Colors.white,
  
                                fontSize: 28,
  
                              ),
  
                            ),
  
                          ),
  
                        ),
 
                    SizedBox(
                      height: 15,
                    ),
                      GestureDetector(
                          onTap: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => MyHomePage()));
                             //_showDialoge(context);
                             Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DisplayItem()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                //border: Border.all(width: 2,color: Colors.white),
                                color: Colors.green[900],
                                borderRadius: BorderRadius.circular(30)),
                            child: const Text(
                              "To-do items",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                      
            ],
          ),
        ),
        
        
      //    MaterialButton(
      //     onPressed: (() async {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => DisplayItem()));
      //     }),
      //     child: Text("Get To-do Item"),
      //     color: Colors.green,
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() {
      //     _showDialoge(context);
      //   }),
      //   child: Icon(Icons.add_outlined),
      // ),
    ),
    );
  }
}
