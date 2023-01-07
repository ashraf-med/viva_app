import 'package:flutter/material.dart';
import 'package:viva_app/homeScreen.dart';

class Second extends StatelessWidget {
  const Second({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Colors.white,
        // backgroundColor: Color(0xFF6E35A5),
        elevation: 0.2,
        foregroundColor: Colors.black,
        backgroundColor:Colors.white,

        title: Text('second screen'),
      ),
      body: Center(
          child: TextButton(

            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Text('go to third page'),
          ),),
    );
  }
}