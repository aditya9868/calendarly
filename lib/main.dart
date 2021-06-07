import 'package:calendar/index.dart';

import 'package:calendar/screens/dashboard/dashboard-provider.dart';
import 'package:calendar/screens/profile/profile-provider.dart';
import 'package:calendar/screens/profile/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LoginProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Credential(),
        ),
        ChangeNotifierProxyProvider<Credential, CalendarProvider>(
            create: (context) => CalendarProvider(),
            update: (context, cred, _) => CalendarProvider(cred: cred)),
        ChangeNotifierProxyProvider<Credential, AddEventProvider>(
            create: (context) => AddEventProvider(),
            update: (context, cred, _) => AddEventProvider(cred: cred)),
        ChangeNotifierProxyProvider<Credential, DashboardProvider>(
            create: (context) => DashboardProvider(),
            update: (context, cred, _) => DashboardProvider(cred: cred)),
        ChangeNotifierProxyProvider<Credential, ProfileProvider>(
            create: (context) => ProfileProvider(),
            update: (context, cred, _) => ProfileProvider(cred: cred))
      ],
      child: Consumer<Credential>(
        builder: (context, cred, _) {
          // cred.logout();
          return FutureBuilder<bool>(
              future: cred.tryAutoLogin(),
              builder: (context, snapshot) {
                return MaterialApp(
                  theme: ThemeData(
                    fontFamily: "Raleway",
                    accentColor: AppColor.cyan,
                  ),
                  routes: {},
                  home: cred.isLogin
                      ? ManageUser()
                      : snapshot.connectionState == ConnectionState.waiting
                          ? LoadingScreen()
                          : Login(),
                );
              });
        },
      ),
    );
  }
}

class ManageUser extends StatelessWidget {
  const ManageUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Credential>(
      builder: (context, cred, _) {
        if (cred.userCredential.first == null) return EditProfile();
        return DashBoard();
      },
    );
  }
}
