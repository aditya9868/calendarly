import 'package:calendar/index.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var _init = true;
  var isLoading = false;
  List<ViewCalendar> listofDates = [];
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_init) {
      _init = false;
      setState(() {
        isLoading = true;
      });
      listofDates = await Provider.of<CalendarProvider>(context, listen: false)
          .getSchedule();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isLoading: isLoading,
      padding: const EdgeInsets.all(0),
      appBar: CustomAppBar(
        text: "Calendar",
        showPrefix: false,
      ),
      children: [
        Expanded(
          child: SfCalendar(
            view: CalendarView.month,
            dataSource: ViewCalendarDataSource(listofDates),
            allowedViews: [
              CalendarView.day,
              CalendarView.week,
              CalendarView.month,
              CalendarView.schedule
            ],
            // timeSlotViewSettings: TimeSlotViewSettings(
            
            // ),
            resourceViewSettings: ResourceViewSettings(),
            showDatePickerButton: true,
            backgroundColor: Scaffold().backgroundColor,
            allowViewNavigation: true,
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          ),
        )
      ],
      
    );
  }

  // List<ViewCalendar> _getDataSource() {
  //   final List<ViewCalendar> meetings = <ViewCalendar>[];
  //   final DateTime today = DateTime.now();
  //   final DateTime startTime =
  //       DateTime(today.year, today.month, today.day, 9, 0, 0);
  //   final DateTime endTime = startTime.add(const Duration(hours: 2));
  //   meetings.add(ViewCalendar(
  //       'Conference', startTime, endTime, const Color(0xFF0F8644), true));
  //   return meetings;
  // }
}
