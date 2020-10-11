import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
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
          builder: (_, child) => Portal(child: child),
          title: 'Trade talkies',
          debugShowCheckedModeBanner: false,
          theme: basicTheme(),
          home: auth.isAuth
          ?SplashScreen(isAuth: true,)
              // ? HomeScreen(selectedIndex: 0,fromPost: false,)
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) => SplashScreen(isAuth: false,)
                      // authResultSnapshot.connectionState ==
                      //         ConnectionState.waiting
                      //     ? SplashScreen()
                      //     : Auth(),
                ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
//by sarthak bhatnagar