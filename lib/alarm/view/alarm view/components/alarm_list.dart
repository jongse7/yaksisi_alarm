import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../screen/schedule_write_screen/widget_model/bloc/dosage_cubit.dart';
import '../../../../screen/schedule_write_screen/widget_model/bloc/dosage_states.dart';
import '../../../../screen/schedule_write_screen/widget_model/model/dosage_model.dart';
import '../../buttons/warning.dart';
import 'package:clock_analog/screen/schedule_write_screen/widget_model/database_helper/database_helper.dart';

// 투약 목록 리스트뷰

class AlarmList extends StatelessWidget {
  const AlarmList({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<Color>> colorList = [
      [
        const Color(0xffED638C),
        const Color(0xffED9463),
        const Color(0xff9AE838)
      ],
      [
        const Color(0xffF1C0CC),
        const Color(0xffF1C9C0),
        const Color(0xffF0F3D0),
      ]
    ];
    int colorNumber = 0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: BlocConsumer<DosageCubit, DosageStates>(
        builder: (context, state) {
          if (state is HasData) {
            return FutureBuilder(
              future: BlocProvider.of<DosageCubit>(context).list,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot);
                  print(snapshot.hasData);
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      colorNumber++;
                      if(colorNumber > 2){
                        colorNumber = 0;
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: Row(
                          children: [
                            _LeftBox(
                              boxColor: colorList[0][colorNumber],
                            ),
                            _RightBox(
                              boxColor: colorList[1][colorNumber],
                              snapshot: snapshot,
                              index: index,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Text("");
                }
              },
            );
          } else {
            return Container();
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}

class _RightBox extends StatelessWidget {
  final Color boxColor;
  final AsyncSnapshot<List<DosageModel>> snapshot;
  final int index;
  const _RightBox(
      {required this.boxColor,
      required this.snapshot,
      required this.index,
      Key? key})
      : super(key: key);

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
            color: boxColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(width * 0.0175),
              bottomRight: Radius.circular(width * 0.0175),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PillNameText(),
                _DayAndTimeText(
                  snapshot: snapshot,
                  index: index,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _DeleteAndFixButton(
            snapshot: snapshot,
            index: index,
          ),
        ),
      ],
    );
  }
}

class _LeftBox extends StatelessWidget {
  final Color boxColor;
  const _LeftBox({required this.boxColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.075,
      height: height * 0.12,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(width * 0.0175),
          bottomLeft: Radius.circular(width * 0.0175),
        ),
      ),
    );
  }
}

class _PillNameText extends StatelessWidget {
  const _PillNameText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Text(
      '타이레놀', // 약 이름
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: width * 0.05,
          height: 0,
          color: Colors.black),
    );
  }
}

class _DayAndTimeText extends StatelessWidget {
  final AsyncSnapshot<List<DosageModel>> snapshot;
  final int index;
  const _DayAndTimeText({required this.snapshot, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Text(
          '${snapshot.data![index].day}',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: width * 0.04, height: 0, color: Colors.black),
        ),
        Text(' | ',
            style: TextStyle(
                fontSize: width * 0.04, height: 0, color: Colors.black)),
        RichText(
          text: TextSpan(
            children: [
              // 시:분
              TextSpan(
                text:
                    '${snapshot.data![index].hour}:${snapshot.data![index].min}',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.black,
                      fontSize: width * 0.04,
                    ),
              ),
              // am or pm
              TextSpan(
                text: " ${snapshot.data![index].period}",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.black, fontSize: width * 0.04),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _DeleteAndFixButton extends StatelessWidget {
  final AsyncSnapshot<List<DosageModel>> snapshot;
  final int index;
  const _DeleteAndFixButton(
      {required this.snapshot, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle textButtonStyle =
        TextStyle(color: Color(0XFF6C6C6C), fontSize: width * 0.04);
    return Row(
      children: [
        TextButton(
          onPressed: () {
            DeleteWarningDialog(() {
              DbHelper().delete(
                snapshot.data![index].key!,
              );
              BlocProvider.of<DosageCubit>(context).getData();
              Navigator.of(context).pop();
            }, context);
          },
          child: Text(
            '삭제',
            style: textButtonStyle,
          ),
        ),
        Text(
          '|',
          style: textButtonStyle,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            '수정',
            style: textButtonStyle,
          ),
        ),
      ],
    );
  }
}
