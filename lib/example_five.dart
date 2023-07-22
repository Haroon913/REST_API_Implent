import 'dart:convert';

import 'package:chapter_10/Models/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ExampleFive extends StatefulWidget {
  const ExampleFive({Key? key}) : super(key: key);

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  Future<ProductsModel> getProductApi()async{
    final response=await http.get(Uri.parse('https://webhook.site/c9c16422-c9d3-4e25-9e5f-3117f82c40c3'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){

      return ProductsModel.fromJson(data);
    }
    else{

      return ProductsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,

      appBar: AppBar(
        title: RichText(text: TextSpan(text: 'SHIRTS',style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.orange),
            children: [TextSpan(text: '  STORE',style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white))]),),
        centerTitle: true,
        backgroundColor: Colors.black26,
        leading: Icon(Icons.menu,color: Colors.orange,size: 30,),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductsModel>(
                  future: getProductApi(),
                  builder: (context,snapshot)
                  {
                    if(!snapshot.hasData){
                      return Text('Loading');

                    }
                    else{
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context,index)
                          {
                            return  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(snapshot.data!.data![index].shop!.name.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                                  subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.orange),),
                                  leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),),
                                ),
                                Container(
                                  height:MediaQuery.of(context).size.height*.3,
                                  width:MediaQuery.of(context).size.width*1,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:snapshot.data!.data![index].images!.length,
                                      itemBuilder: (context,position){
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:MediaQuery.of(context).size.height*.25,
                                        width:MediaQuery.of(context).size.width*.5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),

                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                              image: NetworkImage(snapshot.data!.data![index].images![position].url.toString()))
                                        ),

                                      ),
                                    );

                                  }),
                                ),
                                Icon(snapshot.data!.data![index].inWishlist! == true? Icons.favorite:Icons.favorite_outline,color: Colors.orange,)
                              ],
                            );
                          });
                    }

                  }),
            )
          ],
        ),
      ),
    );
  }
}
