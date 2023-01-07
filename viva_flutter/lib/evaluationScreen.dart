import 'package:flutter/material.dart';
import 'package:viva_app/components/myInput.dart';
import 'package:viva_app/homeScreen.dart';
import 'dart:convert';
import 'local_storage.dart';
import '/Services/auth_services.dart';
import '/Services/globals.dart';
import 'package:http/http.dart' as http;


class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({Key? key}) : super(key: key);

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
   @override

  var _projectName = TextEditingController();
  var _year = TextEditingController();
  var _supName = TextEditingController();
  var _preName = TextEditingController();
  var _exaName = TextEditingController();
  var _s1Name = TextEditingController();
  var _s2Name = TextEditingController();
  var _s3Name = TextEditingController();
  var _supMark = TextEditingController();
  var _preMark = TextEditingController();
  var _exaMark = TextEditingController();
  var sm,pm,em;

// add new viva //
  createNewViva() async {
    Map data={};
    if(_projectName.text.isNotEmpty && _year.text.isNotEmpty &&_supName.text.isNotEmpty &&_preName.text.isNotEmpty &&_exaName.text.isNotEmpty &&_s1Name.text.isNotEmpty &&_supMark.text.isNotEmpty && _preMark.text.isNotEmpty && _exaMark.text.isNotEmpty ){
      print('this is me ');
      if(_s2Name.text.isEmpty && _s3Name.text.isNotEmpty) {
        errorSnackBar(context, 'specifie 2nd student');
        return ;}
      data={"pname":_projectName.text,"year":_year.text,"prname":_preName.text,
        "prmark":_preMark.text,"sname":_supName.text,"smark":_supMark.text,
        "ename":_exaName.text,"emark":_exaMark.text,"s1name":_s1Name.text};
      if(_s2Name.text.isNotEmpty){
        data['s2name']=_s2Name.text;
      }
      if(_s3Name.text.isNotEmpty){
        data['s3name']=_s3Name.text;
      }

      http.Response response = await Viva.create(data).timeout(const Duration(seconds: 5), onTimeout: () {

        print('test');
        errorSnackBar(context, "please check your network",);
        return http.Response('ERROR', 408);});
      Map responseMap = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        print(responseMap.values.first);
        _showMaterialDialog(responseMap['vivacode']);
        // errorSnackBar(context,'viva created with code${responseMap.values.first}');

      } else  {

        errorSnackBar(context,responseMap.values.first);

      }
    }else{
      errorSnackBar(context, 'please entre all required fields');
    }
  }
//

//success modal

  void _showMaterialDialog(code) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Viva Added'),
            content: Text('viva code : $code',style: TextStyle(fontSize: 18),),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  goTo(context, HomeScreen());
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Evaluation'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          Padding(

            padding: const EdgeInsets.only(top:10,bottom:10,right: 12),
            child: ElevatedButton(
              onPressed:createNewViva,
              child: Text('Add'),

              style: ElevatedButton.styleFrom(
                minimumSize: Size(75,20),
                elevation: 0,

              backgroundColor: Color(0xFF6F35A5)
            ),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('project',style: myTextStyle(),),
              MyInput(
                label: 'project name',
                type: TextInputType.text,
                controller: _projectName,
              ),
              MyInput(
                label: 'year',
                type: TextInputType.text,
                controller: _year,
              ),
              SizedBox(height: 30,),
              Text('Teachers',style: myTextStyle(),),
              MyInput(
                label: 'Supervisor',
                type: TextInputType.text,
                controller: _supName,
              ),
              MyInput(
                label: 'President',
                type: TextInputType.text,
                controller: _preName,
              ),
              MyInput(
                label: 'Examinator',
                type: TextInputType.text,
                controller: _exaName,
              ),
              SizedBox(height: 30,),
              Text('Students',style: myTextStyle(),),
              MyInput(
                label: 'first student',
                type: TextInputType.text,
                controller: _s1Name,
              ),
              MyInput(
                label: 'second student',
                type: TextInputType.text,
                controller: _s2Name,
              ),
              MyInput(
                label: 'third student',
                type: TextInputType.text,
                controller: _s3Name,
              ),
              SizedBox(height: 30,),
              Text('Marks',style: myTextStyle(),),
              MyInput(
                label: 'Supervisor Mark',
                type: TextInputType.number,
                controller: _supMark,
                onChange: (text){

                  setState(() {
                    if(_supMark.text.isNotEmpty){
                      sm = double.parse(_supMark.text);
                    }


                  });
                },
              ),
              MyInput(
                label: 'President Mark',
                type: TextInputType.number,
                controller: _preMark,
                onChange: (text){
                  setState(() {
             if(_preMark.text.isNotEmpty){
               pm = double.parse(_preMark.text);
             }
                  });
                },
              ),
              MyInput(
                label: 'Examinator Mark',
                type: TextInputType.number,
                controller: _exaMark,
                onChange: (text){
                  setState(() {
                    if(_exaMark.text.isNotEmpty){
                      em = double.parse(_exaMark.text);
                    }

                  });
                },
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text('viva mark',style: myTextStyle(),),
                _preMark.text.isEmpty ||  _exaMark.text.isEmpty || _supMark.text.isEmpty? Text('',style: TextStyle(fontSize: 20),):Text('${(sm*0.3+em*0.4+pm*0.4).toStringAsFixed(2)}',style: TextStyle(fontSize: 20)),
                //  SizedBox(width: 2,)
                ],

              ),
              // ElevatedButton(
              //   onPressed: mySheet,
              //   child: Text('continue'),
              //   style: ElevatedButton.styleFrom(elevation: 0,),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
