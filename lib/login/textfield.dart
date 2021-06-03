import 'package:calendar/index.dart';
class LoginTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isObscure;
  const LoginTextField({
    Key key,
    this.icon,
    this.hint, this.controller, this.isObscure=false, this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
      color: AppColor.grey.withOpacity(0.1)),
      height: 45,
      padding: const EdgeInsets.only(right: 15),
      child: TextField(
        obscureText:isObscure ,
        inputFormatters: [
          LengthLimitingTextInputFormatter(50),
        ],
        cursorColor: AppColor.cyan,
        keyboardType: keyboardType,
       
        controller: controller,textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 20, 10),
          prefixIcon: Icon(
      icon,
      size: 20,
      color: AppColor.cyan,
      ),
          
          hintText: hint,
          hintStyle: TextStyle(
              color: AppColor.grey,
              fontSize: 14,
              fontWeight: FontWeight.w300),
          
          border: InputBorder.none,
        ),
      ),
    );
  }
}