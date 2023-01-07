import 'package:flutter/material.dart';
import '/Services/globals.dart';


class MyCalcInput extends StatelessWidget {
  const MyCalcInput({this.label,this.suffix, this.controller});

  final String? label;
  final double? suffix;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width:150,child: Text('${label}',style: TextStyle(fontSize: 15),)),
          SizedBox(
            width: 120,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  decoration: InputDecoration(

                    floatingLabelStyle: TextStyle(color: primaryColor, fontSize: 17),
                    border: InputBorder.none,
                    fillColor: secondaryColor,
                    filled: true,
                    suffixText: '/$suffix',
                  ),
                  validator: (value){
                   if(double.parse('$value') > num.parse('$suffix')){
                     return 'max mark is $suffix';
                   }else {return null;}
                   },
                )),
          ),
        ],
      ),
    );
  }
}
