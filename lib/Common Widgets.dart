import 'package:flutter/material.dart';

class Common{
  static Widget CmnTxtFld(TextEditingController cntrl,String label,bool active,double ht,double wd){
    return SizedBox(
      height: ht,
      width: wd,
      child: TextField(
        controller: cntrl,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          enabled: active,
        ),
      ),
    );
  }
}