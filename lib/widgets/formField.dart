import 'package:flutter/material.dart';

Container formField({
  TextEditingController controller,
  String text,
  String validationText,
  Icon icon,
  String value = '',
  bool isPassword = false,
}) {
  controller.text = value;
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
      controller: controller,
      obscureText: isPassword ? true : false,
      style: TextStyle(
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        hintText: text,
        icon: icon,
        border: InputBorder.none,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {},
              )
            : Icon(null),
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
