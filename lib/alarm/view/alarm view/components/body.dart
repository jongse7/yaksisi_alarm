import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../view_model/bloc/alarm_bloc/alarm_cubit.dart';
import 'alarm_list.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.01),
            child: Text(
              '투약목록',
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.08,
              ),
            ),
          ),
          Expanded(
            child: AlarmList(),
          ),
        ],
      ),
    );
  }
}
