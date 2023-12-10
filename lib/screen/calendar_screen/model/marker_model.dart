class Event {
  String key = "";
  Map<String, dynamic>? dosage;
  bool allEat = false;
  List<bool> isEat = [false, false, false];
  Event(this.dosage);
}

void getDate(Map<String, dynamic> dosage) {
  // 일 차이 계산
  Duration difference = dosage["종료일"].difference(dosage["시작일"]);

  // 일(day) 차이를 int로 변환합니다.
  int end = difference.inDays;
  // 같은 이벤트들을 묶어서 관리하기 위해 keyt를 부여합니다. key는 약 이름입니다.

  // 시작일부터 종료일까지 반복
  for (int i = 0; i <= end; i++) {
    DateTime currentDay = dosage["시작일"].add(Duration(days: i));

    // 각 날짜에 대한 새로운 event 생성
    Event currentEvent = Event(dosage);
    currentEvent.key = dosage["약 이름"];
    if (events.containsKey(currentDay)) {
      // 이미 해당 날짜에 이벤트가 있는 경우의 처리
      events[currentDay]!.add(currentEvent);
    } else {
      // 해당 날짜에 이벤트가 없는 경우 새로운 리스트를 생성하여 추가
      events[currentDay] = [currentEvent];
    }
  }

  dosageList.add(dosage);
}

void deleteDate(String dosageName) {
  Iterable<DateTime> timeList = events.keys;
  for(var keys in timeList){
    if(events[keys] != null) {
      for (int i = 0; i < events[keys]!.length; i++) {
        if(events[keys]![i].key == dosageName){
          events[keys]!.removeAt(i);
        }
      }
    }
  }

  for(int i = 0; i < dosageList.length; i++){
    if(dosageList[i]["약 이름"] == dosageName){
      dosageList.removeAt(i);
    }
  }
}

Map<DateTime, List<Event>> events = {
};

List<Map<String, dynamic>> dosageList =[
];

List<Event> getEventsForDay(DateTime day) {
  DateTime currentDay = DateTime(day.year,day.month,day.day);
  return events[currentDay] ?? [];
}

