import 'package:flutter/material.dart';

import '../../../navigator/navigator_bar.dart';
import '../model/marker_model.dart';

class CalendarPopUp extends StatefulWidget {
  final Event event;
  const CalendarPopUp({required this.event, Key? key}) : super(key: key);

  @override
  State<CalendarPopUp> createState() => _CalendarPopUpState();
}

class _CalendarPopUpState extends State<CalendarPopUp> {
  String memo = "";
  void changeMemo(value) {
    setState(() {
      memo = value;
      widget.event.dosage!["메모"] = memo;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle defaultTextStyle = TextStyle(
      color: Colors.white,
      fontSize: width * 0.03,
      fontWeight: FontWeight.w500,
    );
    return Align(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width * 0.9,
            height: height * 0.65,
            decoration: BoxDecoration(
              color: Color(0xff292929),
              borderRadius: BorderRadius.all(Radius.circular(width * 0.05)),
              border: Border.all(
                color: Color(0xffF0F3D0),
                width: width * 0.0055,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (widget.event.isEat == true)
                        Icon(
                          Icons.check_circle,
                          size: width * 0.1,
                          color: Colors.green,
                        ),
                      if (widget.event.isEat == true)
                        Text(
                          " 복약 완료",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.065,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      if (widget.event.isEat == false)
                        Icon(
                          Icons.cancel,
                          size: width * 0.1,
                          color: Colors.red,
                        ),
                      if (widget.event.isEat == false)
                        Text(
                          " 미복용",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.065,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "  " + widget.event.dosage!["약 이름"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * 0.2,
                        height: height * 0.04,
                        decoration: BoxDecoration(
                            color: Color(0xff51EE60),
                            borderRadius: BorderRadius.all(
                                Radius.circular(width * 0.02))),
                        child: Center(
                          child: Text(
                            '${widget.event.dosage!["투약 횟수"]}정',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Container(
                        width: width * 0.2,
                        height: height * 0.04,
                        decoration: BoxDecoration(
                            color: Color(0xff51EE60),
                            borderRadius: BorderRadius.all(
                                Radius.circular(width * 0.02))),
                        child: Center(
                          child: Text(
                            '매일 ${widget.event.dosage!["투약 횟수"]}회',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    height: height * 0.2,
                    width: width * 0.75,
                    child: ListView.builder(
                      itemCount: widget.event.dosage!["투약 횟수"],
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: height * 0.02),
                          child: SizedBox(
                            width: width * 0.8,
                            height: height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '시간 ${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff3D3D3D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(width * 0.02),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "${widget.event.dosage!["투약 시간${index + 1}"].hour.toString().padLeft(2, '0')}시 ${widget.event.dosage!["투약 시간${index + 1}"].minute.toString().padLeft(2, '0')}분",
                                    style: TextStyle(
                                      fontSize: width * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (widget.event
                                            .dosage!["투약 여부${index + 1}"] ==
                                        false) {
                                      widget.event
                                          .dosage!["투약 여부${index + 1}"] = true;
                                    } else {
                                      widget.event
                                          .dosage!["투약 여부${index + 1}"] = false;
                                    }
                                    setState(() {
                                      int isEatTrue = 0;
                                      for (int i = 1;
                                          i <= widget.event.dosage!["투약 횟수"];
                                          i++) {
                                        if (widget.event.dosage!["투약 여부$i"] ==
                                            true) {
                                          isEatTrue++;
                                        }
                                      }
                                      if (isEatTrue ==
                                          widget.event.dosage!["투약 횟수"]) {
                                        widget.event.isEat = true;
                                      } else {
                                        widget.event.isEat = false;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.check_box_rounded,
                                    color: widget.event
                                                .dosage!["투약 여부${index + 1}"] ==
                                            false
                                        ? Colors.grey
                                        : Color(0xff51EE60),
                                    size: width * 0.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    '메모',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.04,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Container(
                      width: width * 0.75,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          border: Border.all(
                            color: Color(0xff666666),
                            width: width * 0.005,
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.015),
                        child: Text(
                          '${widget.event.dosage!["메모"]}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => NavigatorBar(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff9AE838),
            ),
            child: Text(
              '복용 내역 수정',
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
