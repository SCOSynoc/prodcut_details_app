import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class CommonTextField extends StatefulWidget {

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final VoidCallback action;

  CommonTextField({super.key,
    required this.controller,
    required this.action,required this.labelText,
    required this.icon,required this.isPassword});


  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        obscureText: widget.isPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ${widget.labelText}';
          }
          return null;
        },
      ),
    );

  }
}

