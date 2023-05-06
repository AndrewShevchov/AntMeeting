import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:stream/db/db_helper.dart';
import 'package:stream/providers/user_provider.dart';
import 'package:stream/resources/auth_methods.dart';
import 'package:stream/screens/home_screen.dart';
import 'package:stream/screens/login_screen.dart';
import 'package:stream/screens/onboarding_screen.dart';
import 'package:stream/screens/signup_screen.dart';
import 'package:stream/screens/verify_email_screen.dart.dart';
import 'package:stream/utils/colors.dart';
import 'package:stream/utils/theme.dart';
import 'package:stream/widgets/loading_indicator.dart';
import 'package:stream/widgets/theme_sevices.dart';
import 'models/user.dart' as model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AntMeeting',
      theme: Themes(context).lightMode,
      darkTheme: Themes(context).darkMode,
      themeMode: ThemeService().theme,
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen()
      },
      home: FutureBuilder(
        future: AuthMethods()
            .getCurrentUser(FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null)
            .then((value) {
          if (value != null) {
            Provider.of<UserProvider>(context, listen: false).setUser(
              model.User.fromMap(value),
            );
          }
          return value;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }

          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const OnboardingScreen();
        },
      ),
    );
  }
}
