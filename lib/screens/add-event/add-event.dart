import 'package:calendar/index.dart';
import 'package:calendar/screens/add-event/add-event-model.dart';
import 'package:calendar/screens/add-event/add-event-provider.dart';
import 'package:calendar/utils/custom-datepicker.dart';
import 'package:calendar/utils/custom-textfield.dart';
import 'package:calendar/utils/custom-timepicker.dart';
import 'package:flutter/cupertino.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController url = TextEditingController();
  bool isLoading = false;
  bool isPrivate = true;

  DateTime startDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  DateTime now = DateTime.now();
  changeStartDate(DateTime date) {
    startDate = date;
  }

  changeStartTime(TimeOfDay time) {
    startTime = time;
  }

  changeEndTime(TimeOfDay time) {
    endTime = time;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isLoading: isLoading,
      appBar: CustomAppBar(
        text: "Add Event",
      ),
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: "Title",
                  controller: title,
                ),
                CustomDatePicker(
                  text: "Date",
                  changeDate: changeStartDate,
                  maxDate: DateTime.now().add(Duration(days: 365)),
                  minDate: DateTime.now(),
                  isApp: false,
                  startDate: startDate,
                ),
                CustomTimePicker(
                    text: "Starting Time",
                    initialTime: startTime,
                    changeTime: changeStartTime),
                CustomTimePicker(
                    text: "Ending Time",
                    initialTime: endTime,
                    changeTime: changeEndTime),
                CustomSwitch(
                  func: () {
                    setState(() {
                      isPrivate = !isPrivate;
                    });
                  },
                  text: "Private",
                  isChecked: isPrivate,
                ),
                CustomTextField(
                  hint: "Url",
                  controller: url,
                ),
                CustomTextField(
                  hint: "Description",
                  controller: des,
                ),
              ],
            ),
          ),
        ),
        CustomButton(
          func: () async {
            FocusScope.of(context).unfocus();
            if (title.text == "") {
              CommonWidgets.showToast(context, "Enter Title", duration: 2);
              return;
            }
            if (startDate == null) {
              CommonWidgets.showToast(context, "Choose Date", duration: 2);
              return;
            }
            if (startTime == null) {
              CommonWidgets.showToast(context, "Choose Starting Time",
                  duration: 2);
              return;
            }
            if (endTime == null) {
              CommonWidgets.showToast(context, "Choose Ending Time",
                  duration: 2);
              return;
            }
            if (CommonWidgets.convertTimeOfDay(startTime)
                .isAfter(CommonWidgets.convertTimeOfDay(endTime))) {
              CommonWidgets.showToast(
                  context, "Starting Time Must be before Ending time",
                  duration: 2);
              return;
            }
            setState(() {
              isLoading = true;
            });
            final response =
                await Provider.of<AddEventProvider>(context, listen: false)
                    .addEvent(AddEventModel(
              date: startDate,
              endingTime: endTime,
              isFullDay: false,
              isPrivate: isPrivate,
              startingTime: startTime,
              title: title.text,
              description: des.text,
            ));
            setState(() {
              isLoading = false;
            });
            CommonWidgets.showToast(context, response.message);
            Future.delayed(Duration(seconds: 3));

            if (response.isSuccess) {
              Navigator.pop(context);
            }
          },
          text: "Add",
          isLoading: false,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    Key key,
    this.isChecked,
    this.text,
    this.func,
  }) : super(key: key);
  final String text;
  final bool isChecked;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        onTap: func,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              CupertinoSwitch(
                activeColor:
                    isChecked ? AppColor.cyan : Colors.grey.withOpacity(0.6),
                onChanged: (bool value) {
                  func();
                },
                value: isChecked,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
