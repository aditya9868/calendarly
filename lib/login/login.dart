import 'package:calendar/index.dart';
import 'package:calendar/login/signup.dart';

class Login extends StatefulWidget {
  static const routeName = "/login-screen";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              "Welcome back",
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
              " Sign in to continue ",
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
          hint: "Username",
        ),
        SizedBox(
          height: 10,
        ),
        LoginTextField(
          controller: password,
          isObscure: true,
          icon: Icons.lock_rounded,
          hint: "Password",
        ),
        SizedBox(
          height: 25,
        ),
        CustomButton(
          func: () async {
            final cred = Provider.of<Credential>(context, listen: false);
            FocusScope.of(context).requestFocus(FocusNode());
            if (password.text == "" || username.text == "") {
              CommonWidgets.showToast(context, "Enter username & Password/OTP",
                  duration: 3);
              return;
            }
            setState(() {
              _isLoading = true;
            });
            final response =
                await Provider.of<LoginProvider>(context, listen: false).login(
                    LoginModel(
                        password: password.text, userName: username.text));

            setState(() {
              _isLoading = false;
            });
            CommonWidgets.showToast(context, response.message);
            if (response.isSuccess) {
              await cred.storeUserData(username.text);
            }
          },
          isLoading: false,
          text: "LOGIN",
        ),
        SizedBox(
          height: 35,
        ),
        InkWell(
          onTap: () async {
            CommonWidgets.push(context, SignUp());
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: AppColor.cyan,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "Raleway"),
          ),
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
