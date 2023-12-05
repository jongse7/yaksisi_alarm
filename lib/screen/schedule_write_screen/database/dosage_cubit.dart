import 'package:clock_analog/screen/schedule_write_screen/database/dosage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../alarm/model/alarm_model.dart';
import '../../../alarm/services/alarm_service.dart';
import '../../../alarm/view_model/bloc/alarm_bloc/alarm_states.dart';
import '../../../alarm/view_model/database_helper/database_helper.dart';

class DosageCubit extends Cubit<AlarmStates>{
  DosageCubit() : super(NoData());
  final DbHelper helper=DbHelper();
  late Future<List<AlarmModel>> list;

  void getData()async{
    helper.getData().then((value) {
      list=Future.value(value);
      emit(HasData());
    });
  }

  void addData(Map<String, dynamic>dosage)async{
    MyDosage.setAlarm(dosage);
    }






  Future<Duration> getDifferenceBetweenCurrentTimeAndSelectedTime(TimeOfDay selectedTime) async {
    final now = DateTime.now();
    final selectedDateTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    return selectedDateTime.difference(now);
  }

}