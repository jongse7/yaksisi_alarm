import 'package:clock_analog/screen/schedule_write_screen/widget_model/database_helper/database_helper.dart';
import 'package:clock_analog/screen/schedule_write_screen/widget_model/model/dosage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/dosage_service.dart';
import 'dosage_states.dart';

class DosageCubit extends Cubit<DosageStates>{
  DosageCubit() : super(NoData());

  final DbHelper helper=DbHelper();
  late Future<List<DosageModel>> list;

  void getData() async {
    print("getData() called");
    helper.getData().then((value) {
      list = Future.value(value);
      emit(HasData());
    });
  }

  void addData(BuildContext context, {required Map<String, dynamic> dosage})async{
    MyDosage.setAlarm(dosage, context);
    }
}