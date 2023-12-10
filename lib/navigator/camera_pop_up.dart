// 카메라 촬영/ 직접 작성 버튼 팝업
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../screen/schedule_write_screen/schedule_write.dart';
import '../screen/schedule_write_screen/widget_model/bloc/dosage_cubit.dart';

class CameraPopUp extends StatefulWidget {
  const CameraPopUp({super.key});

  @override
  State<CameraPopUp> createState() => _CameraPopUpState();
}

class _CameraPopUpState extends State<CameraPopUp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      // 팝업창 위치
      alignment: Alignment(width * 0.0013, width * 0.0016), // Alignment(x축, y축)
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TextButton(
            titleText: "카메라 촬영",
            bottomLeft: 0,
            bottomRight: 0,
            topRight: width * 0.05,
            topLeft: width * 0.05,
            onPressed: onCameraButtonTap,
          ),
          _Line(),
          _TextButton(
              titleText: "직접 작성",
              bottomLeft: width * 0.05,
              bottomRight: width * 0.05,
              topRight: 0,
              topLeft: 0,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(create: (context) => DosageCubit(),child:ScheduleWrite()),
                  ),
                );
              }),
        ],
      ),
    );
  }

  void onCameraButtonTap() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ScheduleWrite(),
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  final double bottomLeft;
  final double bottomRight;
  final double topRight;
  final double topLeft;
  final String titleText;
  final VoidCallback onPressed;

  const _TextButton(
      {required this.titleText,
      required this.bottomLeft,
      required this.bottomRight,
      required this.topLeft,
      required this.topRight,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.35,
      height: height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff3D3D3D),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeft),
              bottomRight: Radius.circular(bottomRight),
              topRight: Radius.circular(topRight),
              topLeft: Radius.circular(topLeft),
            ))),
        child: Text(
          titleText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Color(0xff3D3D3D),
          width: width * 0.015,
          height: height * 0.002,
        ),
        Container(
          color: Color(0xff616161),
          width: width * 0.32,
          height: height * 0.002,
        ),
        Container(
          color: Color(0xff3D3D3D),
          width: width * 0.015,
          height: height * 0.002,
        ),
      ],
    );
  }
}
