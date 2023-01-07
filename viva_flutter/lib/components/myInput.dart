import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Services/globals.dart';

class MyInput extends StatefulWidget {

  final String? label;
  final TextInputType? type;
  final TextEditingController? controller;
  final Function(String)? onChange;

  const MyInput({this.label, this.type, this.controller,this.onChange});
  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  bool _hidden = true;
  void _toggle ()=> setState(() {
    _hidden = !_hidden;
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.type,
          onChanged: widget.onChange,
          obscureText: widget.type == TextInputType.visiblePassword? _hidden:false,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: primaryColor,fontSize: 17),
            suffixIcon: widget.type == TextInputType.visiblePassword
                ? IconButton(
                    iconSize: 22,
                    splashRadius: 0.1,
                    onPressed: _toggle,
                    icon:
                        Icon(_hidden ? Icons.visibility_off_outlined : Icons.visibility,color: _hidden ? Colors.grey[600] : primaryColor,),
                  )
                : SizedBox(),
         //   contentPadding: EdgeInsets.only(top:20),


            labelText: widget.label,
            border: InputBorder.none,
            fillColor: secondaryColor,
            filled: true,
          ),
        ),
      ),
    );
  }
}
