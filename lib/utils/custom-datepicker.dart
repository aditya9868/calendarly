import 'package:calendar/index.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  Function(DateTime) changeDate;
  String text;
  bool isApp;
  bool readOnly;
  DateTime minDate;
  DateTime maxDate;
  DateTime startDate;
  CustomDatePicker(
      {Key key,
      @required this.text,
      @required this.minDate,
      @required this.maxDate,
      this.isApp = false,
      this.startDate,
      this.readOnly = false,
      @required this.changeDate})
      : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  void initState() {
    print(widget.startDate);
    if (widget.startDate != null) {
      _init = true;
      if (widget.isApp)
        dateT =
            DateFormat("EEE, MMM d, yyyy HH:mm aaa").format(widget.startDate);
      else
        dateT = DateFormat("EEE, MMM d, yyyy").format(widget.startDate);
    }
    super.initState();
  }

  var _init = false;
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
  String dateT = "";

  Future<void> submit() async {
    final date = await showDatePicker(
        context: context,
        initialDate: !_init ? DateTime.now() : widget.startDate,
        firstDate: widget.minDate,
        lastDate: widget.maxDate,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: cyan,
                backgroundColor: AppColor.cyan,
                cardColor: AppColor.cyan,
                primaryColorDark: AppColor.cyan,
                accentColor: AppColor.cyan,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (date == null) return;

    TimeOfDay bottom;
    if (widget.isApp) {
      bottom = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: cyan,
                  backgroundColor: AppColor.white,
                  cardColor: AppColor.white,
                  primaryColorDark: AppColor.white,
                  accentColor: AppColor.cyan,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child,
            );
          });
    }
    if (widget.isApp) {
      if (bottom == null) return;
      setState(() {
        widget.startDate = date.add(
          Duration(
            hours: int.parse(
              bottom.hour.toString(),
            ),
            minutes: int.parse(
              bottom.minute.toString(),
            ),
          ),
        );

        dateT =
            DateFormat("EEE, MMM d, yyyy HH:mm aaa").format(widget.startDate);

        _init = true;
      });
    } else
      setState(() {
        widget.startDate = date;

        dateT = CommonWidgets.convertToDate(widget.startDate.toString());
        _init = true;
      });
    callDate(widget.startDate);
  }

  callDate(DateTime date) {
    widget.changeDate(date);
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
              onTap:widget.readOnly?null: submit,
              child: Row(
                children: [
                  Expanded(
                    child: Text(!_init ? ("Choose" + widget.text) : dateT,
                        style: TextStyle(
                            color: !_init ? AppColor.grey : Colors.black)),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: AppColor.grey,
                        size: 18,
                      ),
                      onPressed: submit),
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
