import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageUpload extends StatefulWidget {
  String? userId;

  ImageUpload({ Key? key, required this.userId }) : super(key: key); //retirar o const dessa linha

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadUrl;
  

    Future imagePickerMethod() async{

    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pick != null){
        _image = File(pick.path);
      }else{
        //Mostrar snackbar com erro
        showSnackBar("No file selected", Duration(milliseconds: 400));
      }
    });

  }

  Future uploadImage() async{
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child("${widget.userId}/images").child("post_$postId");
    await ref.putFile(_image!);
    downloadUrl = await ref.getDownloadURL();
    print(downloadUrl);
  }

  showSnackBar(String snackText, Duration d){
    final snackBar = SnackBar(content: Text(snackText), duration: d,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image picker"),
      centerTitle: true,),
      body: Center(
        child: Padding(padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 500,
            width: double.infinity,
            child: Column(
              children: [
                Text("Upload Image"),
                SizedBox(height: 10,),
                Expanded(
                  flex: 4,
                  child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _image == null
                          ? const Center(
                            child: Center(child: Text("no image selected"),),)
                            : Image.file(_image!)),
                  ElevatedButton(onPressed: (){
                    imagePickerMethod();
                  }, child: Text("Select image")),
                  ElevatedButton(onPressed: (){
                    if(_image != null){
                      uploadImage().whenComplete(() => 
                    showSnackBar("Upload de imagem feito com sucesso", Duration(seconds: 2)));
                    }else{
                      showSnackBar("Select Image First", Duration(milliseconds: 500));
                    }
                  }, child: Text("Upload image"))
                      ],
                    ),
                  ),
                  
                ))
              ],
            ),
          ),
        ),),
      ),
    );
  }
}