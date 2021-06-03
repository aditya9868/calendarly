import 'package:intl/intl.dart';
import 'package:calendar/index.dart';

class CustomTimePicker extends StatefulWidget {
  Function(TimeOfDay) changeTime;
  String text;
  TimeOfDay initialTime;
  TimeOfDay startTime;

  CustomTimePicker(
      {Key key,
      @required this.text,
      @required this.initialTime,
      this.startTime,
      @required this.changeTime})
      : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  static const int _bluePrimaryValue = 0xFF54D3C2;
  static const MaterialColor cyan = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
  var timeT = "";

  Future<void> submit() async {
    final date = await showTimePicker(
        context: context,
        initialTime:
            widget.startTime == null ? TimeOfDay.now() : widget.startTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: cyan,
                backgroundColor: AppColor.white,
                cardColor: AppColor.white,
                primaryColorDark: AppColor.cyan,
                accentColor: AppColor.cyan,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });
    if (date != null) {
      DateTime p = CommonWidgets.convertTimeOfDay(date);
      setState(() {
        widget.changeTime(date);
        timeT = DateFormat("hh:mm a").format(p);
      });
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            child: Text(widget.text)),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.grey.withOpacity(0.1)),
            height: 45,
            padding: const EdgeInsets.only(left: 15),
            child: InkWell(
              onTap: submit,
              child: Row(
                children: [
                  Expanded(
                    child: Text(timeT == "" ? ("Choose " + widget.text) : timeT,
                        style: TextStyle(
                            fontSize: 15,
                            color: timeT == "" ? AppColor.grey : Colors.black)),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
