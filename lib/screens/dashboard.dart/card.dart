import 'package:calendar/index.dart';
import 'package:calendar/utils/card-chip.dart';

class CardModelView extends StatefulWidget {
  CardModelView({Key key, this.item}) : super(key: key);
  final CalendarItemModel item;

  @override
  _CardModelViewState createState() => _CardModelViewState();
}

class _CardModelViewState extends State<CardModelView> {
  @override
  void initState() {
    super.initState();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final color = Color(CommonWidgets.getColorFromHex(
        CommonWidgets.convertAnyStringToHex(
            widget.item.type == null ? widget.item.title : widget.item.type)));
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 10),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(2, 2),
                blurRadius: 8,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
                      color: color,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              CommonWidgets.checkNull(widget.item.title),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () async {},
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.more_vert,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: AnimatedContainer(
                        curve: Curves.bounceIn,
                        duration: Duration(milliseconds: 500),
                        color: AppColor.white,
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 4, bottom: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(width: double.infinity),
                                    widget.item.startedAt == null
                                        ? Container()
                                        : TextIconRow(
                                            icon: Icons.calendar_today,
                                            color: color,
                                            text: CommonWidgets
                                                .convertToDatefromSec(
                                                    widget.item.startedAt),
                                          ),
                                    widget.item.startedAt == null &&
                                            widget.item.startedAt == null
                                        ? Container()
                                        : TextIconRow(
                                            color: color,
                                            icon: Icons.watch_later_outlined,
                                            text: CommonWidgets.convertToTime(
                                                    widget.item.startedAt) +
                                                " - " +
                                                CommonWidgets.convertToTime(
                                                    widget.item.endedAt),
                                          ),
                                    //Navigate to profile
                                    widget.item.type == null
                                        ? Container()
                                        : CardChip(
                                            color: color,
                                            text: widget.item.type,
                                          ),
                                    isExpanded
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              widget.item.addedBy == null
                                                  ? Container()
                                                  : TextIconRow(
                                                      color: color,
                                                      head: "Added By: ",
                                                      text: CommonWidgets
                                                          .checkNull(widget
                                                              .item.addedBy),
                                                    ),
                                              Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 4),
                                                  child: CommonWidgets
                                                      .getLinkableText(
                                                          "Description: " +
                                                              widget.item
                                                                  .description)),
                                              // TextIconRow(
                                              //   color: color,
                                              //   head: "Description: ",
                                              //   text: CommonWidgets.checkNull(
                                              //       widget.item.description),
                                              // ),
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAction(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: AppColor.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        ),
      ),
    );
  }
}
