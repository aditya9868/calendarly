import 'package:calendar/index.dart';
class CustomAppBar extends StatelessWidget {
  final String text;
  final bool showPrefix;
  final double fontSize;
  final IconButton suffix;
  const CustomAppBar({
    Key key,
    this.text, this.showPrefix=true, this.fontSize=22, this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height ,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                    showPrefix?Icon(Icons.close):Container(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height ,
              height: AppBar().preferredSize.height,
              child: suffix,
            )
          ],
        ),
      ),
    );
  }
}
