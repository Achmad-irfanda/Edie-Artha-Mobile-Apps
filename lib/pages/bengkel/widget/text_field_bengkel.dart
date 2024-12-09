import 'package:flutter/material.dart';

class TextFieldBengkel extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const TextFieldBengkel({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        maxLines: 1,
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
