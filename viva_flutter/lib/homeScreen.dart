import 'dart:convert';
import 'package:viva_app/calculScreen.dart';
import 'package:viva_app/evaluationScreen.dart';

import 'local_storage.dart';
import '/Services/auth_services.dart';
import '/Services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'components/vivaCard.dart';
import 'package:viva_app/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // logout //
  logOut() async {
    http.Response response = await AuthServices.logout()
        .timeout(const Duration(seconds: 5), onTimeout: () {
      print('test');
      errorSnackBar(
        context,
        "please check your network",
      );
      return http.Response('ERROR', 408);
    });
    Map responseMap = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print('logout');
      tokenStorage.delteToken();
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      errorSnackBar(context, responseMap.values.first);
    }
  }
  //
  //get user vivas //

  userViva() async{
    http.Response response = await Viva.getUserVivas();
        if(response.statusCode == 200){
          String jsonRespondString = response.body.toString();
         // print(jsonDecode(response.body));
         // errorSnackBar(context,jsonDecode(response.body)[2]["pname"] );
          return jsonDecode(jsonRespondString);
        }else{
          throw Exception('Failed to load vivas');
        }
  }
  //
  late Future myVivas;
  @override
  void initState() {
    myVivas = userViva();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('teacher'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(

                  value: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => CalculScreen()));
                  },
                  // padding: EdgeInsets.only(left: 20),
                  child: Text('calculate mark')),
              PopupMenuDivider(),
              PopupMenuItem(
                  onTap: logOut,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('log out'),
                    ],
                  ))
            ],
            onSelected: (value){
              value();
            },

          )
        ],
      ),
      body:

      FutureBuilder(
        future: myVivas,
        builder:  (context, snapshot){

          if(!snapshot.hasData)
          {return Center(child: CircularProgressIndicator(
            color: primaryColor,
          ));}
          else if(snapshot.hasData && snapshot.data.isEmpty)
          {return Center(child: Text('No Vivas',style: TextStyle(color: primaryColor,fontSize: 18),));}
          else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          else{
            return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context , index){

                        return  VivaCard(
                                  projectName: snapshot.data[index]['pname'],
                                  year: snapshot.data[index]['year'],
                                  student1: snapshot.data[index]['s1name'],
                                  student2:snapshot.data[index]['s2name']!=null? snapshot.data[index]['s2name']:'',
                                  student3:snapshot.data[index]['s3name']!=null? snapshot.data[index]['s3name']:'',
                                );
                      }
                  )
                    ;
                }
          //works
          }
        ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EvaluationScreen()));
        },
        child: Icon(Icons.add, size: 28),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
      ),
    );
  }
}
