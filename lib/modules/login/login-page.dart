import 'package:flutter/material.dart';
import '../../shared/components/text_field.dart';
import '../../shared/components/log_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailConteroler = TextEditingController();

  var passwordControler = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  FiledText(
                    controller: TextEditingController(),
                    textValidate: 'please enter your email',
                    inputType: TextInputType.emailAddress,
                    textLabel: 'Email Address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  FiledText(
                    isPassword: true,
                    controller: passwordControler,
                    inputType: TextInputType.visiblePassword,
                    textLabel: 'Password',
                    prefix: Icons.lock,
                    textValidate: 'Password is too short ',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  NewButton(
                    text: 'login',
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        print(emailConteroler.text);
                        print(passwordControler.text);
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
