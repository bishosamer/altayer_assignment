import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.searchTextController,
  });

  final TextEditingController searchTextController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: searchTextController,
        decoration: InputDecoration(
          hintText: 'Enter text',
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // Remove default border
          ),
        ));
  }
}
