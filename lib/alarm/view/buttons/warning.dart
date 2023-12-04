import 'package:flutter/material.dart';

class DeleteWarningDialog {
  DeleteWarningDialog(VoidCallback onTap, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return AlertDialog(
          backgroundColor: Color(0xff292929),
          title: Text('복약 일정 삭제',
            style: TextStyle(color: Colors.white, fontSize: width * 0.08),),
          content: Text('정말 복약 일정을 삭제하겠습니까?',
            style: TextStyle(color: Colors.white, fontSize: width * 0.048),),
          actions: [
            TextButton(
              child: Text(
                '취소',
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                '삭제',
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
              ),
              onPressed: () {
                onTap();
              },
            ),
          ],
        );
      },
    );
  }
}
