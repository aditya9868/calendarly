import 'dart:isolate';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:calendar/index.dart';

class BottomBar extends StatefulWidget {
  final int i;
  BottomBar({
    Key key,
    @required this.i,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    int p;

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5.0,
      child: Container(
        height: AppBar().preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: widget.i == 0 ? AppColor.cyan : Colors.black,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.meeting_room,
                  color: widget.i == 1 ? AppColor.cyan : Colors.black,
                ),
                onPressed: () async {}),
            Container(width: 50),
            IconButton(
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: widget.i == 2 ? AppColor.cyan : Colors.black,
                ),
                onPressed: () async {
                  // }
                }),
            IconButton(
                icon: Icon(
                  widget.i == 3 ? Icons.person : Icons.person_outlined,
                  color: widget.i == 3 ? AppColor.cyan : Colors.black,
                ),
                onPressed: () async {}),
          ],
        ),
      ),
    );
  }
}

class FloatingAppButton extends StatefulWidget {
  const FloatingAppButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);
  final Function onPressed;

  @override
  _FloatingAppButtonState createState() => _FloatingAppButtonState();
}

class _FloatingAppButtonState extends State<FloatingAppButton> {
  static const String _isolateName = "LocatorIsolate";
  ReceivePort port = ReceivePort();
  @override
  void initState() {
    super.initState();
  }

  var _init = true;
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5,
      backgroundColor: AppColor.cyan,
      onPressed: () async {
        showModalBottomSheet(
          backgroundColor: AppColor.transparent,
          isScrollControlled: true,
          context: context,
          builder: (context) => SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Consumer<Credential>(
                builder: (context, cred, _) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          color: AppColor.grey,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextButton(
                        text: "Add Event",
                        onPressed: () async {
                          Navigator.pop(context);
                          CommonWidgets.push(context, AddEvent());
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColor.cyan,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColor.cyan.withOpacity(0.8),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset(
            AppAssets.add,
            color: AppColor.white,
          )),
    );
  }
}
