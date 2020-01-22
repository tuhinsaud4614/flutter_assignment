import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'screens/auth_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Authentication',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: auth.isAuth
              ? UserProfileScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snaphot) {
                    if (snaphot.connectionState == ConnectionState.waiting) {
                      return SplashScreen();
                    } else {
                      return AuthScreen();
                    }
                  },
                ),
          // home: UserProfileScreen(),
        ),
      ),
    );
  }
}
