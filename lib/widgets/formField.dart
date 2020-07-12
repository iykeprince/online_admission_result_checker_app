import 'package:flutter/material.dart';

Container formField({
  TextEditingController controller,
  String text,
  String validationText,
  Icon icon,
  String value,
}) {
  
  return Container(
    margin: EdgeInsets.only(
      top: 10,
    ),
    padding: EdgeInsets.only(
      left: 16,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: Colors.grey,
        width: 1,
      ),
    ),
    child: TextFormField(
      initialValue:  value != '' ? value : '',
      controller: controller,
      style: TextStyle(
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        hintText: text,
        icon: icon,
        border: InputBorder.none,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return validationText;
        }
        return null;
      },
    ),
  );
}
