import 'package:calendar/index.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/SignUp-screen";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  var _isLoading = false;
  String message = "";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      isLoading: _isLoading,
      children: [
        Expanded(
            child: SizedBox(
          height: 1,
        )),
        Container(
            width: double.infinity,
            child: Text(
              "Hello there!",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Raleway"),
            )),
        SizedBox(
          height: 12,
        ),
        Container(
            width: double.infinity,
            child: Text(
              "Welcome ",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Raleway"),
            )),
        SizedBox(
          height: 5,
        ),
        Container(
            width: double.infinity,
            child: Text(
              " Sign up to continue ",
              style: TextStyle(
                  fontSize: 15,
                  color: AppColor.grey.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Raleway"),
            )),
        Expanded(
            child: SizedBox(
          height: 1,
        )),
        LoginTextField(
          controller: username,
          icon: Icons.account_circle,
          hint: "Email",
        ),
        SizedBox(
          height: 10,
        ),
        LoginTextField(
          controller: password,
          isObscure: true,
          icon: Icons.lock_rounded,
          hint: "New Password",
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 20,
        ),
        CustomButton(
          func: () async {
            final cred = Provider.of<Credential>(context, listen: false);
            FocusScope.of(context).requestFocus(FocusNode());
            if (password.text == "" || username.text == "") {
              CommonWidgets.showToast(context, "Enter email & Password",
                  duration: 3);
              return;
            }
            setState(() {
              _isLoading = true;
            });
            final response =
                await Provider.of<LoginProvider>(context, listen: false).signup(
                    LoginModel(
                        password: password.text, userName: username.text));

            setState(() {
              _isLoading = false;
            });
            CommonWidgets.showToast(context, response.message);
            if (response.isSuccess) {
              await cred.storeUserData(username.text);
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          },
          isLoading: false,
          text: "Sign up",
        ),
        Expanded(
            flex: 3,
            child: SizedBox(
              height: 1,
            )),
      ],
    );
  }
}
