class Event {
  Map<String, dynamic> dosage;

  Event(this.dosage);
}

void getDate(Map<String, dynamic> dosage) {
  // 새로운 event 생성
  Event currentEvent = Event(dosage);

  // 일 차이 계산
  Duration difference = dosage["종료일"].difference(dosage["시작일"]);

  // 일(day) 차이를 int로 변환합니다.
  int end = difference.inDays;

  // 시작일부터 종료일까지 반복
  for (int i = 0; i <= end; i++) {
    DateTime currentDay = dosage["시작일"].add(Duration(days: i));

    if (events.containsKey(currentDay)) {
      // 이미 해당 날짜에 이벤트가 있는 경우의 처리
      events[currentDay]!.add(currentEvent);
    } else {
      // 해당 날짜에 이벤트가 없는 경우 새로운 리스트를 생성하여 추가
      events[currentDay] = [currentEvent];
    }
  }
}

Map<DateTime, List<Event>> events = {
};

List<Event> getEventsForDay(DateTime day) {
  DateTime currentDay = DateTime(day.year,day.month,day.day);
  return events[currentDay] ?? [];
}

