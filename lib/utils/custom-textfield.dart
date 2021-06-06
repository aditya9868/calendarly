import 'package:calendar/index.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final TextAlign textAlign;
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isObscure;
  final bool readOnly;
  final Widget suffix;
  final Function(String) onchange;
  const CustomTextField({
    Key key,
    this.icon,
    this.hint,
    this.controller,
    this.isObscure = false,
    this.keyboardType,
    this.textAlign = TextAlign.left,
    this.readOnly = false,
    this.onchange,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            child: Text(hint)),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColor.grey.withOpacity(0.1)),
          // height: 45,
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: TextField(
            obscureText: isObscure,
            inputFormatters: [
              LengthLimitingTextInputFormatter(150),
            ],
            onChanged: onchange,
            maxLines: null,
            readOnly: readOnly,
            cursorColor: AppColor.cyan,
            keyboardType: keyboardType,
            controller: controller,
            textAlign: textAlign,
            decoration: InputDecoration(
              suffixIcon: suffix,
              // suffixIconConstraints: ,
              // suffixStyle: ,
              suffixIconConstraints: BoxConstraints(
                  maxHeight: 24, maxWidth: 24, minHeight: 24, minWidth: 24),
              // ,icon: ,
              prefixIcon: icon == null
                  ? null
                  : Icon(
                      icon,
                      size: 20,
                      color: AppColor.cyan,
                    ),
              hintText: "Enter " + hint,
              hintStyle: TextStyle(
                  color: AppColor.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
