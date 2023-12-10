// 하단 네비게이터 바

import 'package:clock_analog/screen/dosage_list_screen/dosage_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../alarm/view/alarm view/pill_list_screen.dart';
import '../alarm/view_model/bloc/alarm_bloc/alarm_cubit.dart';
import '../screen/calendar_screen/calendar_screen.dart';
import '../screen/empty_screen.dart';
import '../screen/schedule_write_screen/widget_model/bloc/dosage_cubit.dart';
import 'camera_pop_up.dart';

class NavigatorBar extends StatelessWidget {
  const NavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DefaultTabController(
        length: 3, // 페이지 개수
        child: Stack(
          children: [
            BottomTapBar(),
            CameraButton(),
          ],
        ),
      ),
    );
  }
}

class BottomTapBar extends StatelessWidget {
  const BottomTapBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // 캘린더와 바텀바 사이에 아주 얇게 배경색이 보여서 검정색으로 설정
      backgroundColor: Colors.black,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          CalendarScreen(), // 달력 페이지
          EmptyScreen(),
          DosageListScreen(), // 투약 목록 페이지
        ],
      ),
      extendBodyBehindAppBar: true, // add this line
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Container(
          height: height * 0.15,
          child: TabBar(
            //tab 하단 indicator size -> .label = label의 길이
            //tab 하단 indicator size -> .tab = tab의 길이
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Color(0xff11CE24),
                width: width * 0.018,
              ),
              borderRadius: BorderRadius.circular(width * 0.1),
              insets: EdgeInsets.symmetric(horizontal: - width * 0.04),
            ),
            indicatorPadding: EdgeInsets.only(bottom: height * 0.016),
            //label color
            labelColor: Color(0xff11CE24),
            //unselected label color
            unselectedLabelColor: Color(0xff11CE24),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.calendar_month_outlined,
                  size: width * 0.15,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                  size: width * 0.125,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.event_note_outlined,
                  size: width * 0.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
      bottom: 0,
      right: width * 0.33,
      child: IconButton(
        padding: EdgeInsets.only(top: height * 0.03, bottom: height * 0.035,right: width * 0.1, left: width * 0.1),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CameraPopUp(),
          );
        },
        icon: Icon(
          Icons.camera_alt_outlined,
          color: Color(0xff11CE24),
        ),
        iconSize: width * 0.15,
      ),
    );
  }
}
