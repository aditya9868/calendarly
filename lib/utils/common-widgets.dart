import 'package:flutter/gestures.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:calendar/index.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonWidgets {
  static showToast(BuildContext context, String message, {int duration}) {
    return Toast.show(message, context,
        gravity: Toast.BOTTOM, duration: duration ?? Toast.LENGTH_SHORT);
  }

  static push(BuildContext context, Widget route) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => route, fullscreenDialog: true),
    );
  }

  static int getColorFromHex(String hexColor) {
    hexColor = hexColor
        .toUpperCase()
        .replaceAll('#', '')
        .substring(hexColor.length - 1, hexColor.length);
    if (hexColor.length >= 6) {
      hexColor = 'FF' + hexColor;
    }
    List<int> p = [
      0xFFe84a5f,
      0xFFff847c,
      0xFFff7b54,
      0xFFffb26b,
      0xFFffe05d,
      0xFFe4e978,
      0xFF8fd9a8,
      0xFF28b5b5,
      0xFF2978b5,
      0xFF0061a8
    ];
    return p[hexColor.codeUnits[0] % p.length] +
        2 * int.parse(hexColor, radix: 16);
  }

  static String convertAnyStringToHex(String hexColor) {
    final p = hexColor.split('');
    for (var i = 0; i < hexColor.length; i++) {
      switch (p[i].codeUnits[0] % 16) {
        case 10:
          p[i] = 'a';
          break;
        case 11:
          p[i] = 'b';
          break;
        case 12:
          p[i] = 'c';
          break;
        case 13:
          p[i] = 'd';
          break;
        case 14:
          p[i] = 'e';
          break;
        case 15:
          p[i] = 'f';
          break;

        default:
          p[i] = (p[i].codeUnits[0] % 16).toString();
      }
    }
    hexColor = p.join();
    return hexColor;
  }

  static DateTime convertTimeOfDay(TimeOfDay t, {DateTime p}) {
    var now = new DateTime.now();
    if (p != null) {
      now = p;
    }
    return new DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  static String convertToTime(num t) {
    String p = "";
    try {
      final date = DateTime.fromMicrosecondsSinceEpoch(t.toInt());
      p = DateFormat('hh:mm aaa').format(date);
    } catch (e) {}
    return p;
  }

  static String convertToDate(String date) {
    var s = "";
    print("date");
    print(date);
    try {
      final p = DateTime.parse(date);
      s = DateFormat('MMM  dd, yyyy').format(p);
    } catch (e) {}

    return s;
  }

  static String convertToDatefromSec(int date) {
    var s = "";

    try {
      final p = DateTime.fromMicrosecondsSinceEpoch(date);
      s = DateFormat('MMM  dd, yyyy').format(p);
    } catch (e) {}

    return s;
  }
  static String convertToFormatedDate(int date) {
      var s = "";

    try {
      final p = DateTime.fromMicrosecondsSinceEpoch(date);
      s = DateFormat('MMM  dd, yyyy hh:mm aaa').format(p);
    } catch (e) {}

    return s;
    
  }

  static String checkNull(String p) {
    if (p == null) return "";

    return p;
  }

  static checkUserName(BuildContext context, String phone) {
    String pattern = r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]';

    RegExp regex = new RegExp(pattern);
    if (phone.length == 0) {
      FocusScope.of(context).unfocus();
      showToast(context, "Enter Username", duration: 2);
      return false;
    } else if (regex.hasMatch(phone)) {
      FocusScope.of(context).unfocus();
      showToast(context, "Username only includes alphabets and numbers",
          duration: 3);
      return false;
    }
    return true;
  }

  static launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  static RichText getLinkableText(String text) {
    var urlPattern = r"(https?|http)://?";
    RegExp regex = new RegExp(urlPattern);
    List<String> text1;
    text1 = text.split(" ");

    return RichText(
      textAlign: TextAlign.left,

      text: new TextSpan(
          style: TextStyle(
            // color: AppColor.grey,
            fontWeight: FontWeight.w300,
            fontSize: 13,
          ),
          children: text1.map((e) {
            if (regex.hasMatch(e)) {
              return TextSpan(
                text: e + " ",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    launch(e);
                  },
              );
            } else {
              return TextSpan(
                text: e + " ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),

              );
            }
          }).toList()),
    );
  }
   static shareMessage(
    String message,
  ) async {
    print(message);
    try {
       await FlutterShare.share(
        title: 'Lead Details',
        text: message,
        
       );
    } catch (e) {
      print(e);
    }
  }
  static String checkValNull(String p, String q) {

    if (q == null || q=="") {
      return "";
    } else
      return "\n\n" + p.replaceAll(" ", "\t") + q.replaceAll(" ", "\t");
  }
}
// ^[A-Za-z-0-99999999'
