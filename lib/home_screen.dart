import 'dart:convert';

import 'package:chapter_10/Models/PostsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList=[];
  Future<List<PostsModel>> getPostApi()async{

    final response= await http.get(Uri.parse( 'https://jsonplaceholder.typicode.com/posts'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data)
        {
          postList.add(PostsModel.fromJson(i));
        }
      return postList;
    }
    else{
      return postList;
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
              future: getPostApi(),
                builder: (context,snapshot)
                {
                  if(!snapshot.hasData){
                    return Text('Loading');

                  }
                  else{
                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context,index)
                    {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xffD01D24)),),
                              Text(postList[index].title.toString(),style: TextStyle(fontSize: 17),),
                              Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xffD01D24)),),
                              Text(postList[index].body.toString(),style: TextStyle(fontSize: 17),),
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
