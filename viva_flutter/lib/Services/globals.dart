import 'package:flutter/material.dart';


const String baseURL = "http://10.0.2.2:8000/api"; //emulator localhost
const Map<String, String> header1 = {"Content-Type": "application/json",
'Accept': 'application/json'};


errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(seconds: 4),
  ));
}

goTo(Context,Widget f){
  Navigator.push(
      Context, MaterialPageRoute(builder: (context) => f));
}

//colors

var primaryColor = Color(0xFF6F35A5);
var secondaryColor = Color(0xFFF1E6FF);


myTextStyle(){
  return TextStyle(color: primaryColor,fontSize: 22,);
}

//sheet row
sheetRow(name,value){
  return
    Padding(
      padding: const EdgeInsets.only(left: 21,bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         // SizedBox(width: 21,),
          Text('${name}', style:TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text('${value}',style: TextStyle(fontSize: 18,color: primaryColor),),
        ],),
    );
}

// viva sheet info //

showVivaSheet(context,data){
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          )),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0,right: 20,left: 20,bottom: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    height: 5,
                    width: 50,
                    margin: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Color(0xFFB2B2B2),
                        borderRadius: BorderRadius.all(
                            Radius.circular(70)))),
              ),
              SizedBox(height: 20,),
              Text(' Project',style: myTextStyle(),),
              SizedBox(height: 10,),
             sheetRow('Project name', data['pname']),
              sheetRow('year', data['year']),
              Divider(color: Color(0xFFD8B8EF),height: 30,thickness: 1,),
              Text(' Students',style: myTextStyle(),),
              SizedBox(height: 10,),
              sheetRow(data['s1name'],'' ),
              data['s2name']!=null?sheetRow(data['s2name'],'' ):SizedBox(),
              data['s3name']!=null?sheetRow(data['s3name'],'' ):SizedBox(),
              Divider(color: Color(0xFFD8B8EF),height: 30,thickness: 0.8,),
              Text(' Teachers',style: myTextStyle(),),
              SizedBox(height: 10,),
              sheetRow('Supervisor', data['sname']),
              sheetRow('President', data['prname']),
              sheetRow('Examinator', data['ename']),
              Divider(color: Color(0xFFD8B8EF),height: 30,thickness: 0.8,),
              Text(' Marks',style: myTextStyle(),),
              SizedBox(height: 10,),
              sheetRow('Supervisor mark', data['smark']),
              sheetRow('President mark', data['prmark']),
              sheetRow('Examinator mark', data['emark']),
              Divider(color: Color(0xFFD8B8EF),height: 30,thickness: 0.8,),
              Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  Text('Viva mark',style: myTextStyle(),),
                  Text('${(data["smark"]*0.4+data["prmark"]*0.3+data["emark"]*0.3).toStringAsFixed(2)}',style: TextStyle(color: primaryColor,fontSize: 21,),)
                ],),
              )
            ],
          ),
        ),
      ));
}


