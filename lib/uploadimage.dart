
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  File? image;
  final _picker=ImagePicker();
  bool showSpinner=false;
  Future getImage()async{
    final pickedFile= await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickedFile!= null){
      image = File(pickedFile.path);
      setState(() {

      });
    }
    else{
      print('no image selected');
    }
  }
  Future<void> uploadImage()async{
    setState(() {
      showSpinner:true;
    });
    var stream=new http.ByteStream(image!.openRead());
    stream.cast();
    var length=await image!.length();
    var uri= Uri.parse('https://fakestoreapi.com/products');
    var request=new http.MultipartRequest('post', uri);
    request.fields['title']="Static title";
    var multiport=new http.MultipartFile(
        'image',
        stream,
        length);
    request.files.add(multiport);
    var response =await request.send();
    if(response.statusCode==200){
      print('image uploaded');
      setState(() {
        showSpinner:false;
      });
    }
    else{
      print('failed');
      setState(() {
        showSpinner:false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.teal,

        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Text('Upload Image',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
            SizedBox(height: 100,),
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                height: 250,
                width: 330,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(255, 255, 255, 0.5), // White color with 70% opacity
                ),
                child: image == null? Center(child: Text('Pick Image',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),)
                    :
                    Container(
                      child:Center(
                        child: Image.file(
                          File(image!.path).absolute,
                        ),
                      ),
                    )

              ),
            ),
            SizedBox(height: 100,),
            InkWell(
              onTap:
              (){

              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                child: Center(child: Text('Upload',
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.teal),),),
              ),
            )
          ],
        ),

      ),
    );
  }
}
