import 'package:flutter/material.dart';
import 'package:viva_app/components/myInput.dart';
import 'package:viva_app/homeScreen.dart';
import 'package:viva_app/signupScreen.dart';
import 'dart:convert';
import 'local_storage.dart';
import '/Services/auth_services.dart';
import '/Services/globals.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _emailCont = TextEditingController();
  var _passwordCont = TextEditingController();
 var _email;
 var _password;


  // login
  loginPressed() async {
    _email = _emailCont.text;
    _password = _passwordCont.text;
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password).timeout(const Duration(seconds: 5), onTimeout: () {

        print('test');
        errorSnackBar(context, "please check your network",);
        return http.Response('ERROR', 408);});
      String jsonsDataString = response.body.toString();
      print(response.body);
      Map responseMap = jsonDecode(jsonsDataString);
      if (response.statusCode == 200) {


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

          title: const Text('login'),
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
                //SizedBox(height: 20),
                Text(
                  'welcome back',
                  style: TextStyle(fontSize: 23.0),
                ),
                SizedBox(height: 30),
                MyInput(
                  controller: _emailCont,
                  label: 'email',
                  type: TextInputType.emailAddress,
                ),
                MyInput(
                  controller: _passwordCont,
                  label: 'password',
                  type: TextInputType.visiblePassword,
                ),
                SizedBox(height: 25),
                TextButton(
                  child: Text('login', style: TextStyle(fontSize: 17)),
                  style: TextButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width *0.8, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                  ),
                  onPressed: loginPressed
                ),
                SizedBox(height: 20),
                Divider(height: 1,thickness: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an acount?",style: TextStyle(fontSize: 15),),
                    TextButton(

                      child: Text('Sign Up'),
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 15,fontWeight:FontWeight.w500),
                        foregroundColor: primaryColor,
                      ),
                      onPressed: () {

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>
                              SignupScreen()));


                      },
                    )
                  ],
                ),

              ],
            ),
          ),
        ));
  }
}
