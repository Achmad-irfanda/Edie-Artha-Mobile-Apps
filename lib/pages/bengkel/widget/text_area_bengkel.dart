import 'package:flutter/material.dart';

class TextAreaBengkel extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const TextAreaBengkel(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: 2,
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
