import 'dart:math';
import 'package:alarm/alarm.dart';
import 'package:clock_analog/screen/schedule_write_screen/widget_model/model/dosage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dosage_cubit.dart';

class MyDosage {
  static void setAlarm(Map<String, dynamic> dosage, BuildContext context) {
    // 일 차이 계산
    Duration difference = dosage["종료일"].difference(dosage["시작일"]);

    // 일(day) 차이를 int로 변환합니다.
    int end = difference.inDays;
    // 반복문으로 하루당 알람 1~3개씩 만들어주기 로직 구현중 너무 어령ㅁ
    for (int i = 0; i < end; i++) {
      for (int j = 0; j < dosage["투약 횟수"]; j++) {
        final timeOfDay = dosage["투약 시간${j+1}"];
        var day = dosage["시작일"].add(Duration(days: i));
        var dateTime = DateTime(
            day.year, day.month, day.day, timeOfDay.hour, timeOfDay.minute);
        final alarmSettings = AlarmSettings(
          id: Random().nextInt(100),
          dateTime: dateTime,
          assetAudioPath: 'assets/audio/alarm_audio.mp3',
          loopAudio: true,
          vibrate: true,
          volumeMax: true,
          fadeDuration: 3.0,
          notificationTitle: '복약 시간 입니다',
          notificationBody: '클릭 시 정지',
          enableNotificationOnKill: true,
          stopOnNotificationOpen: true,
        );
        Alarm.set(alarmSettings: alarmSettings).then((value) {
          BlocProvider
              .of<DosageCubit>(context)
              .helper
              .insert(
            DosageModel(
                key: dosage["약 이름"] + "$i," + "$j",
                hour: dosage["투약 시간$j+1"].hourOfPeriod.toString(),
                period: dosage["투약 시간$j+1"].period.name,
                min: dosage["투약 시간$j+1"].minute.toString(),
                day: '${day.year}년 ${day.month}월 ${day.day}일',
                isEnabled: 'true',
                alarmId: alarmSettings.id.toString(),
                title: 'Alarm N'),
          );
        }).then((value) {
          BlocProvider.of<DosageCubit>(context).getData();
        });
      }
    }
  }
}