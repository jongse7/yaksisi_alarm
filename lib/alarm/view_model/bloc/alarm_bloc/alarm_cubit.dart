import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/alarm_model.dart';
import '../../../services/alarm_service.dart';
import '../../database_helper/database_helper.dart';
import 'alarm_states.dart';

class AlarmCubit extends Cubit<AlarmStates>{
  AlarmCubit() : super(NoData());
  final DbHelper helper=DbHelper();
  late Future<List<AlarmModel>> list;

  void getData()async{
    helper.getData().then((value) {
      list=Future.value(value);
      emit(HasData());
    });
  }

  void addData(BuildContext context)async{
    var picker= await showTimePicker(context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              // change the border color
              primary: Color(0xff51EE60),
              // change the text color
              onSurface: Colors.white,
              secondary: Colors.green,
            ),
            // button colors
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.dark(
                primary: Colors.green,
              ),
            ),
          ),
          child: child!,
        );
      },
        initialTime: TimeOfDay.now(),
      helpText: "복약 시간 설정",
      cancelText: "취소",
      confirmText: "확인",
    );
    if(picker!=null){
      MyAlarm.setAlarm(picker,context);
    }
  }






  Future<Duration> getDifferenceBetweenCurrentTimeAndSelectedTime(TimeOfDay selectedTime) async {
    final now = DateTime.now();
    final selectedDateTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    return selectedDateTime.difference(now);
  }

}