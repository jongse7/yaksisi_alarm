import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

// 그룹 버튼(중복 선택 X)
class GroupButton extends StatelessWidget {
  final double buttonWidth;
  final List<String> buttonLables;
  final List<int> buttonValues;
  final ValueChanged valueChanged;

  const GroupButton(
      {required this.buttonWidth,
      required this.buttonLables,
      required this.buttonValues,
      required this.valueChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CustomRadioButton(
      width: buttonWidth,
      height: height * 0.055,
      spacing: width * 0.008,
      elevation: 0,
      enableShape: true,
      shapeRadius: width * 0.02,
      unSelectedColor: Color(0xff272727),
      buttonLables: buttonLables,
      buttonValues: buttonValues,
      buttonTextStyle: ButtonTextStyle(
        selectedColor: Colors.black,
        unSelectedColor: Colors.white,
        textStyle: TextStyle(
          fontSize: width * 0.035,
        ),
      ),
      radioButtonValue: valueChanged,
      selectedColor: Color(0xff11CE24),
      selectedBorderColor: Colors.black,
      unSelectedBorderColor: Color(0xff676767),
    );
  }
}

// 그룹 버튼(중복 선택 O)
class GroupButton2 extends StatelessWidget {
  final ValueChanged valueChanged;
  final double buttonWidth;
  final List<String> buttonLables;
  final List<int> buttonValueList;

  const GroupButton2(
      {required this.valueChanged,
      required this.buttonWidth,
      required this.buttonLables,
      required this.buttonValueList,
      super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CustomCheckBoxGroup(
      width: buttonWidth,
      height: height * 0.055,
      spacing: width * 0.008,
      elevation: 0,
      enableShape: true,
      shapeRadius: width * 0.02,
      unSelectedColor: Color(0xff272727),
      selectedColor: Color(0xff11CE24),
      selectedBorderColor: Colors.black,
      unSelectedBorderColor: Color(0xff676767),
      buttonTextStyle: ButtonTextStyle(
        selectedColor: Colors.black,
        unSelectedColor: Colors.white,
        textStyle: TextStyle(
          fontSize: width * 0.035,
        ),
      ),
      buttonLables: buttonLables,
      buttonValuesList: buttonValueList,
      checkBoxButtonValues: valueChanged,
      horizontal: false,
      enableButtonWrap: false,
      absoluteZeroSpacing: false,
      defaultSelected: buttonValueList,
    );
  }
}
