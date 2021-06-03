import 'package:calendar/index.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Function func;
  const CustomButton(
      {Key key, @required this.func, @required this.text, this.isLoading=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0.5,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0)),
      padding: const EdgeInsets.all(0),
      onPressed: func,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.cyan,
          borderRadius: BorderRadius.circular(5),
        ),
        child: isLoading
            ? Center(
                child: Container(
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(AppColor.white),
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                                color: AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)
                // style: AppDecoration.button,
              ),
      ),
    );
  }
}
