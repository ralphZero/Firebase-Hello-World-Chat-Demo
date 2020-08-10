import 'package:flutter/material.dart';

class MessageSearch extends StatelessWidget {
  const MessageSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.grey[400]),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.grey[400],
        ),
        fillColor: Colors.grey[400],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[400],
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
