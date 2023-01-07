import 'package:flutter/material.dart';
import 'package:viva_app/components/myCalcInput.dart';
import 'package:viva_app/components/myInput.dart';
import '/Services/globals.dart';

class CalculScreen extends StatefulWidget {
  const CalculScreen({Key? key}) : super(key: key);

  @override
  State<CalculScreen> createState() => _CalculScreenState();
}

class _CalculScreenState extends State<CalculScreen> {

  var _field1 = TextEditingController();
  var _field2 = TextEditingController();
  var _field3 = TextEditingController();
  var _field4 = TextEditingController();
  var _field5 = TextEditingController();
  var _field6 = TextEditingController();
  var _field7 = TextEditingController();
  var _field8 = TextEditingController();
  var _field9 = TextEditingController();
  var _field10 = TextEditingController();
  var _field11 = TextEditingController();
  var _field12 = TextEditingController();

  void _showFinalMark(mark) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Text('Your Final Mark'),
                SizedBox(width: 17,),
                Text('$mark',style: myTextStyle(),)
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
                style: TextButton.styleFrom(
                    foregroundColor: primaryColor
                ),
              ),

            ],
          );
        });
  }


  var _formKey = GlobalKey<FormState>();


  calculateMark(){
      if(_field1.text.isNotEmpty &&
         _field2.text.isNotEmpty &&
         _field3.text.isNotEmpty &&
         _field4.text.isNotEmpty &&
         _field5.text.isNotEmpty &&
          _field6.text.isNotEmpty &&
          _field7.text.isNotEmpty &&
          _field8.text.isNotEmpty &&
          _field9.text.isNotEmpty &&
          _field10.text.isNotEmpty &&
          _field11.text.isNotEmpty &&
          _field12.text.isNotEmpty
      ){
        if(_formKey.currentState!.validate()){
          var finalMark;
          finalMark = double.parse(_field1.text)
              +double.parse(_field2.text)
              +double.parse(_field3.text)
              +double.parse(_field4.text)
              +double.parse(_field5.text)
              +double.parse(_field6.text)
              +double.parse(_field7.text)
              +double.parse(_field8.text)
              +double.parse(_field9.text)
              +double.parse(_field10.text)
              +double.parse(_field11.text)
              +double.parse(_field12.text);

          _showFinalMark(finalMark);
        }


      }else{
        errorSnackBar(context, 'please entre all required fields');
      }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('calculate mark'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          Padding(

            padding: const EdgeInsets.only(top:10,bottom:10,right: 12),
            child: ElevatedButton(
              onPressed: calculateMark,

              child: Text('calculate'),

              style: ElevatedButton.styleFrom(
                  minimumSize: Size(75,20),
                  elevation: 0,

                  backgroundColor: Color(0xFF6F35A5)
              ),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Text('Thesis (A1)',style:myTextStyle()),
               MyCalcInput(
                 label: 'Thesis organization',
                 suffix: 0.5,
                 controller: _field1,
               ),
                MyCalcInput(
                  label: 'Editorial quality',
                  suffix: 1,
                  controller: _field2,
                ),
                MyCalcInput(
                  label: 'Quality of bibliography',
                  suffix: 0.5,
                  controller: _field3,
                ),
                MyCalcInput(
                  label: 'Scientific content',
                  suffix: 1,
                  controller: _field4,
                ),
                SizedBox(height: 20,),
                Text('Source Code & Analyse (B1)',style:myTextStyle()),
                MyCalcInput(
                  label: 'Quality of analysis ',
                  suffix: 1,
                  controller: _field5,
                ),
                MyCalcInput(
                  label: 'Development effort',
                  suffix: 1,
                  controller: _field6,
                ),
                MyCalcInput(
                  label: 'Results quality',
                  suffix: 1,
                  controller: _field7,
                ),
                MyCalcInput(
                  label: 'Mastery of tools',
                  suffix: 1,
                  controller: _field8,
                ),
                SizedBox(height: 20,),
                Text('Presentation (C1)',style:myTextStyle()),
                MyCalcInput(
                  label: 'Presentation quality',
                  suffix: 1,
                  controller: _field9,
                ),
                MyCalcInput(
                  label: 'Oral expression ease',
                  suffix: 1,
                  controller: _field10,
                ),
                MyCalcInput(
                  label: 'Well posed problem',
                  suffix: 1,
                  controller: _field11,
                ),
                SizedBox(height: 20,),
                Text('Answers to Questions (D1)',style:myTextStyle()),
                MyCalcInput(
                  label: 'Relevence and quality of answers',
                  suffix: 2,
                  controller: _field12,
                ),
              ]
            )
          ),
        ),
      ),
    );
  }
}
