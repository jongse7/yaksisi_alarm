import 'package:flutter/material.dart';
import '../calendar_screen/model/marker_model.dart';

class DosageListScreen extends StatefulWidget {
  const DosageListScreen({Key? key}) : super(key: key);

  @override
  State<DosageListScreen> createState() => _DosageListScreenState();
}

class _DosageListScreenState extends State<DosageListScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '투약목록',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.075,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                        itemCount: dosageList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.01),
                            child: Row(
                              children: [
                                _LeftBox(
                                  index: index,
                                ),
                                _RightBox(
                                  onPressed: onPressed,
                                  index: index,
                                ),
                              ],
                            ),
                          );
                          ;
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressed(index){
    deleteDate(dosageList[index]["약 이름"]);
    setState(() {
    });
  }

}

class _RightBox extends StatelessWidget {
  final void Function(int index) onPressed;
  final int index;
  const _RightBox({required this.onPressed,required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: width * 0.75,
          height: height * 0.12,
          decoration: BoxDecoration(
            color: dosageList[index]["색상"][1],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(width * 0.0175),
              bottomRight: Radius.circular(width * 0.0175),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.01,
              left: width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PillNameText(
                  index: index,
                ),
                _DayAndTimeText(
                  index: index,
                ),
                Row(children: [
                  if(dosageList[index]["투약 시간1"] != null)
                    Text(
                      '${dosageList[index]["투약 시간1"].hour.toString().padLeft(2, '0')}시 ${dosageList[index]["투약 시간1"].minute.toString().padLeft(2, '0')}분',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: width * 0.03, height: 0, color: Colors.black),
                    ),
                  if(dosageList[index]["투약 시간2"] != null)
                    Text(
                      ', ${dosageList[index]["투약 시간2"].hour.toString().padLeft(2, '0')}시 ${dosageList[index]["투약 시간2"].minute.toString().padLeft(2, '0')}분',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: width * 0.03, height: 0, color: Colors.black),
                    ),
                  if(dosageList[index]["투약 시간3"] != null)
                    Text(
                      ', ${dosageList[index]["투약 시간3"].hour.toString().padLeft(2, '0')}시 ${dosageList[index]["투약 시간3"].minute.toString().padLeft(2, '0')}분',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: width * 0.03, height: 0, color: Colors.black),
                    ),
                  Text(' 마다',style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: width * 0.03, height: 0, color: Colors.black),),
                ],),

              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _DeleteAndFixButton(
            index: index,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class _LeftBox extends StatelessWidget {
  final int index;
  const _LeftBox({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.075,
      height: height * 0.12,
      decoration: BoxDecoration(
        color: dosageList[index]["색상"][0],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(width * 0.0175),
          bottomLeft: Radius.circular(width * 0.0175),
        ),
      ),
    );
  }
}

class _PillNameText extends StatelessWidget {
  final int index;
  const _PillNameText({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Text(
      dosageList[index]["약 이름"], // 약 이름
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: width * 0.05,
          height: 0,
          color: Colors.black),
    );
  }
}

class _DayAndTimeText extends StatelessWidget {
  final int index;
  const _DayAndTimeText({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Text(
          '${dosageList[index]["시작일"].month.toString().padLeft(2, '0')}월 ${dosageList[index]["시작일"].day.toString().padLeft(2, '0')}일',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: width * 0.04, height: 0, color: Colors.black),
        ),
        Text(' ~ ',
            style: TextStyle(
                fontSize: width * 0.04, height: 0, color: Colors.black)),
        Text(
          '${dosageList[index]["종료일"].month.toString().padLeft(2, '0')}월 ${dosageList[index]["종료일"].day.toString().padLeft(2, '0')}일',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: width * 0.04, height: 0, color: Colors.black),
        ),
      ],
    );
  }
}

class _DeleteAndFixButton extends StatelessWidget {
  final void Function(int index) onPressed;
  final int index;
  const _DeleteAndFixButton({required this.onPressed,required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle textButtonStyle =
        TextStyle(color: Color(0XFF6C6C6C), fontSize: width * 0.035);
    return Row(
      children: [
        SizedBox(
          width: width * 0.125,
          child: TextButton(
            onPressed: (){onPressed(index);},
            child: Text(
              '삭제',
              style: textButtonStyle,
            ),
          ),
        ),
        Text(
          '|',
          style: textButtonStyle,
        ),
        SizedBox(
          width: width * 0.125,
          child: TextButton(
            onPressed: () {},
            child: Text(
              '수정',
              style: textButtonStyle,
            ),
          ),
        ),
      ],
    );
  }
}
