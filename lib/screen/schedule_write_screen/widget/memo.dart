import 'package:flutter/material.dart';

// 메모장

class Memo extends StatelessWidget {
  final ValueChanged onChanged;
  final String memo;

  const Memo(
      {required this.onChanged, required this.memo, super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle defaultTextStyle = TextStyle(
      color: Colors.white,
      fontSize: width * 0.03,
      fontWeight: FontWeight.w500,
    );
    return SizedBox(
      width: width * 0.9,
      child: TextField(
        showCursor: false,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: width * 0.02,top: height * 0.005,bottom: height * 0.1),
          prefixText: memo,
          prefixStyle: defaultTextStyle,
          filled: true,
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(width * 0.02),
            ),
            borderSide: BorderSide(
              width: width * 0.0025,
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(width * 0.02),
            ),
            borderSide: BorderSide(
              width: width * 0.0025,
              color: Colors.white,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
