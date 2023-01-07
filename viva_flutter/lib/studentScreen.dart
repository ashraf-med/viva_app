import 'package:flutter/material.dart';
import 'package:viva_app/Services/globals.dart';
import 'dart:convert';
import '/Services/globals.dart';
import '/Services/auth_services.dart';
import 'package:http/http.dart' as http;

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  var _vivaCodeCont = TextEditingController();


  // get viva by code //
  showViva() async {
    if (_vivaCodeCont.text.isNotEmpty) {
      http.Response response = await Viva.getViva(_vivaCodeCont.text).timeout(const Duration(seconds: 5), onTimeout: () {

        print('test');
        errorSnackBar(context, "please check your network",);
        return http.Response('ERROR', 408);});
      String jsonsDataString = response.body.toString();
      Map responseMap = jsonDecode(jsonsDataString);

      if (response.statusCode == 200) {

        showVivaSheet(context,responseMap);
      } else  {

        errorSnackBar(context,responseMap.values.first);


      }

    } else {
      errorSnackBar(context, 'enter viva code');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        foregroundColor: Colors.black,
        backgroundColor:Colors.white,

        title: Text('student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Checkout Your Final Project', style: TextStyle(fontSize: 21.0,fontWeight: FontWeight.w500),),
            SizedBox(height: 30,),
            Text('Please Enter Your Viva Code provided by your university',style: TextStyle(fontSize: 16.0),),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                labelText: 'code',
                floatingLabelStyle: TextStyle(color: primaryColor,fontSize: 17),
              ),
              controller: _vivaCodeCont,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed:showViva,
                //(){

                      // showVivaSheet(context,'responseMap');

                    // },

                  child: Text('Check'),
                  style: TextButton.styleFrom(
                    elevation: 0,
                    fixedSize: Size(80,45),
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,

                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}