import 'dart:math';
import 'package:alarm/alarm.dart';
import 'package:clock_analog/screen/schedule_write_screen/database/dosage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../alarm/model/alarm_model.dart';

class MyDosage {
  static void setAlarm(Map<String, dynamic> dosage) {
    // 일 차이 계산
    Duration difference = dosage["종료일"].difference(dosage["시작일"]);

    // 일(day) 차이를 int로 변환합니다.
    int end = difference.inDays;

    // 반복문으로 하루당 알람 1~3개씩 만들어주기 로직 구현중 너무 어령ㅁ
    for (int i = 0; i < end; i++) {
      for (int j = 0; j < dosage["투약 횟수"]; j++) {
        final timeOfDay = dosage["투약 시간$j"];
        var day = dosage["시작일"].add(Duration(days: i));
        var dateTime = DateTime(day.year, day.month, day.day, timeOfDay.hour, timeOfDay.minute);
        final alarmSettings = AlarmSettings(
          id: Random().nextInt(100),
          dateTime: dateTime,
          assetAudioPath: 'assets/audio/tune.mp3',
          loopAudio: true,
          vibrate: true,
          volumeMax: true,
          fadeDuration: 3.0,
          notificationTitle: 'Alarm is Playing',
          notificationBody: 'Tap to stop',
          enableNotificationOnKill: true,
          stopOnNotificationOpen: true,
        );
        Alarm.set(alarmSettings: alarmSettings).then((value) {
          BlocProvider
              .of<DosageCubit>(dosage as BuildContext)
              .helper
              .insert(
            AlarmModel(
                key: DateTime
                    .now()
                    .microsecondsSinceEpoch
                    .toString(),
                hour: dosage["투약 시간$j"].hourOfPeriod.toString(),
                period: dosage["투약 시간$j"].period.name,
                min: dosage["투약 시간$j"].minute.toString(),
                day: 'Today',
                isEnabled: 'true',
                alarmId: alarmSettings.id.toString(),
                title: 'Alarm N'),
          );
        }).then((value) {
          BlocProvider.of<DosageCubit>(dosage as BuildContext).getData();
        });
      }
    }
  }
}