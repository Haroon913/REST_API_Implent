import 'dart:convert';

import 'package:chapter_10/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  List<UserModel> userlist=[];
  Future<List<UserModel>> getuserapi()async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200)
      {

        for(Map i in data){
          userlist.add(UserModel.fromJson(i));
        }
        return userlist;
      }
    else{
      return userlist;
    }
  }
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
                builder: (context,AsyncSnapshot<List<UserModel>> snapshot)
                {
                  if(!snapshot.hasData){
                    return Text('Loading');

                  }
                  else{
                    return ListView.builder(
                        itemCount: userlist.length,
                        itemBuilder: (context,index)
                        {
                          return  Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReuseableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                                  ReuseableRow(title: 'Username', value: snapshot.data![index].username.toString()),
                                  ReuseableRow(title: 'Email', value: snapshot.data![index].email.toString()),
                                  ReuseableRow(title: 'Address', value: snapshot.data![index].address!.geo!.lng .toString()),
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
class ReuseableRow extends StatelessWidget {
  String title,value;
 ReuseableRow({Key? key, required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color(0xffD01D24)),),
          Text(value,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}

