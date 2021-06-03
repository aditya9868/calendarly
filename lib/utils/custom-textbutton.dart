import 'package:calendar/index.dart';
class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: AppColor.grey.withOpacity(0.3)))),
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ));
  }
}

