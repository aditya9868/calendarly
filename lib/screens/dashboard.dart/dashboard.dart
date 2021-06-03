import 'package:calendar/index.dart';
import 'package:calendar/screens/dashboard.dart/card.dart';
import 'package:calendar/screens/dashboard.dart/dashboard-provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dash, _) => CustomScaffold(
        appBar: CustomAppBar(
          text: "Dashboard",
          showPrefix: false,
          suffix: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                CommonWidgets.push(context, CalendarScreen());
              }),
        ),
        padding: const EdgeInsets.all(0),
        children: [
          Expanded(
            child: StreamBuilder<List<CalendarItemModel>>(
              stream: dash.getEventStream,
              initialData: [],
              builder: (context, snapshot) {
                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: snapshot.data
                      .map((e) => CardModelView(
                            item: e,
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
        bottomBar: BottomBar(
          i: 0,
        ),
        floatingAppButton: FloatingAppButton(
          onPressed: () {},
        ),
      ),
    );
  }
}
