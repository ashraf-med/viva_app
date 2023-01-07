import 'package:flutter/material.dart';
import 'package:viva_app/components/myInput.dart';
import 'package:viva_app/homeScreen.dart';
import 'dart:convert';
import 'local_storage.dart';
import '/Services/auth_services.dart';
import '/Services/globals.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _nameCont = TextEditingController();
  var _emailCont = TextEditingController();
  var _passwordCont = TextEditingController();
  var _passConfCont = TextEditingController();

  var _name;
  var _email;
  var _password;
  var _passConf;
  // register //
    signUp() async {
      _name = _nameCont.text;
      _email = _emailCont.text;
      _password = _passwordCont.text;
      _passConf = _passConfCont.text;
      if (_name.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty && _passConf.isNotEmpty) {
        http.Response response = await AuthServices.register(_name,_email, _password,_passConf).timeout(const Duration(seconds: 5), onTimeout: () {
        errorSnackBar(
          context,
          "please check your network",
        );
        return http.Response('ERROR', 408);});

        String jsonsDataString = response.body.toString();
        print(response.body);
        Map responseMap = jsonDecode(jsonsDataString);
        if(response.statusCode == 200){
          await tokenStorage.setToken(responseMap['token']);

          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen(),
              ));
        } else  {

          errorSnackBar(context,responseMap.values.first);


        }

      } else {
        errorSnackBar(context, 'enter all required fields');
      }

    }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('sign up'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Create your account',  style: TextStyle(fontSize: 23.0),),
                SizedBox(height: 25),
                MyInput(
                  label: 'name',
                  type: TextInputType.name,
                  controller: _nameCont,
                ),
                MyInput(
                  label: 'email',
                  type: TextInputType.emailAddress,
                  controller: _emailCont,
                ),
                MyInput(
                  label: 'password',
                  type: TextInputType.visiblePassword,
                  controller: _passwordCont,
                ),
                MyInput(
                  label: 'confirm password',
                  type: TextInputType.visiblePassword,
                  controller: _passConfCont,
                ),
                SizedBox(height: 25),
                TextButton(
                  child: Text('sign up', style: TextStyle(fontSize: 17)),
                  style: TextButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                  ),
                  onPressed: signUp,
                ),

              ],
            ),
          ),
        ));
  }
}
