  import 'package:flutter/material.dart';

Widget defultButton ({
    required String text  ,
    bool isUpperCase = true,
    double width =double.infinity,
    Color background=Colors.blue,
     required Function onPressFun ,
  })=>Container(


  width: width,
   decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  color: background,
  ),
  child: MaterialButton(
    onPressed:({
      onPressFun,
    }){
    },
    child:Text(
      isUpperCase ?  text.toUpperCase() : text,
      style:TextStyle(
        color: Colors.white,
      ),
    ),



  ),
);


Widget defultFormField ({
    required TextEditingController controller ,
    required Function validate ,




  })=>TextFormField(
  controller:controller ,
  // there is error in validation function
  keyboardType: TextInputType.emailAddress,
  decoration:  InputDecoration(
  labelText: 'Email Address',
  prefixIcon: Icon(
  Icons.email,
  ),
  border: OutlineInputBorder(),
  ),
  );
