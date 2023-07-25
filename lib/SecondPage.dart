import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/Data_Stored.dart';

import 'main.dart';

class SecondPage extends StatefulWidget {
   SecondPage();

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Box mybox =Hive.box("HiveData");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 10,
                offset: Offset(6, 6),
              )
            ],
          ),
          child: Column(
            children: [
              Card(elevation: 15,
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Home();},));
                    }, icon: Icon(Icons.arrow_circle_left_rounded)),

                    SizedBox(width: 60),

                    Text("View Data",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: mybox.length,
                  itemBuilder: (context, index) {
                    var  _data =mybox.getAt(index) as Student;
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text("${_data.name}",style: TextStyle(fontSize: 19),),
                    subtitle: Text("${_data.contact} | ${_data.email}",style: TextStyle(fontSize: 12)),
                    trailing: Wrap(
                      children: [
                        IconButton(onPressed: () {
                          mybox.deleteAt(index);
                          setState(() {});
                        }, icon: Icon(Icons.delete)),
                        IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Home(_data);
                          },));
                        }, icon: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                );
              },))            
            ],
          ),
        ),
      ),
    );
  }
}