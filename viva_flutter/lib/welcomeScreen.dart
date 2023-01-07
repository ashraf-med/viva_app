import 'package:flutter/material.dart';
import 'package:viva_app/homeScreen.dart';
import 'package:viva_app/loginScreen.dart';
import 'package:viva_app/studentScreen.dart';
import 'Services/globals.dart';
import 'local_storage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(

        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Viva App',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30),
                Container(
                  width: s.width * 0.9,
                  child: Image(
                    image: AssetImage('assets/viva2.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 10),
                  child: Text('Continue as', style: TextStyle(fontSize:15)),
                ),
                TextButton(
              onPressed: () {
                tokenStorage.getToken().then((value) => {
                      value != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomeScreen(),
                              ))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen(),
                              ))
                    });
              },
              child: Text('teacher', style: TextStyle(fontSize: 20)),
                  style: TextButton.styleFrom(
                      fixedSize: Size(s.width * 0.75, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29)),
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white),
                ),
                SizedBox(height: 13,),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => StudentScreen()));
                  },
                  child: Text('student', style: TextStyle(fontSize: 20)),
                  style: TextButton.styleFrom(
                    // side: BorderSide(
                    //   color: Color(0xFF6F35A5)
                    // ),
                    fixedSize: Size(s.width * 0.75, 50),
                    foregroundColor: Colors.black,
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
