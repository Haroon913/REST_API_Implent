import 'dart:convert';
import 'package:chapter_10/userdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getuserapi()async{
    final response=await  http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode==200){
      data=jsonDecode(response.body.toString());
    }
    else{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('API Integration',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color(0xffD01D24),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getuserapi(),
                builder: (context,snapshot)
                {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Text('Loading');

                  }
                  else{
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context,index)
                        {
                          return  Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReuseableRow(title: 'Name', value: data[index]['name'].toString()),
                                  ReuseableRow(title: 'Email', value: data[index]['email'].toString()),
                                  ReuseableRow(title: 'Address', value: data[index]['address']['street'].toString()),
                                  ReuseableRow(title: 'Lng', value: data[index]['address']['geo']['lng'].toString()),


                                ],
                              ),
                            ),
                          );
                        });
                  }

                }),
          )
        ],
      ),
    );
  }
}

