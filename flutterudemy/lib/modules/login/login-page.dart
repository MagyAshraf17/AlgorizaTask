import 'package:flutter/material.dart';

import '../../shared/components/button.dart';



class LoginPage extends StatelessWidget{

  var emailConteroler =TextEditingController();
  var passwordControler =TextEditingController();
  var formKey= GlobalKey<FormState>();
  LoginPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title:Text(
            'LogIn'
        ),
      ),
      body :Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children :[
                  Text(
                    'Login',
                    style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    controller: emailConteroler,
                    onFieldSubmitted: (String value) { },

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email ';
                        }
                        return null;
                      },


                    keyboardType: TextInputType.emailAddress,
                    decoration:  InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(
                      Icons.email,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller:passwordControler ,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    validator: ( value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password ';
                      }
                      return null;
                    },
                      decoration: InputDecoration(
                       hintText: 'Password',
                      prefixIcon: Icon(
                      Icons.lock,
                      ),
                  suffixIcon: Icon(
                   Icons.remove_red_eye,
                 ),
                  border: OutlineInputBorder(),
                ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defultButton(
                    text: 'login',
                    onPressFun : (){
                  if (formKey.currentState!.validate()) {
                    print(emailConteroler.text);
                    print (passwordControler.text);

                  }
                  },

                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }


}