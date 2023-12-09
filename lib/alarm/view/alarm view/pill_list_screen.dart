import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../screen/schedule_write_screen/widget_model/bloc/dosage_cubit.dart';
import '../../view_model/bloc/alarm_bloc/alarm_cubit.dart';
import 'components/body.dart';
class PillListScreen extends StatefulWidget {
  const PillListScreen({super.key});
  @override
  State<PillListScreen> createState() => _PillListScreenState();
}
class _PillListScreenState extends State<PillListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DosageCubit>(context).getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}
