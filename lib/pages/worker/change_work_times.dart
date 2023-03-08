import 'package:barbers/models/work_time.dart';
import 'package:barbers/models/worker.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:barbers/utils/requester.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/buttons/base.dart';
import 'package:barbers/widgets/buttons/row_text.dart';
import 'package:flutter/material.dart';

class ChangeWorkTimesPage extends StatefulWidget {
  final int shopId;
  final Worker worker;
  const ChangeWorkTimesPage({
    Key? key,
    required this.shopId,
    required this.worker,
  }) : super(key: key);

  @override
  State<ChangeWorkTimesPage> createState() => _ChangeWorkTimesPageState();
}

class _ChangeWorkTimesPageState extends State<ChangeWorkTimesPage> {
  final _formKey = GlobalKey<FormState>();
  late TimeOfDay? _startT;
  late TimeOfDay? _endT;
  late TimeOfDay? _breakStartT;
  late TimeOfDay? _breakEndT;
  String _startS = "";
  String _endS = "";
  String _breakStartS = "";
  String _breakEndS = "";
  bool monday = true;
  bool tuesday = true;
  bool wednesday = true;
  bool thursday = true;
  bool friday = true;
  bool saturday = true;
  bool sunday = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      Dialogs.failDialog(context: context, content: "Bilgileri eksiksiz doldurun");
      return;
    }
    if (_startT == null || _endT == null || _breakStartT == null || _breakEndT == null) {
      Dialogs.failDialog(context: context, content: "Saat seçin");
      return;
    }
    // startTime büyükse endTime dan return;
    if (_startT!.hour > _endT!.hour || (_startT!.hour == _endT!.hour && _startT!.minute > _endT!.minute)) {
      Dialogs.failDialog(context: context, content: "Mesai Saatlerini kontrol edin");
      return;
    }
    // breakStarTime büyükse breakEndTime dan return;
    if (_breakStartT!.hour > _breakEndT!.hour ||
        (_breakStartT!.hour == _breakEndT!.hour && _breakStartT!.minute > _breakEndT!.minute)) {
      Dialogs.failDialog(context: context, content: "Mola Saatlerini kontrol edin");
      return;
    }
    WorkTime? res = await WorkTime.create(
      shopId: widget.shopId,
      workerId: widget.worker.id!,
      startTime: _startS,
      endTime: _endS,
      breakStart: _breakStartS,
      breakEnd: _breakEndS,
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday,
      sunday: sunday,
    );
    if (res == null) {
      Dialogs.failDialog(context: context);
      return;
    }
    Navigator.pop(context);
    Dialogs.successDialog(context: context);
  }

  void _selectStart() async {
    _startT = await showTimePicker(initialTime: TimeOfDay.now(), context: context);
    if (_startT == null) return;
    setState(() => _startS = "${_startT!.hour}.${_startT!.minute}");
  }

  void _selectEnd() async {
    _endT = await showTimePicker(initialTime: TimeOfDay.now(), context: context);
    if (_endT == null) return;
    setState(() => _endS = "${_endT!.hour}.${_endT!.minute}");
  }

  void _selectBreakStart() async {
    _breakStartT = await showTimePicker(initialTime: TimeOfDay.now(), context: context);
    if (_breakStartT == null) return;
    setState(() {
      _breakStartS = "${_breakStartT!.hour}.${_breakStartT!.minute}";
    });
  }

  void _selectBreakEnd() async {
    _breakEndT = await showTimePicker(initialTime: TimeOfDay.now(), context: context);
    if (_breakEndT == null) return;
    setState(() {
      _breakEndS = "${_breakEndT!.hour}.${_breakEndT!.minute}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle("Mesai"),
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowTextButton(
                    text: "Başlangıç zamanı: ${_startS}",
                    iconData: Icons.timelapse,
                    onPressed: _selectStart,
                  ),
                  RowTextButton(text: "Bitiş zamanı: ${_endS}", iconData: Icons.timelapse, onPressed: _selectEnd),
                  RowTextButton(
                    text: "Mola başlangıç zamanı: ${_breakStartS}",
                    iconData: Icons.timelapse,
                    onPressed: _selectBreakStart,
                  ),
                  RowTextButton(
                    text: "Mola bitiş zamanı: ${_breakEndS}",
                    iconData: Icons.timelapse,
                    onPressed: _selectBreakEnd,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "Çalışma Günleri",
                        style: TextStyle(
                          color: Colorer.onBackground,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  RowTextButton(
                    text: "Pazartesi ",
                    iconData: Icons.circle,
                    iconColor: monday ? Colorer.onBackground : Colorer.surface,
                    onPressed: () {
                      setState(() {
                        monday = !monday;
                      });
                    },
                  ),
                  RowTextButton(
                    text: "Salı ",
                    iconData: Icons.circle,
                    iconColor: tuesday ? Colorer.onBackground : Colorer.surface,
                    onPressed: () {
                      setState(() {
                        tuesday = !tuesday;
                      });
                    },
                  ),
                  RowTextButton(
                    text: "Çarşamba ",
                    iconData: Icons.circle,
                    iconColor: wednesday ? Colorer.onBackground : Colorer.surface,
                    onPressed: () {
                      setState(() {
                        wednesday = !wednesday;
                      });
                    },
                  ),
                  RowTextButton(
                    text: "Perşembe ",
                    iconData: Icons.circle,
                    iconColor: thursday ? Colorer.onBackground : Colorer.surface,
                    onPressed: () {
                      setState(() {
                        thursday = !thursday;
                      });
                    },
                  ),
                  RowTextButton(
                    text: "Cuma ",
                    iconData: Icons.circle,
                    iconColor: friday ? Colorer.onBackground : Colorer.surface,
                    onPressed: () {
                      setState(() {
                        friday = !friday;
                      });
                    },
                  ),
                  RowTextButton(
                    text: "Cumartesi ",
                    iconData: Icons.circle,
                    iconColor: saturday ? Colorer.onBackground : Colorer.surface,
                    onPressed: () {
                      setState(() {
                        saturday = !saturday;
                      });
                    },
                  ),
                  RowTextButton(
                    text: "Pazar ",
                    iconData: Icons.circle,
                    iconColor: sunday ? Colorer.onBackground : Colorer.surface,
                    onPressed: () {
                      setState(() {
                        sunday = !sunday;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: BaseButton(
                      text: "Tamam",
                      onPressed: () => _submit(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
