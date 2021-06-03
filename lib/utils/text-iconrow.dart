import 'package:calendar/index.dart';

class TextIconRow extends StatelessWidget {
  const TextIconRow({
    Key key,
    this.text,
    this.icon,
    this.head,
    this.color=AppColor.cyan,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final String head;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (text == null || text == "")
      return Container();
    else
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon == null
              ? Container()
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    icon,
                    color: color,
                    size: 15,
                  )),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              margin: const EdgeInsets.only(right: 5),
              child: head == null
                  ? Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: head,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                            TextSpan(
                              text: text,
                              style: TextStyle(
                                // color: AppColor.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      );
  }
}
