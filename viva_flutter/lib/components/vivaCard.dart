import 'package:flutter/material.dart';
import '/Services/globals.dart';

class VivaCard extends StatelessWidget {
  const VivaCard({this.projectName,this.student1,this.student2,this.student3,this.year,Key? key}) : super(key: key);

  final  projectName;
  final  student1;
  final  student2;
  final  student3;
  final  year;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 130,
      width: double.infinity,
      child: Card(
        color:secondaryColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    projectName,
                    style: TextStyle(fontSize: 19,color: primaryColor),
                  ),
                  Text(year)
                ],
              ),
              if(student3.length==0 &&student2.length!=0)...[Text('${student1} | ${student2}', style: TextStyle(fontSize: 16),)
              ]else if(student2.length==0)...[Text('${student1}', style: TextStyle(fontSize: 16),)]
              else...[Text('${student1} | ${student2} | ${student3}', style: TextStyle(fontSize: 16),)]
              // Text(
              //   '${student1} | ${student2} | ${student3}',
              //     style: TextStyle(fontSize: 15),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
