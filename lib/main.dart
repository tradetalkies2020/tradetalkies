import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// importing screens....from screen folder
import './screens/auth/sign_in.dart';
import './screens/home/home.dart';
import './screens/auth/auth.dart';
import './screens/splash_screen/splash_screen.dart';

// importing theme data file....
import './Theme/theme.dart';

// importing services file
import './services/auth/services.dart';

// main driver code....
void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

// page holdon and central provider package....
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          UserAuth _auth = UserAuth();
          return _auth;
        }),
      ],
      child: Consumer<UserAuth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Trade talkies',
          debugShowCheckedModeBanner: false,
          theme: basicTheme(),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : Auth(),
                ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
